package com.example.spring_mvc_crud.controllers;

import com.example.spring_mvc_crud.models.User;
import com.example.spring_mvc_crud.services.UserServices;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class DashboardController {
    private final UserServices userServices;

    @Autowired
    public DashboardController(UserServices userServices) {
        this.userServices = userServices;
    }

    @RequestMapping("/dashboard")
    public String adminDashboard(HttpServletRequest request, HttpServletResponse response, Model model) {
        String userEmail = (String) request.getAttribute("user");

        try {
            User user = userServices.getUserByEmail(userEmail);

            if (user.getRole().equals("admin")) {
                List<User> allUsers = userServices.getAllUsers();
                model.addAttribute("allUsers", allUsers);
                model.addAttribute("user", user);

                return "dashboard";
            } else {
                model.addAttribute("user", user);

                return "user-dashboard";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "server-error";
        }
    }
}
