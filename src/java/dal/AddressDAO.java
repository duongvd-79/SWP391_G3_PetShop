/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ACER
 */
public class AddressDAO extends DBContext{
    PreparedStatement stm;
    ResultSet rs;
    public void addNew(String detail) throws SQLException {
        try {
            String strSelect = "insert into address(detail,is_default) values (?,1) ";
            stm = connection.prepareStatement(strSelect);
            stm.setString(1, detail);
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
    public static void main(String[] args) throws SQLException{
        AddressDAO aDAO = new AddressDAO();
        aDAO.addNewUserAddress();
    }
}
