/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Address;

/**
 *
 * @author ACER
 */
public class AddressDAO extends DBContext{
    PreparedStatement stm;
    ResultSet rs;
    public void addNew(String city,String district,String detail) throws SQLException {
        try {
            String strSelect = "insert into address(detail,city,district,is_default) values (?,?,?,1) ";
            stm = connection.prepareStatement(strSelect);
            stm.setString(1, detail);
            stm.setString(2, city);
            stm.setString(3, district);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    public void addNewUserAddress() throws SQLException {
        UserDAO uDAO = new UserDAO();
        int uid = uDAO.getLastId();
        int aid = getLastId();
        try {
            String strSelect = "insert into user_address(customer_id,address_id) values (?,?) ";
            stm = connection.prepareStatement(strSelect);
            stm.setInt(1, uid);
            stm.setInt(2, aid);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    public int getLastId() throws SQLException{
        String sql = "SELECT * from address ORDER BY id DESC LIMIT 1";
        stm = connection.prepareStatement(sql);
        rs = stm.executeQuery();
        int id=0;
        while (rs.next()) {
            id = rs.getInt("id");
        }
        return id;
    }

    public Address getAddress(int userId) {
        String sql1 = "SELECT * FROM user_address WHERE customer_id = ?";
        try {
            stm = connection.prepareStatement(sql1);
            stm.setInt(1, userId);
            rs = stm.executeQuery();
            if (rs.next()) {
                String sql2 = "SELECT * FROM address WHERE id = ?";
                stm = connection.prepareStatement(sql2);
                stm.setInt(1, rs.getInt("address_id"));
                rs = stm.executeQuery();
                if (rs.next()) {
                    Address address = new Address();
                    address.setId(rs.getInt("id"));
                    address.setCity(rs.getString("city"));
                    address.setDistrict(rs.getString("district"));
                    address.setDetail(rs.getString("detail"));
                    address.setIsDefault(rs.getBoolean("is_default"));
                    return address;
                }
            }
        } catch (SQLException e) {
        }
        return null;
    }
    public void updateUserAddress(Address address) {
        String sql = "UPDATE address SET district = ?, city = ?, detail = ? WHERE id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, address.getDistrict());
            stm.setString(2, address.getCity());
            stm.setString(3, address.getDetail());
            stm.setInt(4, address.getId());
            stm.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public static void main(String[] args) throws SQLException{
        AddressDAO aDAO = new AddressDAO();
        aDAO.addNewUserAddress();
    }
}
