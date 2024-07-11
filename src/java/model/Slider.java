package model;

import java.util.Date;

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
    int id ,createdBy;
    String title, image, backLink, status, description;
    Date createdDate;

    public Slider() {
    }

    public Slider(int id, int createdBy, String title, String image, String backLink, String status, String description, Date createdDate) {
        this.id = id;
        this.createdBy = createdBy;
        this.title = title;
        this.image = image;
        this.backLink = backLink;
        this.status = status;
        this.description = description;
        this.createdDate = createdDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
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

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
    
}
