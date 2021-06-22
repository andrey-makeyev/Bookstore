package com.bookstore.app.form;

import com.bookstore.app.model.CustomerInfo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;

public class CustomerForm {

    @NotBlank(message = "Name is required")
    private String name;
    @NotBlank(message = "Email is required")
    private String address;
    @NotBlank(message = "Address is required")
    private String email;
    @NotBlank(message = "Phone is required")
    private String phone;

    private boolean valid;

    public CustomerForm() {
    }

    public CustomerForm(CustomerInfo customerInfo) {
        if (customerInfo != null) {
            this.name = customerInfo.getName();
            this.address = customerInfo.getAddress();
            this.email = customerInfo.getEmail();
            this.phone = customerInfo.getPhone();
        }
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }

}
