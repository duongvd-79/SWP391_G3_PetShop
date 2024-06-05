package model;

/**
 *
 * @author duongvu
 */
public class Cart {

    /*
    id INT PRIMARY KEY,
    user_id VARCHAR(10),
    product_id INT,
    quantity INT,
     */
    int id, productId, quantity;
    String userId;

    public Cart() {
    }

    public Cart(int id, int productId, int quantity, String userId) {
        this.id = id;
        this.productId = productId;
        this.quantity = quantity;
        this.userId = userId;
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

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

}
