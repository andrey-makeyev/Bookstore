package com.bookstore.app.service;

import java.math.BigDecimal;
import java.util.List;

//import com.bookstore.app.form.BookForm;
import org.springframework.data.domain.Page;
import com.bookstore.app.model.Book;
import org.springframework.web.multipart.MultipartFile;

public interface BookService {

    List<Book> findByOrderByIdDesc();

    Book getBookById(long id);

    void deleteBookById(long id);

    /* void saveBook(BookForm bookForm); */

    void saveBook(long id, MultipartFile imageFile,
                  String isbn,
                  String title,
                  String author,
                  Integer year,
                  String publisher,
                  String description,
                  BigDecimal price);

    Page<Book> page(int pageNo, int pageSize);
}

