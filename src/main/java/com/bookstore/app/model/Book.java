package com.bookstore.app.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.*;
import java.io.Serializable;

@Entity
@Table(name = "books")
public class Book implements Serializable {

    @Id
    @GeneratedValue(strategy =  GenerationType.IDENTITY)

    private long id;

    @Column(name = "title")
    @NotBlank(message = "Required!")
    private String title;

    @Column(name = "author")
    @NotBlank(message = "Required!")
    private String author;

    @Column(name = "publisher")
    @NotBlank(message = "Required!")
    private String publisher;

    @Column(name = "year")
    @NotNull(message = "Required!")
    @PositiveOrZero(message = "Only positive numbers!")
    @Min(value = 1377, message = "Must be from 1377 till 2021!")
    @Max(value = 2021, message = "Must be from 1377 till 2021!")
    private Integer year;

    @Column(name = "description")
    @NotBlank(message = "Required!")
    private String description;

    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
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

    }

