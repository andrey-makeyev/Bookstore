package com.bookstore.app.service;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Base64;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import com.bookstore.app.model.Book;
import com.bookstore.app.repository.BookRepository;
import org.springframework.util.StringUtils;
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
    public void saveBook(long id, MultipartFile file,
                         String isbn,
                         String title,
                         String author,
                         Integer year,
                         String publisher,
                         String description,
                         BigDecimal price) {

        Book b = new Book();
        String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        if (fileName.contains("..")) {
            System.out.println("file is invalid");
        }
        try {
            b.setImage(Base64.getEncoder().encodeToString(file.getBytes()));
        } catch (IOException e) {
            e.printStackTrace();
        }
        b.setId(id);
        b.setIsbn(isbn);
        b.setTitle(title);
        b.setAuthor(author);
        b.setYear(year);
        b.setPublisher(publisher);
        b.setDescription(description);
        b.setPrice(price);

        this.bookRepository.save(b);

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
    public Page<Book> page(int pageNo, int pageSize) {
        return this.bookRepository.findAll(PageRequest.of(pageNo - 1, pageSize, Sort.by(Sort.Direction.DESC, "id")));
    }

}
