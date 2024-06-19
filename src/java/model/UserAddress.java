package model;

/**
 *
 * @author ACER
 */
public class UserAddress {
    private int userId;
    private int addressId;

    public UserAddress() {
    }

    public UserAddress(int userId, int addressId) {
        this.userId = userId;
        this.addressId = addressId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }
    
    
}
