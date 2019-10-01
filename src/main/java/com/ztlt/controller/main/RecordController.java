package com.ztlt.controller.main;

import com.alibaba.fastjson.JSON;
import com.ztlt.entity.*;
import com.ztlt.entity.Process;
import com.ztlt.service.*;
import com.ztlt.util.EasyUIDataGridResult;
import com.ztlt.util.TestUtiles;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class RecordController {

    @Autowired
    private RecordService recordService;
    @Autowired
    private UserService userService;
    @Autowired
    private ProcessService processService;
    @Autowired
    private SkedService skedService;
    @Autowired
    private ProjectService projectService;
    @Autowired
    private DrecordService drecordService;

    @RequestMapping("/getRecord")
    @ResponseBody
    public EasyUIDataGridResult getRecord(String rows, String page, HttpServletRequest request){
        int start=Integer.parseInt(page);
        int end=Integer.parseInt(rows);
        RecordExample recordExample = new RecordExample();
        recordExample.setStratRow((start-1)*end+1);
        recordExample.setEndRow(start*end);
        List<Record> records = recordService.selectByExamplePage(recordExample);
        List<Map> list = new ArrayList<Map>();
        for(Record r:records){
            System.out.println(r.getId());
            ProcessExample processExample = new ProcessExample();
            ProcessExample.Criteria criteria = processExample.createCriteria();
            criteria.andRIdEqualTo(r.getId());
            List<Process> processes = processService.selectByExample(processExample);
            for(Process p:processes){
                System.out.println(p.toString()+"****");
            }
            User user = userService.selectByPrimaryKey(r.getuId());
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("pId",r.getId());
            map.put("pRTime",new SimpleDateFormat("yyyy-MM-dd").format(r.getPrTime()));
            map.put("uName",user.getuRName());
            map.put("fraction",processes.get(0).getFraction());
            list.add(map);
        }
        EasyUIDataGridResult result=new EasyUIDataGridResult();
        result.setRows(list);
        long l = recordService.countByExample(new RecordExample());
        result.setTotal((int)l);
        return result;
    }

    @RequestMapping("selectLikeSked")
    @ResponseBody
    public TestUtiles selectLikeSked(String pId, String psId){
        SkedExample skedExample = new SkedExample();
        SkedExample.Criteria criteria = skedExample.createCriteria();
        criteria.andPIdEqualTo(pId);
        criteria.andPsIdEqualTo(new BigDecimal(Integer.parseInt(psId)));
        criteria.andSStateEqualTo(new BigDecimal(0));
        List<Sked> skeds = skedService.selectByExample(skedExample);
        TestUtiles testUtiles = new TestUtiles();
        if(skeds.size()>0){
            HashMap<String, List<Sked>> map = new HashMap<String, List<Sked>>();
            testUtiles.setResultCode(0);
            map.put("skeds",skeds);
            testUtiles.setResultOBJ(map);
            return testUtiles;
        }else{
            testUtiles.setResultMsg("没有相关计划");
            testUtiles.setResultCode(1);
            return testUtiles;
        }
    }

    @RequestMapping("updatepProgress")
    @ResponseBody
    public TestUtiles updatepProgress(Project p){
        int i = projectService.updateByPrimaryKeySelective(p);
        Record record = new Record();
        record.setpSchedule(p.getpProgress());
        RecordExample recordExample = new RecordExample();
        RecordExample.Criteria criteria = recordExample.createCriteria();
        criteria.andPIdEqualTo(p.getpNumber());
        int i1 = recordService.updateByExampleSelective(record, recordExample);
        TestUtiles testUtiles = new TestUtiles();
        if(i>0 || i1>0){
            testUtiles.setResultCode(0);
            return testUtiles;
        }else{
            testUtiles.setResultCode(1);
            return testUtiles;
        }
    }

    @RequestMapping(value="SubmitReport", method= RequestMethod.POST)
    @ResponseBody
    public TestUtiles SubmitReport(@RequestBody Map<String,Object> map){
        System.out.println(map.get("file")+"0");
        System.out.println(map.get("project")+"1");
        System.out.println(map.get("F_TYPE")+"2");
        System.out.println(map.get("TYPE")+"3");
        System.out.println(map.get("record")+"4");

        TestUtiles testUtiles = new TestUtiles();
        Record record=JSON.parseObject(JSON.toJSONString(map.get("record")),Record.class);
        int l=(int)recordService.countByExample(new RecordExample());
        BigDecimal id=new BigDecimal(l+3);
        record.setId(id);
        record.setPrTime(new Date());
        int i = recordService.insertSelective(record);
        if(i>0){
            System.out.println(i+"  成功！");

            if(!record.getpSchedule().equals("")){
                Project project = new Project();
                project.setpNumber(record.getpId());
                project.setpProgress(record.getpSchedule());
                projectService.updateByPrimaryKeySelective(project);
            }
            JSONArray json = JSONArray.fromObject(map.get("file"));
            List<ProjectFile> projectFiles=(List<ProjectFile>)JSONArray.toCollection(json, ProjectFile.class);
            if(!map.get("TYPE").equals("")){
                System.out.println(map.get("TYPE")+"  这是上报异常说明");
                Drecord drecord = new Drecord();
                long l1 = drecordService.countByExample(new DrecordExample());
                drecord.setId(new BigDecimal((int)l1+1));
                drecord.setrId(id);
                drecord.setTpId(new BigDecimal(6));
                drecord.setPdrValue((String)map.get("TYPE"));
                drecord.setdState(new BigDecimal(0));
                drecordService.insertSelective(drecord);
            }
            if(!map.get("F_TYPE").equals("")){
                System.out.println(map.get("F_TYPE")+"  这是异常说明");
                Drecord drecord2 = new Drecord();
                long l2 = drecordService.countByExample(new DrecordExample());
                drecord2.setId(new BigDecimal((int)l2+1));
                drecord2.setrId(id);
                drecord2.setTpId(new BigDecimal(5));
                drecord2.setPdrValue((String)map.get("F_TYPE"));
                drecord2.setdState(new BigDecimal(0));
                drecordService.insertSelective(drecord2);
            }
            if(projectFiles.size()>0) {
                System.out.println("这是上传的资料");
                for (ProjectFile f : projectFiles) {
                    Drecord drecord3 = new Drecord();
                    long l3 = drecordService.countByExample(new DrecordExample());
                    drecord3.setId(new BigDecimal((int) l3 + 1));
                    drecord3.setrId(id);
                    drecord3.setTpId(f.getfId());
                    drecord3.setPdrValue(f.getFileUrl());
                    drecord3.setdRemark(f.getFileName());
                    drecord3.setdState(new BigDecimal(0));
                    drecordService.insertSelective(drecord3);
                }
            }
            testUtiles.setResultCode(0);
            return testUtiles;
        }else{
            testUtiles.setResultCode(1);
            testUtiles.setResultMsg("上报失败，请正确输入！");
            System.out.println("失败!");
            return testUtiles;
        }
    }
}
