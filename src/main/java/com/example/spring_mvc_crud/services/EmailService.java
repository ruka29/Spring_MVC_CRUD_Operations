package com.example.spring_mvc_crud.services;

import com.example.spring_mvc_crud.utils.JWTUtil;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
    @Autowired
    private JavaMailSender mailSender;

    public boolean sendEmail(String receiverEmail) {
        MimeMessage message = mailSender.createMimeMessage();

        String token = JWTUtil.generateToken(receiverEmail);

        try {
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            helper.setTo(receiverEmail);
            helper.setSubject("Change Password");

            String resetUrl = "http://localhost:8080/educenter.com/auth/change-password?token=" + token;
            String htmlContent = "<p>Your password has been reset. Please <a href='" + resetUrl + "'>click here</a> to change your password.</p>";

            helper.setText(htmlContent, true);
            mailSender.send(message);

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
