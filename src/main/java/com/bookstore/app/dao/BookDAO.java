package com.bookstore.app.dao;

import com.bookstore.app.form.BookForm;
import com.bookstore.app.model.Book;
import com.bookstore.app.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.Valid;
import java.io.IOException;
import java.util.Base64;
import java.util.Optional;

@Repository
@Transactional
public class BookDAO {
    @Autowired
    protected BookRepository bookRepository;

    public void saveBook(@Valid BookForm bookForm) throws IOException {
        Book b = new Book();
        String fileName = StringUtils.cleanPath(bookForm.getImageFile().getOriginalFilename());
        if (fileName.contains("..")) {
            System.out.println("File is invalid!");
        }
        try {
            b.setIsbn(bookForm.getIsbn());
            b.setTitle(bookForm.getTitle());
            b.setAuthor(bookForm.getAuthor());
            b.setYear(bookForm.getYear());
            b.setPublisher(bookForm.getPublisher());
            b.setDescription(bookForm.getDescription());
            b.setPrice(bookForm.getPrice());
            if (bookForm.getImageFile() != null) {
                String image = null;
                try {
                    image = Base64.getEncoder().encodeToString(bookForm.getImageFile().getBytes());
                } catch (IOException e) {
                    e.printStackTrace();
                }
                if (image != null) {
                    b.setImage(image);
                }
            }
            this.bookRepository.save(b);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Book getBookById(long id) {
        Optional<Book> optional = bookRepository.findById(id);
        Book book = null;
        if (optional.isPresent()) {
            book = optional.get();
        } else {
            throw new RuntimeException("Book was not found for id :: " + id);
        }
        return book;
    }

    public void deleteBookById(long id) {
        this.bookRepository.deleteById(id);
    }
}
