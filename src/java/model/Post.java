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
public class Post {

    /*
     id INT PRIMARY KEY,
    title VARCHAR(255),
    thumbnail TEXT,
    detail TEXT,
    status VARCHAR(50),
    featured BOOLEAN,
    created_date DATETIME,
    created_by VARCHAR(10),
    category_id VARCHAR(10),
     */
    int id, categoryId;
    String title, thumbnail, detail, status, createdBy;
    boolean isFeatured;
    Date createdDate;
    Setting setting;
    User user;

    public Post() {
    }

    public Post(int id, String title, String thumbnail, String detail, String status, String createdBy, int categoryId, boolean isFeatured, Date createdDate) {
        this.id = id;
        this.title = title;
        this.thumbnail = thumbnail;
        this.detail = detail;
        this.status = status;
        this.createdBy = createdBy;
        this.categoryId = categoryId;
        this.isFeatured = isFeatured;
        this.createdDate = createdDate;
    }

    public Post(int id, int categoryId, String title, String thumbnail, String detail, String status, String createdBy, boolean isFeatured, Date createdDate, Setting setting, User user) {
        this.id = id;
        this.categoryId = categoryId;
        this.title = title;
        this.thumbnail = thumbnail;
        this.detail = detail;
        this.status = status;
        this.createdBy = createdBy;
        this.isFeatured = isFeatured;
        this.createdDate = createdDate;
        this.setting = setting;
        this.user = user;
    }

    public Setting getSetting() {
        return setting;
    }

    public void setSetting(Setting setting) {
        this.setting = setting;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public boolean isIsFeatured() {
        return isFeatured;
    }

    public void setIsFeatured(boolean isFeatured) {
        this.isFeatured = isFeatured;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

}
