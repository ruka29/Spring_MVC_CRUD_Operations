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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

    @GetMapping("/change-password")
    public String showChangePassword(
            @RequestParam("token") String token,
            Model model
    ) {
        String email = JWTUtil.validateToken(token);
        model.addAttribute("email", email);
        return "change-password";
    }

    @PostMapping("/change-password")
    public String changePassword(
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            RedirectAttributes redirectAttributes
    ) {
        try {
            String message = userServices.changePassword(email, password);
            redirectAttributes.addFlashAttribute("message", message);

            return "redirect:/educenter.com/auth/login";
        } catch (Exception e) {
            e.printStackTrace();
            return "server-error";
        }
    }

    @PostMapping("/register")
    public String userRegister(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("mobile") String mobile,
            @RequestParam("password") String password,
            Model model
    ) {
        try {
            String message = userServices.registerUser(name, email, mobile, password);
            model.addAttribute("message", message);

            if (message.equals("Registration successful!")) {
                return "redirect:/educenter.com/auth/login";
            } else {
                return "register";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "server-error";
        }
    }

    @PostMapping("/login")
    public String userLogin(
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            HttpServletResponse response,
            Model model
    ) {
        try {
            boolean isValid = userServices.login(email, password);

            if (isValid) {
                String token = JWTUtil.generateToken(email);

                Cookie cookie = new Cookie("jwt_token", token);
                cookie.setHttpOnly(true);
                cookie.setPath("/");
                cookie.setMaxAge(3600);
                response.addCookie(cookie);

                return "redirect:/educenter.com/dashboard";
            } else {
                model.addAttribute("error", "Invalid Email or Password!");
                return "login";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "server-error";
        }
    }
}
