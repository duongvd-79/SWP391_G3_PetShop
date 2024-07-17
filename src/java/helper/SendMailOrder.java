package helper;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import model.Cart;

public class SendMailOrder {

    public static void sendMailOrder(String receiver, String subject, int orderId, String customerName, String city, String district, String detailAddress, String paymentMethod, List<Cart> CartDetailList, double totalPrice, boolean showPaymentReminder) {
        final String username = "pets74007@gmail.com";
        final String password = "vhpqgbufgukwzvou";

        // Get system properties
        Properties props = new Properties();

        // enable authentication
        props.put("mail.smtp.auth", "true");

        // enable STARTTLS
        props.put("mail.smtp.starttls.enable", "true");

        // Setup mail server
        props.put("mail.smtp.host", "smtp.gmail.com");

        // TLS Port
        props.put("mail.smtp.port", "587");

        // creating Session instance referenced to 
        // Authenticator object to pass in 
        // Session.getInstance argument
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            //override the getPasswordAuthentication method
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            // sender
            message.setFrom(new InternetAddress("pets74007@gmail.com"));
            // receiver
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(receiver));
            message.setSubject(subject);

            // Construct HTML content
            StringBuilder htmlContent = new StringBuilder();
            htmlContent.append("<div style='font-family: Arial, sans-serif; color: #333; max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px;'>")
                       .append("<h2 style='color: #FF6600; text-align: center;'>ĐƠN HÀNG ").append(orderId).append("</h2>")
                       .append("<p style='font-size: 16px; line-height: 1.5;'>Cảm ơn bạn đã mua hàng ở PawPaw Petshop!</p>")
                       .append("<p style='font-size: 16px; line-height: 1.5;'>Xin chào <strong>").append(customerName).append("</strong>, PawPaw đã nhận được đơn đặt hàng của bạn và đã sẵn sàng để vận chuyển. PawPaw sẽ thông báo cho bạn khi đơn hàng được gửi đi.</p>")
                       .append("<div style='text-align: center; margin: 20px 0;'>")
                       .append("<a href='http://localhost:9999/SWP391_G3_PetShop/myorders' style='display: inline-block; background-color: #FF6600; color: white; padding: 10px 20px; border-radius: 5px; text-decoration: none; font-size: 16px;'>Xem đơn hàng</a>")
                       .append("<a href='http://localhost:9999/SWP391_G3_PetShop/home' style='display: inline-block; margin-left: 10px; padding: 10px 20px; border-radius: 5px; text-decoration: none; font-size: 16px; color: #FF6600; border: 1px solid #FF6600;'>Đến cửa hàng của PawPaw</a>")
                       .append("</div>")
                       .append("<h3 style='border-bottom: 1px solid #ddd; padding-bottom: 5px;'>Thông tin đơn hàng</h3>")
                       .append("<table style='width: 100%; border-collapse: collapse; margin: 20px 0;'>")
                       .append("<tr style='background-color: #f9f9f9;'><th style='padding: 10px; border: 1px solid #ddd;'>Sản phẩm</th><th style='padding: 10px; border: 1px solid #ddd;'>Giá</th><th style='padding: 10px; border: 1px solid #ddd;'>Hình ảnh</th></tr>");

            for (Cart product : CartDetailList) {
                htmlContent.append("<tr><td style='padding: 10px; border: 1px solid #ddd;'>")
                           .append(product.getTitle())
                           .append("</td><td style='padding: 10px; border: 1px solid #ddd;'>")
                           .append(product.getList_price())
                           .append(" VND</td><td style='padding: 10px; border: 1px solid #ddd;'><img src='")
                           .append(product.getThumbnail())
                           .append("' alt='")
                           .append(product.getTitle())
                           .append("' style='width: 50px; border-radius: 5px;'/></td></tr>");
            }

            htmlContent.append("</table>")
                       .append("<p style='font-size: 16px;'><strong>Tổng cộng: ").append(totalPrice).append(" VND</strong></p>")
                       .append("<h3 style='border-bottom: 1px solid #ddd; padding-bottom: 5px;'>Thông tin khách hàng</h3>")
                       .append("<p style='font-size: 16px; line-height: 1.5;'><strong>Địa chỉ giao hàng:</strong> ").append(detailAddress).append(", ").append(district).append(", ").append(city).append("</p>")
                       .append("<p style='font-size: 16px; line-height: 1.5;'><strong>Phương thức thanh toán:</strong> ").append(paymentMethod).append("</p>");
            
            if (showPaymentReminder) {
                htmlContent.append("<p style='font-size: 16px; line-height: 1.5; color: red;'><strong>Nếu bạn chưa thanh toán, hãy chuyển khoản vào Ngân Hàng Quân Đội Việt Nam (MBBank)</strong></p>")
                           .append("<p style='font-size: 16px; line-height: 1.5;'><strong>Số tài khoản:</strong> 388815092004</p>")
                           .append("<p style='font-size: 16px; line-height: 1.5;'><strong>Tên chủ tài khoản:</strong> Nguyễn Quý Dương</p>")
                           .append("<p style='font-size: 16px; line-height: 1.5;'><strong>Với nội dung chuyển khoản là Họ tên + mã đơn hàng</strong></p>")
                           .append("<p style='font-size: 16px; line-height: 1.5;'><strong>Hoặc bạn có thể chuyển khoản qua mã QR dưới đây:</strong></p>")
                           .append("<div style='text-align: center; margin: 20px 0;'><img src='https://i.ibb.co/44GFSvh/QR.jpg' alt='QR Code' style='width: 150px; border-radius: 5px;'/></div>");
            }

            htmlContent.append("<p style='color: #999; font-size: 14px;'>Nếu bạn có bất kỳ thắc mắc nào, đừng ngần ngại liên hệ với PawPaw tại <a href='mailto:pawpawpetshop@gmail.com' style='color: #FF6600;'>pawpawpetshop@gmail.com</a></p>")
                       .append("</div>");

            // Set the content
            message.setContent(htmlContent.toString(), "text/html; charset=utf-8");

            // Send message
            Transport.send(message);

            System.out.println("Done");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
