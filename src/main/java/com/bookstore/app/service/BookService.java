package com.bookstore.app.service;

import org.springframework.data.domain.Page;
import com.bookstore.app.entity.Book;

public interface BookService {

    Page<Book> getAllBooksPageable(int pageNumber, String sortColumn, String sortOrder, String keyword);

}