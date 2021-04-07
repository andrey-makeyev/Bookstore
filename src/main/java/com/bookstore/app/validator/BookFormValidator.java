package com.bookstore.app.validator;

import com.bookstore.app.dao.BookDAO;
import com.bookstore.app.model.Book;
import com.bookstore.app.form.BookForm;
import com.bookstore.app.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

@Component
public class BookFormValidator implements Validator {

    @Autowired
    private BookDAO bookDAO;

    @Autowired
    private BookRepository bookRepository;

    protected BookFormValidator bookFormValidator;

    @InitBinder
    public void myInitBinder(WebDataBinder dataBinder) {
        Object target = dataBinder.getTarget();
        if (target == null) {
            return;
        }
        System.out.println("Target=" + target);
        if (target.getClass() == BookForm.class) {
            dataBinder.setValidator(bookFormValidator);
        }
    }

    @Override
    public boolean supports(Class<?> clazz) {
        return clazz == BookForm.class;
    }

    @Override
    public void validate(Object target, Errors errors) {
        BookForm bookForm = (BookForm) target;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "isbn", "NotEmpty.bookForm.isbn");

        String isbn = bookForm.getIsbn();
        if (isbn != null && isbn.length() > 0) {
            if (bookForm.isNewBook()) {
                Book book = bookDAO.findIsbn(isbn);
                if (book != null) {
                    errors.rejectValue("isbn", "Duplicate.bookForm.isbn");
                }
                //    if(bookDAO.findIsbn(isbn).toString().equals(bookForm.getIsbn())) {
                //  errors.rejectValue("isbn", "Duplicate.bookForm.isbn");
                //    }
            }
        }
    }
}