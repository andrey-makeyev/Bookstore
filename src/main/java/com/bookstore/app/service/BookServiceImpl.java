package com.bookstore.app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import com.bookstore.app.model.Book;
import com.bookstore.app.repository.BookRepository;

@Service
public class BookServiceImpl implements BookService {

    @Autowired
    protected BookRepository bookRepository;

    @Override
    public Page<Book> page(int pageNo, int pageSize) {
        return this.bookRepository.findAll(PageRequest.of(pageNo - 1, pageSize, Sort.by(Sort.Direction.DESC, "id")));
    }
}
