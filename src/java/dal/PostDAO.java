package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Post;

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
        String sql = "SELECT * FROM post";
        try {
            postList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Post p = setPost(rs);
                postList.add(p);
            }
            return postList;
        } catch (SQLException e) {
        }
        return null;
    }

    public List<Post> getFeatured() {
        String sql = "SELECT * FROM post WHERE is_featured = 1 LIMIT 5";
        try {
            postList = new ArrayList<>();
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Post p = setPost(rs);
                postList.add(p);
            }
            return postList;
        } catch (SQLException e) {
        }
        return null;
    }

    public static void main(String[] args) {
        PostDAO p = new PostDAO();
        List<Post> l = p.getFeatured();
        for (Post p1 : l) {
            System.out.println(p1.getTitle());
        }
    }
}
