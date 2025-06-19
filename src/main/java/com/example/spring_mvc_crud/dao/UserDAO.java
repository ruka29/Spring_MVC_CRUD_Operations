package com.example.spring_mvc_crud.dao;

import com.example.spring_mvc_crud.models.User;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private JdbcTemplate userTemplate;

    public void setUserTemplate(JdbcTemplate userTemplate) {
        this.userTemplate = userTemplate;
    }

    public User findUserByEmail(String email) {
        String query = "SELECT * FROM users WHERE email = ?";

        try {
            return userTemplate.queryForObject(
                    query,
                    new Object[] { email },
                    new BeanPropertyRowMapper<>(User.class)
            );
        } catch (Exception e) {
            return null;
        }
    }

    public int registerUser(User user) {
        String query = "INSERT INTO users (name, email, mobile, password, role) VALUES (?,?,?,?,?)";

        try {
            return userTemplate.update(
                    query,
                    user.getName(),
                    user.getEmail(),
                    user.getMobile(),
                    user.getPassword(),
                    user.getRole() == null ? "guest" : user.getRole()
            );
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public int updateUser(User user) {
        String query = "UPDATE users SET name = ?, email = ?, mobile = ? WHERE id = ?";

        try {
            return userTemplate.update(
                    query,
                    user.getName(),
                    user.getEmail(),
                    user.getMobile(),
                    user.getId()
            );
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public int updateUserWithPwd(User user) {
        String query = "UPDATE users SET name = ?, email = ?, mobile = ?, password = ? WHERE id = ?";

        try {
            return userTemplate.update(
                    query,
                    user.getName(),
                    user.getEmail(),
                    user.getMobile(),
                    user.getPassword(),
                    user.getId()
            );
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users";

        try {
            users = userTemplate.query(query, new BeanPropertyRowMapper<>(User.class));
        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }

    public int deleteUser(int id) {
        String query = "DELETE FROM users WHERE id = ?";

        try {
            return userTemplate.update(query, id);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}
