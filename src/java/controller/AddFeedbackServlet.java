package controller;

import dal.FeedbackDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

@MultipartConfig
public class AddFeedbackServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_DIR = "uploads";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddFeedbackServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddFeedbackServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");

        // Lấy và chuyển đổi các parameter từ request
        Part pidPart = request.getPart("pid");
        String pidStr = getValueFromPart(pidPart).trim();
        int pid = Integer.parseInt(pidStr);

        Part detailPart = request.getPart("detail");
        String detail = getValueFromPart(detailPart).trim();

        Part ratingPart = request.getPart("rating");
        String ratingStr = getValueFromPart(ratingPart).trim();
        int rating = Integer.parseInt(ratingStr);

        String currentDateStr = getCurrentDate();

        try {
            feedbackDAO.AddFeedback(pid, u.getId(), detail, rating, null, "active", currentDateStr);

            // Get the upload directory path
            String appPath = request.getServletContext().getRealPath("");
            String savePath = appPath + File.separator + UPLOAD_DIR;

            // Create the upload directory if it does not exist
            File uploadDir = new File(savePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            // Process the uploaded files
            ArrayList<String> imagePaths = new ArrayList<>();
            for (Part part : request.getParts()) {
                String fileName = extractFileName(part);
                if (fileName != null && !fileName.isEmpty()) {
                    String filePath = savePath + File.separator + generateUniqueFileName(fileName);
                    part.write(filePath);
                    imagePaths.add(UPLOAD_DIR + "/" + generateUniqueFileName(fileName));
                }
            }

            // Add feedback images to database
            for (String imagePath : imagePaths) {
                feedbackDAO.AddFeedbackImage(pid, u.getId(), imagePath);
            }

            // Redirect back to the feedback page or show success message
            response.sendRedirect("home");
        } catch (SQLException ex) {
            Logger.getLogger(AddFeedbackServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 2, token.length() - 1);
            }
        }
        return null;
    }

    // Generates a unique file name to avoid naming conflicts
    private String generateUniqueFileName(String fileName) {
        return UUID.randomUUID().toString() + "_" + fileName;
    }

    private static String getCurrentDate() {
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDate = currentDate.format(formatter);
        return formattedDate;
    }

    private String getValueFromPart(Part part) throws IOException {
        if (part != null) {
            StringBuilder value = new StringBuilder();
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), StandardCharsets.UTF_8))) {
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
