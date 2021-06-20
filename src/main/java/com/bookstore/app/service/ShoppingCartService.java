package com.bookstore.app.service;

import com.bookstore.app.entity.CartItem;
import com.bookstore.app.entity.Order;
import com.bookstore.app.repository.CartItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShoppingCartService {

    @Autowired
    private CartItemRepository cartItemRepository;

    public List<CartItem> listCartItems(Order order) {
        return cartItemRepository.findByOrder(order);
    }
}
