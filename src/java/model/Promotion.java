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
public class Promotion {

    /*
    id INT PRIMARY KEY,
    product_id INT,
    sale_price DECIMAL(10, 2),
    start_date DATETIME,
    end_date DATETIME,
     */
    int id, productId;
    double salePrice;
    Date startDate, endDate;

    public Promotion() {
    }

    public Promotion(int id, int productId, double salePrice, Date startDate, Date endDate) {
        this.id = id;
        this.productId = productId;
        this.salePrice = salePrice;
        this.startDate = startDate;
        this.endDate = endDate;
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

    public double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

}
