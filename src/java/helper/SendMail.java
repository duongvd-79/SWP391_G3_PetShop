package helper;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
 
public class SendMail {
    //vhpqgbufgukwzvou
    public static void sendMail(String receiver, String subject,String info){   
        final String username = "pets74007@gmail.com";   
        final String password = "vhpqgbufgukwzvou";
         
        // or IP address
        final String host = "localhost"; 
 
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
            protected PasswordAuthentication getPasswordAuthentication() {                    
                return new PasswordAuthentication(username, password);
            }
          });
 
        try {
             
            Message message = new MimeMessage(session);  
            //sender
            message.setFrom(new InternetAddress("pets74007@gmail.com")); 
            //receiver
            message.setRecipients(Message.RecipientType.TO,
                InternetAddress.parse(receiver));
            message.setSubject(subject);
            message.setText(info);
 
            Transport.send(message);         //send Message
 
            System.out.println("Done");
 
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}