//package com.example.spring_mvc_crud.controllers;
//
//import com.example.spring_mvc_crud.models.User;
//import com.example.spring_mvc_crud.services.UserServices;
//import com.example.spring_mvc_crud.utils.JWTUtil;
//import jakarta.servlet.http.Cookie;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import java.util.List;
//
//@Controller
//public class MainController {
//    private final UserServices userServices;
//
//    @Autowired
//    public MainController(UserServices userServices) {
//        this.userServices = userServices;
//    }
//
//    @RequestMapping("/")
//    public String directUser(HttpServletRequest request, HttpServletResponse response, Model model) {
//        String token = null;
//        String userEmail;
//        Cookie[] cookies = request.getCookies();
//
//        for (Cookie cookie : cookies) {
//            if (cookie.getName().equals("jwt_token")) {
//                token = cookie.getValue();
//                break;
//            }
//        }
//
//        if (token != null) {
//            userEmail = JWTUtil.validateToken(token);
//            User user = userServices.getUserByEmail(userEmail);
//
//            List<User> allUsers = userServices.getAllUsers();
//            model.addAttribute("allUsers", allUsers);
//            model.addAttribute("user", user);
//
//            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
//            response.setHeader("Pragma", "no-cache");
//            response.setDateHeader("Expires", 0);
//
//            return "redirect:/educenter.com/dashboard";
//        } else {
//            return "redirect:/educenter.com/auth/login";
//        }
//    }
//}
