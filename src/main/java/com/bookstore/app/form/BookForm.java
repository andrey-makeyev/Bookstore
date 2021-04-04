package com.bookstore.app.form;

import com.bookstore.app.model.Book;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.*;
import java.math.BigDecimal;

public class BookForm {

    private long id;

    @NotBlank(message = "Required!")
    private String isbn;
    @NotBlank(message = "Required!")
    private String title;
    @NotBlank(message = "Required!")
    private String author;
    @NotBlank(message = "Required!")
    private String publisher;
    @NotNull(message = "Required!")
    @PositiveOrZero(message = "Only positive numbers!")
    @Min(value = 1377, message = "Must be from 1377 till 2021!")
    @Max(value = 2021, message = "Must be from 1377 till 2021!")
    private Integer year;
    @NotBlank(message = "Required!")
    private String description;
    @NotNull(message = "Required!")
    @PositiveOrZero(message = "Only positive numbers!")
    private BigDecimal price;

    private MultipartFile imageFile;

    public BookForm(Book book) {
        this.id = book.getId();
        this.isbn = book.getIsbn();
        this.title = book.getTitle();
        this.author = book.getAuthor();
        this.publisher = book.getPublisher();
        this.year = book.getYear();
        this.description = book.getDescription();
        this.price = book.getPrice();
    }

    public BookForm() {
        this.id = getId();
        this.isbn = getIsbn();
        this.title = getTitle();
        this.author = getAuthor();
        this.publisher = getPublisher();
        this.year = getYear();
        this.description = getDescription();
        this.price = getPrice();
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
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

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public MultipartFile getImageFile() {
        return imageFile;
    }

    public void setImageFile(MultipartFile imageFile) {
        this.imageFile = imageFile;
    }

}