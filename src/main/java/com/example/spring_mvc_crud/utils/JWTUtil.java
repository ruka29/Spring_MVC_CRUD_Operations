package com.example.spring_mvc_crud.utils;

import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

import java.security.Key;
import java.util.Date;

public class JWTUtil {
    private static final Key key = Keys.hmacShaKeyFor("JzT5l5Hk2x8eK3P4r9sEwM7vYzB1uF2tCjNdRgUhXyZkPlQmWvNtGdHjKsLfQeRxT".getBytes());
    private static final long ExpirationTime = 3600000;

    public static String generateToken(String email) {
        return Jwts.builder()
                .setSubject(email)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + ExpirationTime))
                .signWith(key)
                .compact();
    }

    public static String validateToken(String token) {
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(key)
                    .build()
                    .parseClaimsJws(token)
                    .getBody()
                    .getSubject();
        } catch (JwtException e) {
            e.printStackTrace();
            return null;
        }
    }
}
