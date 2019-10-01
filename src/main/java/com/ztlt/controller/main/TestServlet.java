package com.ztlt.controller.main;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class TestServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        System.out.println("进入 init 方法");
    }

    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        System.out.println("进入 service 方法");
    }

    public void doPost(HttpServletRequest request,HttpServletResponse response){
        System.out.println("进入 doPost 方法");
    }

    public void doGet(HttpServletResponse response,HttpServletRequest request){
        System.out.println("进入 doPost 方法");
    }

    @Override
    public void destroy() {
        System.out.println("进入 destroy 方法");
    }
}
