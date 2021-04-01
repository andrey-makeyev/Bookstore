package com.bookstore.app.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
//import com.bookstore.app.form.BookForm;
import com.bookstore.app.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import com.bookstore.app.model.Book;
import com.bookstore.app.service.BookService;
import org.springframework.web.multipart.MultipartFile;
import javax.validation.Valid;

@Controller
public class MainController{

    @Autowired
    private BookService bookService;

    @Autowired
    protected BookRepository bookRepository;

    @RequestMapping("/403")
    public String accessDenied() {
        return "/403";
    }

    @RequestMapping("/404")
    public String pageNotFound() {
        return "/404";
    }

    @GetMapping("/")
    public String viewHomePage(Model model) {
        return pager(1, model);
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
        Book book = new Book();
        model.addAttribute("book", book);
        return "bookRegisterForm";
    }
    /*
    @PostMapping("/saveBook")
    public String saveBook(@ModelAttribute @Valid BookForm bookForm, Errors errors, Model model) {
        if (errors.hasErrors()) {
            model.addAttribute("bookForm", bookForm);
            return "bookRegisterForm";
        } else {
            bookService.saveBook(bookForm);
        }
        return "index";
    }
    */
    @PostMapping("/saveBook")
    public String saveBook(
            @RequestParam("imageFile") MultipartFile imageFile, ModelMap modelMap,
            @ModelAttribute("book") @Valid Book book, BindingResult bindingResult, Model model, Errors errors) {
        if (errors.hasErrors()) {
            model.addAttribute("book", book);
            return "bookRegisterForm";
        } else {

            try {
                if(!imageFile.isEmpty()){
                modelMap.addAttribute("imageFile", imageFile);
                bookService.saveImageFile(imageFile);
                }
                bookRepository.save(book);
            } catch (Exception e) {
                System.out.println(e);
                return "bookRegisterForm";
            }
            return "redirect:/";
        }
    }

    @RequestMapping(value = {"/viewEditForm/{id}"}, method = RequestMethod.GET)
    public String viewEditForm(@PathVariable(value = "id") long id, Model model) {

        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        System.out.println(userDetails.getPassword());
        System.out.println(userDetails.getUsername());
        System.out.println(userDetails.isEnabled());

        Book book = bookService.getBookById(id);
        model.addAttribute("book", book);
        return "bookEditForm";
    }

    @GetMapping("/deleteBook/{id}")
    public String deleteBook(@PathVariable(value = "id") long id) {
        this.bookService.deleteBookById(id);
        return "redirect:/";
    }

    @GetMapping("/page/{pageNo}")
    public String pager(@PathVariable(value = "pageNo") int pageNo, Model model) {
        int pageSize = 50;

        Page<Book> page = bookService.page(pageNo, pageSize);
        List<Book> listBooks = page.getContent();
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("totalBooks", page.getTotalElements());
        model.addAttribute("listBooks", listBooks);

        return "index";
    }

    @RequestMapping(value = {"/accountInfo"}, method = RequestMethod.GET)
    public String accountInfo(Model model) {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        System.out.println(userDetails.getPassword());
        System.out.println(userDetails.getUsername());
        System.out.println(userDetails.isEnabled());

        model.addAttribute("userDetails", userDetails);
        return "accountInfo";
    }
}
