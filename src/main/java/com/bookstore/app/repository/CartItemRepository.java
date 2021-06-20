package com.bookstore.app.repository;

import com.bookstore.app.entity.CartItem;
import com.bookstore.app.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CartItemRepository extends JpaRepository<CartItem, Integer> {

    public List<CartItem> findByOrder(Order order);



}
