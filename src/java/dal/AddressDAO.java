/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Address;

/**
 *
 * @author ACER
 */
public class AddressDAO extends DBContext {

    PreparedStatement stm;
    ResultSet rs;

    public void addNew(String city, String district, String detail) throws SQLException {
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

    public int getLastId() throws SQLException {
        String sql = "SELECT * from address ORDER BY id DESC LIMIT 1";
        stm = connection.prepareStatement(sql);
        rs = stm.executeQuery();
        int id = 0;
        while (rs.next()) {
            id = rs.getInt("id");
        }
        return id;
    }

    public Address getAddressByUserId(int userId) {
        String sql = "SELECT a.* FROM user_address ua JOIN address a "
                + "ON ua.address_id = a.id "
                + "WHERE ua.customer_id = ? AND a.is_default = 1";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, userId);
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
        } catch (SQLException e) {
            System.out.println(e.getMessage());
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

    public Address getDefaultAddress(int uid, int def) throws SQLException {
        String sql = "select a.* from user u join user_address ua on u.id = ua.customer_id\n"
                + "join address a on ua.address_id = a.id where u.id = ? and is_default = ?";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setInt(1, uid);
        sta.setInt(2, def);
        ResultSet rs = sta.executeQuery();
        Address a = new Address();
        while (rs.next()) {
            int id = rs.getInt("id");
            String district = rs.getString("district");
            String city = rs.getString("city");
            String detail = rs.getString("detail");
            boolean is_default = rs.getBoolean("is_default");
            a = new Address(id, district, city, detail, is_default);
        }
        return a;
    }

    public Address getChosenAddress(int aid) throws SQLException {
        String sql = "select * from address where id = ?";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setInt(1, aid);
        ResultSet rs = sta.executeQuery();
        Address a = new Address();
        while (rs.next()) {
            int id = rs.getInt("id");
            String district = rs.getString("district");
            String city = rs.getString("city");
            String detail = rs.getString("detail");
            boolean is_default = rs.getBoolean("is_default");
            a = new Address(id, district, city, detail, is_default);
        }
        return a;
    }

    public ArrayList<Address> getAddressList(int uid) throws SQLException {
        String sql = "select a.* from user_address ua join address a on ua.address_id = a.id where ua.customer_id = ?";
        PreparedStatement sta = connection.prepareStatement(sql);
        sta.setInt(1, uid);
        ResultSet rs = sta.executeQuery();
        ArrayList<Address> al = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            String district = rs.getString("district");
            String city = rs.getString("city");
            String detail = rs.getString("detail");
            boolean is_default = rs.getBoolean("is_default");
            Address a = new Address(id, district, city, detail, is_default);
            al.add(a);
        }
        return al;
    }

    public void addNewAddress(String city, String district, String detail) throws SQLException {
        try {
            String strSelect = "insert into address(detail,city,district,is_default) values (?,?,?,0) ";
            stm = connection.prepareStatement(strSelect);
            stm.setString(1, detail);
            stm.setString(2, city);
            stm.setString(3, district);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void AddUserAddress(int cid, int aid) throws SQLException {
        String sql = "insert into user_address(customer_id, address_id) values (?,?);";
        try (PreparedStatement sta = connection.prepareStatement(sql)) {
            sta.setInt(1, cid);
            sta.setInt(2, aid);
            sta.executeUpdate();
        }
    }

    public void deleteAddress(int id) throws SQLException {
        String sql = "DELETE FROM address WHERE id = ?";
        try (PreparedStatement sta = connection.prepareStatement(sql)) {
            sta.setInt(1, id);
            sta.executeUpdate();
        }
    }

    public void deleteUserAddress(int aid, int uid) throws SQLException {
        String sql = "DELETE FROM user_address WHERE address_id = ? and customer_id = ?";
        try (PreparedStatement sta = connection.prepareStatement(sql)) {
            sta.setInt(1, aid);
            sta.setInt(2, uid);
            sta.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void addAddress(String city, String district, String detail, int userId) {
        try {
            String sql = "INSERT INTO address(district, city, detail, is_default) VALUES (?, ?, ?, 1)";
            stm = connection.prepareStatement(sql);
            stm.setString(1, district);
            stm.setString(2, city);
            stm.setString(3, detail);
            stm.executeUpdate();
        } catch (SQLException e) {
        }
        try {
            int aid = getLastId();
            String strSelect = "INSERT INTO user_address(customer_id, address_id) VALUES (?, ?) ";
            stm = connection.prepareStatement(strSelect);
            stm.setInt(1, userId);
            stm.setInt(2, aid);
            stm.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public static void main(String[] args) throws SQLException {
        AddressDAO aDAO = new AddressDAO();
        Address a = aDAO.getChosenAddress(8);
        System.out.println(a.getCity());
    }
}
