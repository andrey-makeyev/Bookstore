package com.bookstore.app.service;

import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.bookstore.app.model.Book;
import com.bookstore.app.repository.BookRepository;

@Service
public class BookServiceImpl implements BookService {

    @Autowired
    protected BookRepository bookRepository;

    @Override
    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    @Override
    public void saveBook(Book book) {
        this.bookRepository.save(book);
    }

    @Override
    public Book getBookById(long id) {
        Optional<Book> optional = bookRepository.findById(id);
        Book book = null;
        if (optional.isPresent()) {
            book = optional.get();
        } else {
            throw new RuntimeException(" Book not found for id :: " + id);
        }
        return book;
    }

    @Override
    public void deleteBookById(long id) {
        this.bookRepository.deleteById(id);
    }

    @Override
    public Page<Book> pager(int pageNo, int pageSize) {
        Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
        return this.bookRepository.findAll(pageable);
    }
}
