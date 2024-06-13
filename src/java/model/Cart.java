/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author duongvu
 */
public class Cart {
    /*
    id INT PRIMARY KEY,
    user_id VARCHAR(10),
    product_id INT,
    quantity INT,
    */
    int id, productId, quantity;
    int userId;
    
    String thumbnail, title;
    double list_price;

    public Cart() {
    }

    public Cart(int id,int productId, int quantity, String thumbnail, String title, double list_price) {
        this.id = id;
        this.productId = productId;
        this.quantity = quantity;
        this.thumbnail = thumbnail;
        this.title = title;
        this.list_price = list_price;
    }
    

    public Cart(int id, int productId, int quantity, int userId) {
        this.id = id;
        this.productId = productId;
        this.quantity = quantity;
        this.userId = userId;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public double getList_price() {
        return list_price;
    }

    public void setList_price(double list_price) {
        this.list_price = list_price;
    }

    
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

}
