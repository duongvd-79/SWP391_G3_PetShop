package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Post;
import model.Setting;
import model.User;

public class PostDAO extends DBContext {

    private PreparedStatement stm;
    private ResultSet rs;
    private List<Post> postList;

    private static Post setPost(ResultSet rs) {
        Post p = new Post();
        try {
            p.setId(rs.getInt("id"));
            p.setTitle(rs.getString("title"));
            p.setThumbnail(rs.getString("thumbnail"));
            p.setDetail(rs.getString("detail"));
            p.setStatus(rs.getString("status"));
            p.setCreatedBy(rs.getString("created_by"));
            p.setCategoryId(rs.getInt("category_id"));
            p.setIsFeatured(rs.getBoolean("is_featured"));
            p.setCreatedDate(rs.getDate("created_date"));
        } catch (SQLException e) {
        }
        return p;
    }

    public List<Post> getAll() {
        postList = new ArrayList<>();
        String sql = "SELECT * FROM post";
        try {
            postList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Post p = setPost(rs);
                postList.add(p);
            }
        } catch (SQLException e) {
        }
        return postList;
    }

    public List<Post> getFeatured() {
        postList = new ArrayList<>();
        String sql = "SELECT * FROM post WHERE is_featured = 1 LIMIT 5";
        try {
            postList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Post p = setPost(rs);
                postList.add(p);
            }
        } catch (SQLException e) {
        }
        return postList;
    }

    public List<Post> getLatest() {
        postList = new ArrayList<>();
        String sql = "SELECT * FROM post ORDER BY created_date DESC LIMIT 3";
        try {
            postList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Post p = setPost(rs);
                postList.add(p);
            }
        } catch (SQLException e) {
        }
        return postList;
    }

    public static void main(String[] args) {
        PostDAO list = new PostDAO();
        Post p = list.getPostById("2");
        System.out.println(p);
    }

    //sưa postdao
    public ArrayList<Post> getAllPosts(String search) {
        ArrayList<Post> listp = new ArrayList<>();
        String sql = "SELECT \n"
                + "    post.id ,\n"
                + "    post.thumbnail,\n"
                + "    post.title,\n"
                + "    post.detail,\n"
                + "    post.is_featured,\n"
                + "    post.created_date,\n"
                + "    post.status,\n"
                + "    \n"
                + "    user.id AS user_id,\n"
                + "    user.email AS user_email,\n"
                + "    user.name AS user_name,\n"
                + "    user.phone AS user_phone,\n"
                + "    \n"
                + "    setting.id AS setting_id,\n"
                + "    setting.name AS setting_name,\n"
                + "    setting.order AS setting_order,\n"
                + "    setting.status AS setting_status,\n"
                + "    \n"
                + "    \n"
                + "    user.name AS user_name\n"
                + "   \n"
                + "FROM \n"
                + "    post\n"
                + "JOIN \n"
                + "    user  ON post.created_by = user.id\n"
                + "JOIN \n"
                + "    setting ON post.category_id = setting.id"
                + " where post.title like ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + search + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                Post p = new Post();
                p.setId(rs.getInt("id"));
                p.setTitle(rs.getString("title"));
                p.setThumbnail(rs.getString("thumbnail"));
                p.setDetail(rs.getString("detail"));
                p.setStatus(rs.getString("status"));
                p.setCreatedDate(rs.getDate("created_date"));
                p.setIsFeatured(rs.getBoolean("is_featured"));

                Setting s = new Setting();
                s.setId(rs.getInt("setting_id"));
                s.setStatus(rs.getString("setting_status"));
                s.setName(rs.getString("setting_name"));
                s.setOrder(rs.getInt("setting_order"));
                p.setSetting(s);

                User u = new User();
                u.setName(rs.getString("user_name"));
                p.setUser(u);

                listp.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listp;
    }

    // Update PostDao
    public Post getPostById(String postId) {
        Post post = null;
        String sql = "SELECT \n"
                + "post.id,\n"
                + "post.thumbnail,\n"
                + "post.title,\n"
                + "post.detail,\n"
                + "post.is_featured,\n"
                + "post.created_date,\n"
                + "post.status,\n"
                + "user.name AS user_name,\n"
                + "setting.id AS setting_id,\n"
                + "setting.name AS setting_name,\n"
                + "setting.order AS setting_order,\n"
                + "setting.status AS setting_status\n"
                + "FROM \n"
                + "post\n"
                + "JOIN \n"
                + "user ON post.created_by = user.id\n"
                + "JOIN \n"
                + "setting ON post.category_id = setting.id\n"
                + "WHERE post.id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, postId);
            rs = stm.executeQuery();
            if (rs.next()) {
                post = new Post();  // Initialize the post object here
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setThumbnail(rs.getString("thumbnail"));
                post.setDetail(rs.getString("detail"));
                post.setStatus(rs.getString("status"));
                post.setCreatedDate(rs.getDate("created_date"));
                post.setIsFeatured(rs.getBoolean("is_featured"));

                Setting s = new Setting();
                s.setId(rs.getInt("setting_id"));
                s.setStatus(rs.getString("setting_status"));
                s.setName(rs.getString("setting_name"));
                s.setOrder(rs.getInt("setting_order"));
                post.setSetting(s);

                User u = new User();
                u.setName(rs.getString("user_name"));
                post.setUser(u);
            }

        } catch (SQLException e) {
            e.printStackTrace(); // or use a logger
        }
        return post;
    }

}
