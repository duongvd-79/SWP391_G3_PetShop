package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
            String url = "jdbc:mysql://localhost:3306/petshop";
            String username = "root";
            String password = "1234";
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, password);
            System.out.println("Kết nối thành công!");
        } catch (ClassNotFoundException ex) {
            System.out.println("Không tìm thấy Driver MySQL: " + ex.getMessage());
        } catch (SQLException ex) {
            System.out.println("Không thể thiết lập kết nối: " + ex.getMessage());
        }
    }

    public Connection getConnection() {
        return connection;
    }
}
