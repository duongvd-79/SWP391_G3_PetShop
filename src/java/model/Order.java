package model;

import java.util.Date;

/**
 *
 * @author duongvu
 */
public class Order {

    /*
    id INT PRIMARY KEY,
    customer_id VARCHAR(10),
    ordered_date DATETIME,
    status VARCHAR(50),
    is_delivered BOOLEAN,
    delivered_date DATETIME,
    total DECIMAL(10, 2),
     */
    int id,customerId,addressId;
    String status;
    double total;
    boolean isDelivered;
    Date orderedDate, deliveredDate;

    public Order() {
    }

    public Order(int id, int customerId,int addressId, String status, double total, boolean isDelivered, Date orderedDate, Date deliveredDate) {
        this.id = id;
        this.customerId = customerId;
        this.addressId = addressId;
        this.status = status;
        this.total = total;
        this.isDelivered = isDelivered;
        this.orderedDate = orderedDate;
        this.deliveredDate = deliveredDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }
    

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public boolean isIsDelivered() {
        return isDelivered;
    }

    public void setIsDelivered(boolean isDelivered) {
        this.isDelivered = isDelivered;
    }

    public Date getOrderedDate() {
        return orderedDate;
    }

    public void setOrderedDate(Date orderedDate) {
        this.orderedDate = orderedDate;
    }

    public Date getDeliveredDate() {
        return deliveredDate;
    }

    public void setDeliveredDate(Date deliveredDate) {
        this.deliveredDate = deliveredDate;
    }

}
