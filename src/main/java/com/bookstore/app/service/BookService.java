package com.bookstore.app.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.bookstore.app.model.Book;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface BookService {
    List<Book> getAllBooks();

    void saveBook(Book book);

    Book getBookById(long id);

    void deleteBookById(long id);

    Page<Book> pager(int pageNo, int pageSize);
}

