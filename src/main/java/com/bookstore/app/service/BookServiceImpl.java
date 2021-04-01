package com.bookstore.app.service;


import java.io.IOException;
import java.util.Base64;
import java.util.List;
import java.util.Optional;
//import com.bookstore.app.form.BookForm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import com.bookstore.app.model.Book;
import com.bookstore.app.repository.BookRepository;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.transaction.Transactional;

@Service
public class BookServiceImpl implements BookService {

    private MultipartFile imageFile;

    public MultipartFile getImageFile() {
        return imageFile;
    }
    public void setImageFile(MultipartFile imageFile) {
        this.imageFile = imageFile;
    }

    @Autowired
    protected BookRepository bookRepository;

    @Override
    public List<Book> findByOrderByIdDesc() {
        return bookRepository.findAll(Sort.by(Sort.Direction.DESC, "id"));
    }

    /* public void saveBook(BookForm bookForm) { } */

    /* String fileName = StringUtils.cleanPath(bookForm.getImageFile().getOriginalFilename()); */

    /*  b.setImage(Base64.getEncoder().encodeToString(bookForm.getImageFile().getBytes())); */

    /*  b.setId(book.getId());
            b.setIsbn(bookForm.getIsbn());
            b.setTitle(bookForm.getTitle());
            b.setAuthor(bookForm.getAuthor());
            b.setYear(bookForm.getYear());
            b.setPublisher(bookForm.getPublisher());
            b.setDescription(bookForm.getDescription());
            b.setPrice(bookForm.getPrice()); */

    @Override
    @Transactional
    public void saveImageFile(MultipartFile imageFile) {
        Book b = new Book();
        String fileName = StringUtils.cleanPath(imageFile.getOriginalFilename());
        if (fileName.contains("..")) {
            System.out.println("file is invalid");
        }
        try {
            b.setImage(Base64.getEncoder().encodeToString(imageFile.getBytes()));

    } catch (IOException e) {
        e.printStackTrace();
    }
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
