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
    int id,customerId,addressId,saleId;
    String status,customerName,saleNote;
    double total;
    boolean isDelivered;
    Date orderedDate, deliveredDate;

    public Order() {
    }

    public Order(int id, int customerId,int addressId,int saleId, String status,String customerName,String saleNote, double total, boolean isDelivered, Date orderedDate, Date deliveredDate) {
        this.id = id;
        this.customerId = customerId;
        this.addressId = addressId;
        this.saleId = saleId;
        this.status = status;
        this.customerName = customerName;
        this.saleNote = saleNote;
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

    public int getSaleId() {
        return saleId;
    }

    public void setSaleId(int saleId) {
        this.saleId = saleId;
    }
   
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getSaleNote() {
        return saleNote;
    }

    public void setSaleNote(String saleNote) {
        this.saleNote = saleNote;
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
