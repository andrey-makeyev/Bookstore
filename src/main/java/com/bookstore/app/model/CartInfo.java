package com.bookstore.app.model;

import java.util.ArrayList;
import java.util.List;

public class CartInfo {

    private int orderNumber;

    private CustomerInfo customerInfo;

    private final List<CartLineInfo> cartLines = new ArrayList<CartLineInfo>();

    public CartInfo() {

    }

    public int getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(int orderNumber) {
        this.orderNumber = orderNumber;
    }

    public CustomerInfo getCustomerInfo() {
        return customerInfo;
    }

    public void setCustomerInfo(CustomerInfo customerInfo) {
        this.customerInfo = customerInfo;
    }

    public List<CartLineInfo> getCartLines() {
        return this.cartLines;
    }

    private CartLineInfo findLineByIsbn(String isbn) {
        for (CartLineInfo line : this.cartLines) {
            if (line.getBookInfo().getIsbn().equals(isbn)) {
                return line;
            }
        }
        return null;
    }

    public void addBook(BookInfo bookInfo, int quantity) {
        CartLineInfo line = this.findLineByIsbn(bookInfo.getIsbn());

        if (line == null) {
            line = new CartLineInfo();
            line.setQuantity(0);
            line.setBookInfo(bookInfo);
            this.cartLines.add(line);
        }
        int newQuantity = line.getQuantity() + quantity;
        if (newQuantity <= 0) {
            this.cartLines.remove(line);
        } else {
            line.setQuantity(newQuantity);
        }
    }

    public void validate() {

    }

    public void updateBook(String isbn, int quantity) {
        CartLineInfo line = this.findLineByIsbn(isbn);

        if (line != null) {
            if (quantity <= 0) {
                this.cartLines.remove(line);
            } else {
                line.setQuantity(quantity);
            }
        }
    }

    public void removeBook(BookInfo bookInfo) {
        CartLineInfo line = this.findLineByIsbn(bookInfo.getIsbn());
        if (line != null) {
            this.cartLines.remove(line);
        }
    }

    public boolean isEmpty() {
        return this.cartLines.isEmpty();
    }

    public boolean isValidCustomer() {
        return this.customerInfo != null && this.customerInfo.isValid();
    }

    public int getQuantityTotal() {
        int quantity = 0;
        for (CartLineInfo line : this.cartLines) {
            quantity += line.getQuantity();
        }
        return quantity;
    }

    public double getAmountTotal() {
        double total = 0;
        for (CartLineInfo line : this.cartLines) {
            total += line.getAmount();
        }
        return total;
    }

    public void updateQuantity(CartInfo cartForm) {
        if (cartForm != null) {
            List<CartLineInfo> lines = cartForm.getCartLines();
            for (CartLineInfo line : lines) {
                this.updateBook(line.getBookInfo().getIsbn(), line.getQuantity());
            }
        }

    }

}
