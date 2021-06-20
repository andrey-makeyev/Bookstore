package com.bookstore.app.dao;

import com.bookstore.app.form.BookForm;
import com.bookstore.app.entity.Book;
import com.bookstore.app.model.BookInfo;
import com.bookstore.app.pagination.PaginationResult;
import com.bookstore.app.repository.BookRepository;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.util.StringUtils;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.NoResultException;
import java.io.IOException;
import java.util.Base64;
import java.util.Optional;


@Transactional
@Repository
public class BookDAO extends BookForm {

    @Autowired
    private SessionFactory sessionFactory;

    public Book findBook(String isbn) {
        try {
            String findIsbnQuery = "SELECT b FROM " + Book.class.getName() + " b WHERE b.isbn =:isbn ";

            Session session = this.sessionFactory.getCurrentSession();
            Query<Book> query = session.createQuery(findIsbnQuery, Book.class);
            query.setParameter("isbn", isbn);
            //query.setMaxResults(1).uniqueResult();
            return (Book) query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public BookInfo findBookInfo(String isbn) {
        Book book = this.findBook(isbn);
        if (book == null) {
            return null;
        }
        return new BookInfo(book.getIsbn(), book.getTitle(), book.getPrice(), book.getImage());
    }

    @Autowired
    private BookRepository bookRepository;

    @Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
    public void saveBook(BookForm bookForm) throws IOException {
        Session session = this.sessionFactory.getCurrentSession();

        Integer id = bookForm.getId();
        String isbn = bookForm.getIsbn();

        Book book = null;

        boolean isNew = false;

        if (isbn != null) {
            book = this.findBook(isbn);
        }
        if (book == null) {
            isNew = true;
            book = new Book();
        }

        try {
            book.setId(id);
            book.setIsbn(isbn);
            book.setTitle(bookForm.getTitle());
            book.setAuthor(bookForm.getAuthor());
            book.setYear(bookForm.getYear());
            book.setPublisher(bookForm.getPublisher());
            book.setDescription(bookForm.getDescription());
            book.setPrice(bookForm.getPrice());

            String fileName = StringUtils.cleanPath(bookForm.getImageFile().getOriginalFilename());
            if (fileName.contains("..")) {
                System.out.println("File is invalid!");
            }
            if (bookForm.getImageFile() != null) {
                String image = null;
                try {
                    image = Base64.getEncoder().encodeToString(bookForm.getImageFile().getBytes());
                } catch (IOException e) {
                    e.printStackTrace();
                }
                if (image != null) {
                    book.setImage(image);
                }
            }

            if (isNew) {
                session.persist(book);
            }
            session.flush();
            //this.bookRepository.save(book);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Book getBookById(Integer id) {
        Optional<Book> optional = bookRepository.findById(id);
        Book book = null;
        if (optional.isPresent()) {
            book = optional.get();
        } else {
            throw new RuntimeException("Book was not found for id " + id);
        }
        return book;
    }

    public void deleteBookById(Integer id) {
        this.bookRepository.deleteById(id);
    }

    public PaginationResult<BookInfo> queryBooks(int page, int maxResult, int maxNavigationPage,
                                                 String likeName) {
        String sql = "Select new " + BookInfo.class.getName() //
                + "(p.isbn, p.title, p.price) " + " from "//
                + Book.class.getName() + " p ";
        if (likeName != null && likeName.length() > 0) {
            sql += " Where lower(p.name) like :likeName ";
        }
        sql += " order by p.createDate desc ";
        //
        Session session = this.sessionFactory.getCurrentSession();
        Query<BookInfo> query = session.createQuery(sql, BookInfo.class);

        if (likeName != null && likeName.length() > 0) {
            query.setParameter("likeName", "%" + likeName.toLowerCase() + "%");
        }
        return new PaginationResult<BookInfo>(query, page, maxResult, maxNavigationPage);
    }

    public PaginationResult<BookInfo> queryBooks(int page, int maxResult, int maxNavigationPage) {
        return queryBooks(page, maxResult, maxNavigationPage, null);
    }


}