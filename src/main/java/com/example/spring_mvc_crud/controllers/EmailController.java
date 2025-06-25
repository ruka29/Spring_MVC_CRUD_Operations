package com.example.spring_mvc_crud.controllers;

import com.example.spring_mvc_crud.services.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/email")
public class EmailController {
    @Autowired
    EmailService emailService;

    @GetMapping("/send")
    public String sendEmail(
            @RequestParam("receiverEmail") String receiverEmail,
            @RequestParam("message") String message,
            RedirectAttributes redirectAttributes
    ) {
        try {
            boolean isMailSent = emailService.sendEmail(receiverEmail);

            if (isMailSent) {
                redirectAttributes.addFlashAttribute("message", message);
            } else {
                redirectAttributes.addFlashAttribute("message", "User Updated, Failed to Send Email!");
            }

            return "redirect:/educenter.com/dashboard";
        } catch (Exception e) {
            e.printStackTrace();
            return "server-error";
        }
    }
}
