package com.bookstore.app.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.bookstore.app.entity.Book;

@Repository
public interface BookRepository extends JpaRepository<Book, Integer> {
    // @Query("SELECT b FROM Book b WHERE "
    //        + "CONCAT(b.title, b.author)" + " LIKE %?1%")
    @Query("SELECT b FROM Book b WHERE CONCAT(b.title, ' ', b.author) LIKE %?1%")
    Page<Book> findBooksByKeywordPageable(String keyword, Pageable pageable);

}
