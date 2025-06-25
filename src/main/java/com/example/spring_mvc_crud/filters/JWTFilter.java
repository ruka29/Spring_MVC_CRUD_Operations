package com.example.spring_mvc_crud.filters;

import com.example.spring_mvc_crud.utils.JWTUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class JWTFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        if (uri.endsWith("login") || uri.endsWith("logout") || uri.endsWith("register") || uri.endsWith("send") || uri.endsWith("change-password")) {
            chain.doFilter(request, response);
            return;
        }

        String token = null;

        if (req.getCookies() != null) {
            for (Cookie cookie : req.getCookies()) {
                if (cookie.getName().equals("jwt_token")) {
                    token = cookie.getValue();
                    break;
                }
            }
        }

        if (token == null || JWTUtil.validateToken(token) == null) {
            res.sendRedirect("/educenter.com/auth/login");
        } else {
            req.setAttribute("user", JWTUtil.validateToken(token));
            chain.doFilter(request, response);
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
