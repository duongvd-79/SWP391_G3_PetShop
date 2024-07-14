package model;

import java.util.Date;

/**
 *
 * @author duongvu
 */
public class User {

    /*
    id VARCHAR(10) PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255),
    gender BOOLEAN,
    status VARCHAR(50),
    role_id INT,
    phone VARCHAR(20),
    last_log DATETIME,
    pfp TEXT,
     */
    String email, password, name, status, phone, pfp;
    int roleId, id, totsalSale;
    boolean gender;
    Date lastLog, createDate;

    public User() {
    }

    public User(int id, int totsalSale) {
        this.id = id;
        this.totsalSale = totsalSale;
    }

    
    
    public User(String email,String password, String name, String status, String phone, String pfp, boolean gender,int roleId) {
        this.email = email;
        this.password = password;
        this.name = name;
        this.status = status;
        this.phone = phone;
        this.pfp = pfp;
        this.gender = gender;
        this.roleId = roleId;
    }
    
    public User(int id, String email, String password, String name, String status, String phone, String pfp, int roleId, boolean gender, Date lastLog) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.name = name;
        this.status = status;
        this.phone = phone;
        this.pfp = pfp;
        this.roleId = roleId;
        this.gender = gender;
        this.lastLog = lastLog;
    }

    public int getTotsalSale() {
        return totsalSale;
    }

    public void setTotsalSale(int totsalSale) {
        this.totsalSale = totsalSale;
    }

    
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPfp() {
        return pfp;
    }

    public void setPfp(String pfp) {
        this.pfp = pfp;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getGender() {
        return gender ? "Male" : "Female";
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public Date getLastLog() {
        return lastLog;
    }

    public void setLastLog(Date lastLog) {
        this.lastLog = lastLog;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
    


}
