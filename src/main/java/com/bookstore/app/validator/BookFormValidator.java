package com.bookstore.app.validator;

import com.bookstore.app.dao.BookDAO;
import com.bookstore.app.model.Book;
import com.bookstore.app.form.BookForm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

@Component
public class BookFormValidator implements Validator {

    /*protected BookFormValidator bookFormValidator;

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
    }*/

    @Autowired
    private BookDAO bookDAO;

    @Override
    public boolean supports(Class<?> clazz) {
        return clazz == BookForm.class;
    }

    @Override
    public void validate(Object target, Errors errors) {
        BookForm bookForm = (BookForm) target;

        /*ValidationUtils.rejectIfEmptyOrWhitespace(errors, "isbn", "NotEmpty.bookForm.isbn");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "NotEmpty.bookForm.title");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "author", "NotEmpty.bookForm.author");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "publisher", "NotEmpty.bookForm.publisher");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "year", "NotEmpty.bookForm.year");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "description", "NotEmpty.bookForm.description");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "price", "NotEmpty.bookForm.price");*/

        String isbn = bookForm.getIsbn();
        if (isbn != null && isbn.length() > 0) {
            if (bookForm.isNewBook()) {
                Book book = bookDAO.findIsbn(isbn);
                    if (book != null) {
                    errors.rejectValue("isbn", "Duplicate.bookForm.isbn");
                }
            }
        }
    }
}

