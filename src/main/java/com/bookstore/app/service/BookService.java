package com.bookstore.app.service;

import java.util.List;

import org.springframework.data.domain.Page;
import com.bookstore.app.model.Book;

public interface BookService {

    List<Book> findByOrderByIdDesc();

    Page<Book> page(int pageNo, int pageSize);
}