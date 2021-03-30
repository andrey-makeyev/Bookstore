package com.bookstore.app.controller;

import com.bookstore.app.config.WebSecurityConfig;

import com.bookstore.app.form.LoginForm;
import com.bookstore.app.model.Account;
import com.bookstore.app.model.Book;
import org.springframework.stereotype.Controller;

import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import javax.validation.Valid;

@Controller
public class LoginController extends WebMvcConfigurerAdapter{

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("index");
    }

    @GetMapping("/viewLoginForm")
    public String viewLoginForm(LoginForm loginForm) {
        return "loginForm";
    }

    @PostMapping("/")
    public String validateLoginForm(Model model, @Valid LoginForm loginForm, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "loginForm";
        }
        model.addAttribute("account", loginForm.getUserName());
        return "index";
    }
}