package com.bookstore.app.model;

import java.math.BigDecimal;

public class OrderDetailInfo {
    private Integer id;

    private String bookIsbn;
    private String bookTitle;

    private int quantity;
    private double price;
    private double amount;

    public OrderDetailInfo() {

    }

    // Using for JPA/Hibernate Query.
    public OrderDetailInfo(Integer id, String bookIsbn, //
                           String bookTitle, int quantity, double price, double amount) {
        this.id = id;
        this.bookIsbn = bookIsbn;
        this.bookTitle = bookTitle;
        this.quantity = quantity;
        this.price = price;
        this.amount = amount;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBookIsbn() {
        return bookIsbn;
    }

    public void setBookIsbn(String bookIsbn) {
        this.bookIsbn = bookIsbn;
    }

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }
}
