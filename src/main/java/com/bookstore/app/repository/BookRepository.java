package com.bookstore.app.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.bookstore.app.model.Book;

@Repository
public interface BookRepository extends JpaRepository<Book, Long> {
    @Query("SELECT b FROM Book b WHERE CONCAT(b.title, ' ', b.author) LIKE %?1%")
    Page<Book> findBooksByKeywordPageable(String keyword, Pageable pageable);


  //  Pageable pageable = PageRequest.of(0, 5);
   //     @Query("SELECT b FROM Book b WHERE CONCAT(b.title, ' ', b.author) LIKE %?1%")
  // @Query("SELECT b FROM Book b WHERE "
   //        + "CONCAT(b.title, b.author)" + " LIKE %?1%")

  //  List<Book> findBooksByKeywordPageable(@Param("keyword") String keyword);
      //  List<Book> findBooksByKeywordPageable(String keyword);

  //  @Query("SELECT a FROM Author a WHERE (:name is null or a.name = :name)
  //  Page<Book> findBooksByAuthor(@Param("author") String author, Pageable pageable);

}
