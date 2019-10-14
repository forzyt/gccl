package com.ztlt.controller.main;

import com.ztlt.entity.ProjectType;
import com.ztlt.entity.ProjectTypeExample;
import com.ztlt.service.ProjectTypeService;
import com.ztlt.util.TestUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class MainController {

    //通用的页面跳转
    @RequestMapping("/{page}")
    public String showPage(@PathVariable String page , HttpServletRequest request,String pages) {
        System.out.println(page);
        System.out.println("当前页："+pages);
        request.setAttribute("pages",pages);
        request.setAttribute("path1",request.getParameter("path1"));
        request.setAttribute("path2",request.getParameter("path2"));
        return page;
    }

    @Autowired
    private ProjectTypeService projectTypeService;

    @RequestMapping("/getPtype")
    @ResponseBody
    public TestUtil getPtype(String F_ID){
        ProjectTypeExample projectTypeExample = new ProjectTypeExample();
        ProjectTypeExample.Criteria criteria = projectTypeExample.createCriteria();
        criteria.andFIdEqualTo(new BigDecimal(Integer.parseInt(F_ID)));
        List<ProjectType> projectTypes = projectTypeService.selectByExample(projectTypeExample);
        TestUtil testUtil = new TestUtil();
        if(projectTypes.size()>0){
            testUtil.setResultCode(0);
            testUtil.setResultOBJ(projectTypes);
        }else{
            testUtil.setResultMsg("暂无工程类型");
        }
        return testUtil;
    }

    @RequestMapping(value="/testPro",produces="text/html;charset=utf-8;")
    @ResponseBody
    public Map<String, Object> testPro(HttpServletRequest request){
        Map<String, Object> mapA = WebUtils.getParametersStartingWith(request, "aaa");
        Map<String, Object> mapB = WebUtils.getParametersStartingWith(request, "bbb");

        //4通过map.entrySet遍历key和value(推荐使用，特别是容量大时)
        System.out.println("通过map.entrySet遍历key和value(推荐使用，特别是容量大时)");
        for(Map.Entry<String, Object> entry:mapA.entrySet()){
            System.out.println("key="+entry.getKey()+"\tvalue="+entry.getValue());
        }
        //4通过map.entrySet遍历key和value(推荐使用，特别是容量大时)
        System.out.println("通过map.entrySet遍历key和value(推荐使用，特别是容量大时)");
        for(Map.Entry<String, Object> entry:mapB.entrySet()){
            System.out.println("key="+entry.getKey()+"\tvalue="+entry.getValue());
        }
        return mapA;
    }
}
