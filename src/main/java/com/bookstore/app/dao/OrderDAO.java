package com.bookstore.app.dao;

import com.bookstore.app.entity.CartItem;
import com.bookstore.app.entity.Order;
import com.bookstore.app.entity.Book;
import com.bookstore.app.model.*;
import com.bookstore.app.pagination.Pagination;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Transactional
@Repository
public class OrderDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Autowired
    private BookDAO bookDAO;

    private int getMaxOrderNumber() {
        String sql = "Select max(o.orderNumber) from " + Order.class.getName() + " o ";
        Session session = this.sessionFactory.getCurrentSession();
        Query<Integer> query = session.createQuery(sql, Integer.class);
        Integer value = (Integer) query.getSingleResult();
        if (value == null) {
            return 0;
        }
        return value;
    }

    @Transactional(noRollbackFor = Exception.class)
    public void saveOrder(CartInfo cartInfo) {
        Session session = this.sessionFactory.getCurrentSession();

        int orderNumber = this.getMaxOrderNumber() + 1;
        Order order = new Order();

        order.setOrderNumber(orderNumber);
        order.setOrderDate(new Date());
        order.setAmount(cartInfo.getAmountTotal());

        CustomerInfo customerInfo = cartInfo.getCustomerInfo();
        order.setCustomerName(customerInfo.getName());
        order.setCustomerEmail(customerInfo.getEmail());
        order.setCustomerPhone(customerInfo.getPhone());
        order.setCustomerAddress(customerInfo.getAddress());

        session.persist(order);

        List<CartLineInfo> lines = cartInfo.getCartLines();

        for (CartLineInfo line : lines) {
            CartItem detail = new CartItem();
            detail.setOrder(order);
            detail.setAmount(line.getAmount());
            detail.setPrice(line.getBookInfo().getPrice());
            detail.setQuantity(line.getQuantity());

            String isbn = line.getBookInfo().getIsbn();
            Book book = this.bookDAO.findBook(isbn);
            detail.setBook(book);

            session.persist(detail);
        }

        cartInfo.setOrderNumber(orderNumber);
        session.flush();
    }

    public Pagination<OrderInfo> listOrderInfo(int page, int maxResult, int maxNavigationPage) {
        String sql = "Select new " + OrderInfo.class.getName()//
                + "(ord.id, ord.orderDate, ord.orderNumber, ord.amount, "
                + " ord.customerName, ord.customerAddress, ord.customerEmail, ord.customerPhone) " + " from "
                + Order.class.getName() + " ord "//
                + " order by ord.orderNumber desc";

        Session session = this.sessionFactory.getCurrentSession();
        Query<OrderInfo> query = session.createQuery(sql, OrderInfo.class);
        return new Pagination<OrderInfo>(query, page, maxResult, maxNavigationPage);
    }

    public Order findOrder(Integer orderId) {
        Session session = this.sessionFactory.getCurrentSession();
        return session.find(Order.class, orderId);
    }

    public OrderInfo getOrderInfo(Integer orderId) {
        Order order = this.findOrder(orderId);
        if (order == null) {
            return null;
        }
        return new OrderInfo(order.getId(), order.getOrderDate(), //
                order.getOrderNumber(), order.getAmount(), order.getCustomerName(), //
                order.getCustomerAddress(), order.getCustomerEmail(), order.getCustomerPhone());
    }

    public List<OrderDetailInfo> listOrderDetailInfos(Integer orderId) {
        String sql = "Select new " + OrderDetailInfo.class.getName() //
                + "(d.id, d.book.isbn, d.book.title , d.quantity, d.price, d.amount) "//
                + " from " + CartItem.class.getName() + " d "//
                + " where d.order.id = :orderId ";

        Session session = this.sessionFactory.getCurrentSession();
        Query<OrderDetailInfo> query = session.createQuery(sql, OrderDetailInfo.class);
        query.setParameter("orderId", orderId);

        return query.getResultList();
    }

}