package com.bookstore.app.model;

import com.bookstore.app.entity.Book;

import java.math.BigDecimal;

public class BookInfo extends Book {
    private String isbn;
    private String title;
    private double price;
    private String image;

    public BookInfo() {
    }

    public BookInfo(Book book) {
        this.isbn = book.getIsbn();
        this.title = book.getTitle();
        this.price = book.getPrice();
        this.image = book.getImage();

    }

    // Using in JPA/Hibernate query
    public BookInfo(String isbn, String title, double price, String image) {
        this.isbn = isbn;
        this.title = title;
        this.price = price;
        this.image = image;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
