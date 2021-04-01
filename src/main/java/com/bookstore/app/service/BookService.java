package com.bookstore.app.service;

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
    void saveImageFile(MultipartFile imageFile);

    Page<Book> page(int pageNo, int pageSize);
}