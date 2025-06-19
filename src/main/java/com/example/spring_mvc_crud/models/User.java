package com.example.spring_mvc_crud.models;

public class User {
    private int id;
    private String name;
    private String email;
    private String mobile;
    private String password;
    private String role;
    private String image;

//    public User(int id, String name, String email, String mobile, String password, String role, String image) {
//        this.id = id;
//        this.name = name;
//        this.email = email;
//        this.mobile = mobile;
//        this.password = password;
//        this.role = role;
//        this.image = image;
//    }

    public User() {    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }
    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }

    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }
}
