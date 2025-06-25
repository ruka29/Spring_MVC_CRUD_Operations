package com.example.spring_mvc_crud.controllers;

import com.example.spring_mvc_crud.services.UserServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Objects;

import static java.lang.Integer.parseInt;

@Controller
@RequestMapping("/manage-users")
public class UserController {
    private final UserServices userServices;

    @Autowired
    public UserController(UserServices userServices) {
        this.userServices = userServices;
    }

    @PostMapping("/add")
    public String addUser(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("mobile") String mobile,
            @RequestParam("password") String password,
            @RequestParam("role") String role,
            RedirectAttributes redirectAttributes
    ) {
        try {
            String message = userServices.addUser(name, email, mobile, password, role);

            if (message.equals("Registration successful!")) {
                redirectAttributes.addFlashAttribute("message", message);
            } else {
                redirectAttributes.addFlashAttribute("error", message);
            }

            return "redirect:/educenter.com/dashboard";
        } catch (Exception e) {
            e.printStackTrace();
            return "server-error";
        }
    }

    @PostMapping("/update")
    public String updateUser(
            @RequestParam("id") String id,
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("mobile") String mobile,
            @RequestParam(value = "reset", required = false) String resetPwd,
            RedirectAttributes redirectAttributes
    ) {
        String password = null;

        if (Objects.equals(resetPwd, "on")) {
            password = "user123";
        }

        try {
            String message = userServices.updateUser(parseInt(id), name, email, mobile, password);

            if (password != null && message.equals("User Updated Successfully!")) {
                redirectAttributes.addAttribute("message", message);
                redirectAttributes.addAttribute("receiverEmail", email);

                return "redirect:/educenter.com/email/send";
            }

            if (message.equals("User Updated Successfully!")) {
                redirectAttributes.addFlashAttribute("message", message);
            } else {
                redirectAttributes.addFlashAttribute("error", message);
            }

            return "redirect:/educenter.com/dashboard";
        } catch (Exception e) {
            e.printStackTrace();
            return "server-error";
        }
    }

    @PostMapping("/save")
    public String editProfile(
            @RequestParam("id") String id,
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("mobile") String mobile,
            @RequestParam(value = "password", required = false) String password,
            RedirectAttributes redirectAttributes
    ) {

        try {
            String message = userServices.updateUser(parseInt(id), name, email, mobile, password);

            if (message.equals("User Updated Successfully!")) {
                redirectAttributes.addFlashAttribute("message", message);
            } else {
                redirectAttributes.addFlashAttribute("error", message);
            }

            return "redirect:/educenter.com/dashboard";
        } catch (Exception e) {
            e.printStackTrace();
            return "server-error";
        }
    }

    @PostMapping("/delete")
    public String deleteUser(
            @RequestParam("id") int id,
            RedirectAttributes redirectAttributes
    ) {

        try {
            int result = userServices.deleteUser(id);
//            boolean isDeleted = userServices.deleteUser(id);
            if (result > 0) {
                redirectAttributes.addFlashAttribute("message", "User deleted successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Oops..! Something went wrong!");
            }
            return "redirect:/educenter.com/dashboard";
        } catch (Exception e) {
            e.printStackTrace();
            return "server-error";
        }

    }
}
