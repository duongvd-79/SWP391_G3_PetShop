/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author duongvu
 */
public class Product {
    /*
    id INT PRIMARY KEY,
    title VARCHAR(255),
    import_price DECIMAL(10, 2),
    list_price DECIMAL(10, 2),
    status VARCHAR(50),
    featured BOOLEAN,
    thumbnail TEXT,
    created_date DATETIME,
    quantity INT,
    category_id VARCHAR(10),
    */
    int id, quantity,categoryId;
    String title, status, thumbnail;
    double importPrice, listPrice;
    Date createdDate;
    boolean isFeatured;

    public Product() {
    }

    public Product(int id, int quantity, String title, String status, String thumbnail, int categoryId, double importPrice, double listPrice, Date createdDate, boolean featured) {
        this.id = id;
        this.quantity = quantity;
        this.title = title;
        this.status = status;
        this.thumbnail = thumbnail;
        this.categoryId = categoryId;
        this.importPrice = importPrice;
        this.listPrice = listPrice;
        this.createdDate = createdDate;
        this.isFeatured = featured;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }



    public double getImportPrice() {
        return importPrice;
    }

    public void setImportPrice(double importPrice) {
        this.importPrice = importPrice;
    }

    public double getListPrice() {
        return listPrice;
    }

    public void setListPrice(double listPrice) {
        this.listPrice = listPrice;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public boolean isFeatured() {
        return isFeatured;
    }

    public void setFeatured(boolean featured) {
        this.isFeatured = featured;
    }

}
