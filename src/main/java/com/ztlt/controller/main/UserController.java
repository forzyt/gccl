package com.ztlt.controller.main;

import com.ztlt.entity.User;
import com.ztlt.entity.UserExample;
import com.ztlt.service.UserService;
import com.ztlt.util.TestUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("user/login")
    @ResponseBody
    public TestUtil login(User user, HttpServletRequest request){
        UserExample userExample = new UserExample();
        UserExample.Criteria criteria = userExample.createCriteria();
        criteria.andUNameEqualTo(user.getuName());
        criteria.andPwdEqualTo(user.getPwd());
        List<User> users = userService.selectByExample(userExample);
        TestUtil testUtil = new TestUtil();
        if(users.size()>0){
            testUtil.setResultCode(0);
            request.getSession().setAttribute("userName",user.getuName());
            request.getSession().setAttribute("Uid",users.get(0).getId());
            User user1=(User)users.get(0);
            request.getSession().setAttribute("user",user1);
        }else {
            testUtil.setResultCode(1);
            testUtil.setResultMsg("登录失败，账号或密码有误！");
        }
        return testUtil;
    }
}
