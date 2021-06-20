package com.bookstore.app.form;

import com.bookstore.app.entity.Book;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.Id;
import javax.validation.Valid;
import javax.validation.constraints.*;
import java.math.BigDecimal;

public class BookForm {

    private Integer id;

    @Valid
    @NotBlank(message = "Required field!")
    private String isbn;

    @NotBlank(message = "Required field!")
    private String title;

    @NotBlank(message = "Required field!")
    private String author;

    @NotBlank(message = "Required field!")
    private String publisher;

    @NotNull(message = "Required field!")
    @PositiveOrZero(message = "Only positive numbers!")
    @Min(value = 1377, message = "Only from 1377 till 2021!")
    @Max(value = 2021, message = "Only from 1377 till 2021!")
    private Integer year;

    @NotBlank(message = "Required field!")
    private String description;

    @NotNull(message = "Required field!")
    @PositiveOrZero(message = "Only positive numbers!")
    private double price;

    private MultipartFile imageFile;

    private boolean newBook = false;

    /*public BookForm() {
        this.newBook= true;
    }*/

    public BookForm() {
        this.id = getId();
        this.isbn = getIsbn();
        this.title = getTitle();
        this.author = getAuthor();
        this.publisher = getPublisher();
        this.year = getYear();
        this.description = getDescription();
        this.price = getPrice();
        this.imageFile = getImageFile();
        this.newBook = true;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public MultipartFile getImageFile() {
        return imageFile;
    }

    public void setImageFile(MultipartFile imageFile) {
        this.imageFile = imageFile;
    }

    public boolean isNewBook() {
        return newBook;
    }

    public void setNewBook(boolean newBook) {
        this.newBook = newBook;
    }

}