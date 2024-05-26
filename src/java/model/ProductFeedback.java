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
public class ProductFeedback {

    /*
    id INT PRIMARY KEY,
    product_id INT,
    user_id VARCHAR(10),
    detail TEXT,
    star INT,
    image TEXT,
    status VARCHAR(50),
    created_by INT,
    created_date DATETIME,
     */
    int id, productId, star, createdBy;
    String userId, detail, image, status;
    Date createdDate;

    public ProductFeedback() {
    }

    public ProductFeedback(int id, int productId, int star, int createdBy, String userId, String detail, String image, String status, Date createdDate) {
        this.id = id;
        this.productId = productId;
        this.star = star;
        this.createdBy = createdBy;
        this.userId = userId;
        this.detail = detail;
        this.image = image;
        this.status = status;
        this.createdDate = createdDate;
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

    public int getStar() {
        return star;
    }

    public void setStar(int star) {
        this.star = star;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

}
