package com.example.spring_mvc_crud.services;

import com.example.spring_mvc_crud.dao.UserDAO;
import com.example.spring_mvc_crud.models.User;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;

@Service
public class UserServices {
    private final UserDAO userDAO;

    @Autowired
    public UserServices(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    public String registerUser(String name, String email, String mobile, String password) {
        boolean userExists = isUserExists(email);

        if (userExists) {
            return "User already exists!";
        } else {
            User user = new User();

            user.setName(name);
            user.setEmail(email);
            user.setMobile(mobile);
            user.setPassword(hashPwd(password));

            int result = userDAO.registerUser(user);

            if (result > 0) {
                return "Registration successful!";
            } else {
                return "Oops..! Something went wrong!";
            }
        }
    }

    public String addUser(String name, String email, String mobile, String password, String role) {
        boolean userExists = isUserExists(email);

        if (userExists) {
            return "User already exists!";
        } else {
            User user = new User();

            user.setName(name);
            user.setEmail(email);
            user.setMobile(mobile);
            user.setPassword(hashPwd(password));
            user.setRole(role);

            int result = userDAO.registerUser(user);

            if (result > 0) {
                return "Registration successful!";
            } else {
                return "Oops..! Something went wrong!";
            }
        }
    }

    public String updateUser(int id, String name, String email, String mobile, String password) {
        User user = new User();

        if (password != null) {
            user.setId(id);
            user.setName(name);
            user.setEmail(email);
            user.setMobile(mobile);
            user.setPassword(hashPwd(password));

            int result = userDAO.updateUserWithPwd(user);

            if (result > 0) {
                return "User Updated Successfully!";
            } else {
                return "Oops..! Something went wrong!";
            }

        } else {
            user.setId(id);
            user.setName(name);
            user.setEmail(email);
            user.setMobile(mobile);

            int result = userDAO.updateUser(user);

            if (result > 0) {
                return "User Updated Successfully!";
            } else {
                return "Oops..! Something went wrong!";
            }
        }
    }

    public String login (String email, String password) {
        User user = userDAO.findUserByEmail(email);

        if (user != null) {
            if (BCrypt.checkpw(password, user.getPassword())) {
                return user.getRole();
            };
        }

        return null;
    }

    public boolean isUserExists(String email) {
        boolean userExits = false;

        User user = userDAO.findUserByEmail(email);

        if (user != null) {
            userExits = true;
        }

        return userExits;
    }

    public User getUserByEmail(String email) {
        return userDAO.findUserByEmail(email);
    }

    public String hashPwd(String password) {
        String hashedPwd;

        hashedPwd = BCrypt.hashpw(password, BCrypt.gensalt());

        return hashedPwd;
    }

    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    public int deleteUser(int id) {
        return userDAO.deleteUser(id);
    }
}
