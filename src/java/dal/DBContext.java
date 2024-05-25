package dal;

/**
 *
 * @author ACER
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import model.Product;
import model.User;

public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
// Edit URL , username, password to authenticate with your MS SQL Server
            String url = "jdbc:mysql://localhost:3306/petshop";
            String username = "root";
            String password = "1234";
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex);
        }
    }
    
    

    public static void main(String[] args) throws SQLException {
       UserDAO u = new UserDAO();
       String name = "name";
       ArrayList<User> uList = u.orderUserBy("name");
       for(User i : uList){
           System.out.println(i.getName());
       }
    }
}
