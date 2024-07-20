package helper;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

public class SendMail {

    private static final String USERNAME = "pets74007@gmail.com";
    private static final String PASSWORD = "vhpqgbufgukwzvou"; // Consider using environment variables for sensitive data
    private static final String HOST = "smtp.gmail.com";
    private static final String PORT = "587";
    private static final Properties PROPS = new Properties();
    private static final Session SESSION;

    static {
        PROPS.put("mail.smtp.auth", "true");
        PROPS.put("mail.smtp.starttls.enable", "true");
        PROPS.put("mail.smtp.host", HOST);
        PROPS.put("mail.smtp.port", PORT);

        SESSION = Session.getInstance(PROPS, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, PASSWORD);
            }
        });
    }

    public static void sendMail(String receiver, String subject, String info) {
        try {
            Message message = new MimeMessage(SESSION);
            message.setFrom(new InternetAddress(USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(receiver));
            message.setSubject(subject);
            message.setText(info);
            Transport.send(message);
            System.out.println("Email sent successfully");
        } catch (MessagingException e) {
            System.err.println("Failed to send email: " + e.getMessage());
        }
    }
}
