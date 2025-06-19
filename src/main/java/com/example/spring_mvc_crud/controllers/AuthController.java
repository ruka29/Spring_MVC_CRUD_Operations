package com.example.spring_mvc_crud.controllers;

import com.example.spring_mvc_crud.services.UserServices;
import com.example.spring_mvc_crud.utils.JWTUtil;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/auth")
public class AuthController {
    private final UserServices userServices;

    @Autowired
    public AuthController(UserServices userServices) {
        this.userServices = userServices;
    }

    @GetMapping("/login")
    public String showLogin() {
        return "login";
    }

    @GetMapping("/register")
    public String showRegister() {
        return "register";
    }

    @GetMapping("/logout")
    public String logout(HttpServletResponse response) {
        Cookie cookie = new Cookie("jwt_token", null);
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);

        return "redirect:/educenter.com/auth/login";
    }

    @PostMapping("/register")
    public String userRegister(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("mobile") String mobile,
            @RequestParam("password") String password,
            Model model
    ) {
        String message = userServices.registerUser(name, email, mobile, password);
        model.addAttribute("message", message);

        if (message.equals("Registration successful!")) {
            return "redirect:/educenter.com/auth/login";
        } else {
            return "register";
        }
    }

    @PostMapping("/login")
    public String userLogin(
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            HttpServletResponse response,
            Model model
    ) {
        String userRole = userServices.login(email, password);

        if (userRole == null) {
            model.addAttribute("error", "Invalid Email or Password!");
            return "login";
        } else if (userRole.equals("admin")) {
            String token = JWTUtil.generateToken(email);

            Cookie cookie = new Cookie("jwt_token", token);
            cookie.setHttpOnly(true);
            cookie.setPath("/");
            cookie.setMaxAge(3600);
            response.addCookie(cookie);

            return "redirect:/educenter.com/admin-dashboard";
        } else {
            String token = JWTUtil.generateToken(email);

            Cookie cookie = new Cookie("jwt_token", token);
            cookie.setHttpOnly(true);
            cookie.setPath("/");
            cookie.setMaxAge(3600);
            response.addCookie(cookie);


            return "redirect:/educenter.com/dashboard";
        }
    }
}
