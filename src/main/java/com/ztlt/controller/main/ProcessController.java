package com.ztlt.controller.main;

import com.ztlt.entity.Process;
import com.ztlt.entity.ProcessExample;
import com.ztlt.entity.Project;
import com.ztlt.entity.User;
import com.ztlt.service.ProcessService;
import com.ztlt.service.ProjectService;
import com.ztlt.service.UserService;
import com.ztlt.util.EasyUIDataGridResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ProcessController {

    @Autowired
    private ProcessService processService;
    @Autowired
    private ProjectService projectService;
    @Autowired
    private UserService userService;

    @RequestMapping("/getProcess")
    @ResponseBody
    public EasyUIDataGridResult getProcess(String rows,String page){
        int start=Integer.parseInt(page);
        int end=Integer.parseInt(rows);
        List<Map> list = new ArrayList<Map>();
        ProcessExample processExample = new ProcessExample();
        processExample.setStratRow((start-1)*end+1);
        processExample.setEndRow(start*end);
        List<Process> processes = processService.selectByExamplePage(processExample);
        for(Process p:processes){
            Project project = projectService.selectByPrimaryKey(p.getpId());
            User user = userService.selectByPrimaryKey(p.getuId());
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("pName",project.getpName());
            map.put("pCaptain",project.getpCaptain());
            map.put("uName",user.getuRName());
            map.put("cTime",new SimpleDateFormat("yyyy-MM-dd").format(p.getcTime()));
            map.put("fraction",p.getFraction());

            list.add(map);
        }
        EasyUIDataGridResult result=new EasyUIDataGridResult();
        result.setRows(list);
        long l = processService.countByExample(new ProcessExample());
        result.setTotal((int)l);
        return result;
    }
}
