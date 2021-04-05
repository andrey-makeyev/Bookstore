package com.bookstore.app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import com.bookstore.app.model.Book;
import com.bookstore.app.repository.BookRepository;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@Service
public class BookServiceImpl implements BookService {

    @Autowired
    protected BookRepository bookRepository;

    @Override
    public Page<Book> getAllBooksPageable(int pageNumber, String sortColumn, String sortOrder, String keyword) {

        Pageable pageable = PageRequest.of(pageNumber - 1, 50,
                sortOrder.equals("ascending") ? Sort.by(sortColumn).ascending()
                        : Sort.by(sortColumn).descending());

        if (keyword != null) {
            return this.bookRepository.findBooksByKeywordPageable(keyword, pageable);
        }

        return this.bookRepository.findAll(pageable);
    }
}

 //   @Override
 //   public Page<Book> getAllBooksPageable(int pageNo, int pageSize) {
 //       int pageSize = 5;
 //       return this.bookRepository.findAll(PageRequest.of(pageNo - 1, pageSize, Sort.by(Sort.Direction.DESC, "id")));
 //   }







