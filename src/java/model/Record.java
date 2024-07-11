package model;

import java.util.Date;

public class Record {

    int id, userId, updatedBy;
    Date updatedDate;
    String description;

    public Record() {
    }

    public Record(int id, int userId, int updatedBy, Date updatedDate, String description) {
        this.id = id;
        this.userId = userId;
        this.updatedBy = updatedBy;
        this.updatedDate = updatedDate;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(int updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
