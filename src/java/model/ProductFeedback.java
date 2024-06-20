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
    int id, productId, userId, star, feedback_image_id;
    String detail, image, status, feedback_image;

    Date createdDate;

    String name, pfp;
    public ProductFeedback() {
    }

    public ProductFeedback(int id, int userId, int feedback_image_id, String feedback_image) {
        this.id = id;
        this.userId = userId;
        this.feedback_image_id = feedback_image_id;
        this.feedback_image = feedback_image;
    }

    public int getFeedback_image_id() {
        return feedback_image_id;
    }

    public void setFeedback_image_id(int feedback_image_id) {
        this.feedback_image_id = feedback_image_id;
    }

    public String getFeedback_image() {
        return feedback_image;
    }

    public void setFeedback_image(String feedback_image) {
        this.feedback_image = feedback_image;
    }

    
    
    public ProductFeedback(int id, int productId, int userId, int star, String detail, String image, String status, Date createdDate, String name, String pfp) {
        this.id = id;
        this.productId = productId;
        this.userId = userId;
        this.star = star;
        this.detail = detail;
        this.image = image;
        this.status = status;
        this.createdDate = createdDate;
        this.name = name;
        this.pfp = pfp;
    }

    
    
    public ProductFeedback(int id, int productId, int userId, int star, String detail, String image, String status, Date createdDate) {
        this.id = id;
        this.productId = productId;
        this.userId = userId;
        this.star = star;
        this.detail = detail;
        this.image = image;
        this.status = status;
        this.createdDate = createdDate;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPfp() {
        return pfp;
    }

    public void setPfp(String pfp) {
        this.pfp = pfp;
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

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getStar() {
        return star;
    }

    public void setStar(int star) {
        this.star = star;
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
