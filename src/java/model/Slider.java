/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author duongvu
 */
public class Slider {
    /*
    id INT PRIMARY KEY,
    title VARCHAR(255),
    image TEXT,
    back_link TEXT,
    status VARCHAR(50),
    description TEXT
    */
    int id;
    String title, image, backLink, status, description;

    public Slider() {
    }

    public Slider(int id, String title, String image, String backLink, String status, String description) {
        this.id = id;
        this.title = title;
        this.image = image;
        this.backLink = backLink;
        this.status = status;
        this.description = description;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getBackLink() {
        return backLink;
    }

    public void setBackLink(String backLink) {
        this.backLink = backLink;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
}
