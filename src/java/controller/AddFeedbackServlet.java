package controller;

import dal.FeedbackDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

@MultipartConfig(maxFileSize = 16177215)
public class AddFeedbackServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");

        // Retrieve form parameters from the request
        String pidStr = getValueFromPart(request.getPart("pid")).trim();
        int pid = Integer.parseInt(pidStr);

        String detail = getValueFromPart(request.getPart("detail")).trim();

        String ratingStr = getValueFromPart(request.getPart("rating")).trim();
        int rating = Integer.parseInt(ratingStr);

        String currentDateStr = getCurrentDate();

        try {
            feedbackDAO.AddFeedback(pid, u.getId(), detail, rating, null, "active", currentDateStr);
            int fid = feedbackDAO.getFeedbackID(pid, u.getId());

//            String uploadPath = "C:\\Users\\Admin\\Documents\\GitHub\\SWP391_G3_PetShop\\web\\images\\feedbackimage";
            String uploadPath = request.getServletContext().getRealPath("/images/feedbackimage");

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            // Handle file upload
            for (Part filePart : request.getParts()) {
                String fileName = filePart.getSubmittedFileName();
                if (fileName != null && !fileName.isEmpty()) {
                    File file = new File(uploadDir, fileName);

                    // Save the file
                    filePart.write(file.getAbsolutePath());

                    // Generate URL for the uploaded file
                    String fileUrl = "images\\feedbackimage\\" + fileName;

                   
                    // Save the file URL to the database
                     feedbackDAO.AddFeedbackImage(u.getId(), fid, fileUrl);
                }
               
            }
            response.sendRedirect("home");
        } catch (SQLException ex) {
            Logger.getLogger(AddFeedbackServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

     private static String getCurrentDate() {
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return currentDateTime.format(formatter);
    }

    private String getValueFromPart(Part part) throws IOException {
        if (part != null) {
            StringBuilder value = new StringBuilder();
            try (InputStreamReader reader = new InputStreamReader(part.getInputStream(), StandardCharsets.UTF_8)) {
                char[] buffer = new char[1024];
                int length;
                while ((length = reader.read(buffer)) > 0) {
                    value.append(buffer, 0, length);
                }
            }
            return value.toString();
        }
        return null;
    }

}
