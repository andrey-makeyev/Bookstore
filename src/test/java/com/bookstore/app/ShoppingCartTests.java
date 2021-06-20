package com.bookstore.app;

import com.bookstore.app.entity.Book;
import com.bookstore.app.entity.CartItem;
import com.bookstore.app.entity.Order;
import com.bookstore.app.repository.CartItemRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
import org.springframework.test.annotation.Rollback;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

@DataJpaTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@Rollback(value = false)
public class ShoppingCartTests {

    @Autowired
    private CartItemRepository cartItemRepository;

    @Autowired
    private TestEntityManager entityManager;

    @Test
    public void TestAddOneCartItem() {
        Book book = entityManager.find(Book.class, 1);
        Order order = entityManager.find(Order.class, 1);

        CartItem newItem = new CartItem();
        newItem.setOrder(order);
        newItem.setBook(book);
        newItem.setQuantity(1);

        CartItem savedCartItem = cartItemRepository.save(newItem);

        //assertTrue(savedCartItem.getId() > 0);
    }

    @Test
    public void TestGetCartItemsByOrder() {
        Order order = new Order();
       // order.setId(5);

        List<CartItem> cartItems = cartItemRepository.findByOrder(order);

        assertEquals(1, cartItems.size());

    }

}
