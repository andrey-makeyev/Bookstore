package com.bookstore.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import com.bookstore.app.model.Book;
import com.bookstore.app.repository.BookRepository;
import org.springframework.web.multipart.MultipartFile;

@Service
public class BookServiceImpl implements BookService {

    @Autowired
    protected BookRepository bookRepository;

    @Override
    public List<Book> findByOrderByIdDesc() {
        return bookRepository.findAll(Sort.by(Sort.Direction.DESC, "id"));
    }

    @Override
    public Page<Book> page(int pageNo, int pageSize) {
        return this.bookRepository.findAll(PageRequest.of(pageNo - 1, pageSize, Sort.by(Sort.Direction.DESC, "id")));
    }

    private MultipartFile imageFile;

    public MultipartFile getImageFile() {
        return imageFile;
    }

    public void setImageFile(MultipartFile imageFile) {
        this.imageFile = imageFile;
    }
}
