package com.bookstore.app.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.bookstore.app.dao.BookDAO;
import com.bookstore.app.form.BookForm;
import com.bookstore.app.repository.BookRepository;
import org.apache.commons.lang.exception.ExceptionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import com.bookstore.app.model.Book;
import com.bookstore.app.service.BookService;

import javax.validation.Valid;

@Controller
public class BookController {

    @Autowired
    private BookDAO bookDAO;

    @Autowired
    private BookService bookService;

    @Autowired
    protected BookRepository bookRepository;

    @RequestMapping(value = {"/"}, method = RequestMethod.GET)
    public String viewHomePage(Model model) {
        return pagination(1, model);
    }

    @GetMapping("/page/{pageNo}")
    public String pagination(@PathVariable(value = "pageNo") int pageNo, Model model) {
        int pageSize = 50;
        Page<Book> page = bookService.page(pageNo, pageSize);
        List<Book> listBooks = page.getContent();
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("totalBooks", page.getTotalElements());
        model.addAttribute("listBooks", listBooks);
        return "index";
    }

    @GetMapping("/viewBookDetails/{id}")
    public String viewBookDetails(@PathVariable(value = "id") long id, Model model) {
        Optional<Book> book = bookRepository.findById(id);
        ArrayList<Book> result = new ArrayList<>();
        book.ifPresent(result::add);
        model.addAttribute("book", result);
        return "bookDetails";
    }

    @GetMapping("/viewRegisterForm")
    public String viewRegisterForm(Model model) {
        BookForm bookForm = new BookForm();
        model.addAttribute("bookForm", bookForm);
        return "bookRegisterForm";
    }

    @PostMapping("/saveBook")
    public String addBook(
            @ModelAttribute @Valid BookForm bookForm, BindingResult bindingResult, Errors errors, Model model) {
        if (errors.hasErrors()) {
            model.addAttribute("bookForm", bookForm);
            return "bookRegisterForm";
        } else {
            try {
                bookDAO.saveBook(bookForm);
            } catch (Exception e) {
                Throwable rootCause = ExceptionUtils.getRootCause(e);
                String message = rootCause.getMessage();
                model.addAttribute("errorMessage", message);
                return "bookRegisterForm";
            }
            return "redirect:/";
        }
    }

    @GetMapping("/viewEditForm/{id}")
    public String viewEditForm(@PathVariable(value = "id") long id, Model model) {

        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        System.out.println(userDetails.getPassword());
        System.out.println(userDetails.getUsername());
        System.out.println(userDetails.isEnabled());
        Book book = bookDAO.getBookById(id);
        model.addAttribute("book", book);
        return "bookEditForm";
    }

    private Object Null;

    @PostMapping("/viewEditForm/{id}")
    public String updateBook(@PathVariable(value = "id") long id,
                             @ModelAttribute @Valid BookForm bookForm, BindingResult bindingResult, Errors errors, Model model) {
        bookRepository.findById(id).orElse((Book) Null);
        if (errors.hasErrors()) {
            model.addAttribute("bookForm", bookForm);
            return "bookEditForm";
        } else {
            try {
                this.bookDAO.saveBook(bookForm);
            } catch (Exception e) {
                Throwable rootCause = ExceptionUtils.getRootCause(e);
                String message = rootCause.getMessage();
                model.addAttribute("errorMessage", message);
                return "bookEditForm";
            }
            return "redirect:/";
        }
    }

    @GetMapping("/deleteBook/{id}")
    public String deleteBook(@PathVariable(value = "id") long id) {
        this.bookDAO.deleteBookById(id);
        return "redirect:/";
    }
}