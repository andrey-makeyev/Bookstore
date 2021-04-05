package com.bookstore.app.dao;

import com.bookstore.app.form.BookForm;
import com.bookstore.app.model.Book;
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

@Repository
@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
public class BookDAO extends BookForm {

    @Autowired
    private SessionFactory sessionFactory;

    public Book findIsbn(String isbn) {
        try {
            String findIsbnQuery = "SELECT b FROM " + Book.class.getName() + " b WHERE b.isbn =:isbn ";

            Session session = this.sessionFactory.getCurrentSession();
            Query<Book> query = session.createQuery(findIsbnQuery, Book.class);
            query.setParameter("isbn", isbn);
            query.setMaxResults(1).uniqueResult();
            return (Book) query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Autowired
    protected BookRepository bookRepository;

    public void saveBook(BookForm bookForm) throws IOException {
        Session session = this.sessionFactory.getCurrentSession();

        long id = bookForm.getId();
        String isbn = bookForm.getIsbn();

        Book book = null;

        boolean isNew = false;

        if (isbn != null) {
            book = this.findIsbn(isbn);
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
                session.save(book);
            }

            session.clear();
            this.bookRepository.save(book);

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