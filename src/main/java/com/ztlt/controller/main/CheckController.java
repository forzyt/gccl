package com.ztlt.controller.main;

import com.ztlt.entity.*;
import com.ztlt.service.*;
import com.ztlt.util.EasyUIDataGridResult;
import com.ztlt.util.TestUtiles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CheckController {

    @Autowired
    private CheckService checkService;
    @Autowired
    private ProjectService projectService;
    @Autowired
    private UserService userService;
    @Autowired
    private CheckRecordService checkRecordService;
    @Autowired
    private DrecordService drecordService;
    @Autowired
    private RecordService recordService;

    //获取各个工程的所有上报记录
    @RequestMapping("getChecks")
    @ResponseBody
    public EasyUIDataGridResult getProject(String rows, String page){
        int start=Integer.parseInt(page);
        int end=Integer.parseInt(rows);
        CheckExample checkExample = new CheckExample();
        checkExample.setStratRow((start-1)*end+1);
        checkExample.setEndRow(end*start);

        List<Check> checks = checkService.selectByExamplePage(checkExample);
        EasyUIDataGridResult result = new EasyUIDataGridResult();
        List list=new ArrayList();
        if(checks.size()>0){
            for(Check c:checks){
                System.out.println(c.toString());
                Map map=new HashMap<String,Object>();
                map.put("fraction",c.getFraction());
                map.put("cTime",c.getcTime());
                map.put("pcState",c.getPcState());
                map.put("id",c.getId());
                Record record = recordService.selectByPrimaryKey(c.getrId());
                if(record!=null){
                    map.put("pSchedule",record.getpSchedule());
                }else{
                    map.put("pSchedule","");
                }
                User user = userService.selectByPrimaryKey(c.getuId());
                map.put("uRName",user.getuRName());
                Project project = projectService.selectByPrimaryKey(c.getpId());
                map.put("pCaptain",project.getpCaptain());
                map.put("pName",project.getpName());
                list.add(map);
            }
        }
        result.setRows(list);

        long l = checkService.countByExample(new CheckExample());
        result.setTotal((int)l);
        return  result;
    }

    @RequestMapping("getCheck")
    @ResponseBody
    public TestUtiles getCheck(String id){
        System.out.println(id);
        Check check = checkService.selectByPrimaryKey(new BigDecimal(Integer.parseInt(id)));
        TestUtiles testUtiles=new TestUtiles();
        if(check!=null){
            testUtiles.setResultOBJ(check);
            testUtiles.setResultCode(0);
            return testUtiles;
        }else{
            testUtiles.setResultCode(1);
            return testUtiles;
        }
    }

    @RequestMapping("getRecords")
    @ResponseBody
    public TestUtiles getRecord(String id){
        System.out.println(id);
        CheckRecordExample checkRecordExample = new CheckRecordExample();
        CheckRecordExample.Criteria criteria = checkRecordExample.createCriteria();
        criteria.andPcIdEqualTo(new BigDecimal(Integer.parseInt(id)));
        List<CheckRecord> checkRecords = checkRecordService.selectByExample(checkRecordExample);
        TestUtiles testUtiles = new TestUtiles();
        if(checkRecords.size()>0){
            testUtiles.setResultOBJ(checkRecords);
            testUtiles.setResultCode(0);
            return testUtiles;
        }else{
         testUtiles.setResultCode(1);
         return testUtiles;
        }
    }

    @RequestMapping("getDrecord")
    @ResponseBody
    public TestUtiles getDrecord(String id){
        System.out.println(id);
        DrecordExample drecordExample = new DrecordExample();
        DrecordExample.Criteria criteria = drecordExample.createCriteria();
        criteria.andRIdEqualTo(new BigDecimal(Integer.parseInt(id)));
        List<Drecord> drecords = drecordService.selectByExample(drecordExample);
        TestUtiles testUtiles = new TestUtiles();
        if(drecords.size()>0){
            testUtiles.setResultOBJ(drecords);
            testUtiles.setResultCode(0);
            return testUtiles;
        }else{
            testUtiles.setResultCode(1);
            return testUtiles;
        }
    }
    @RequestMapping("getProjectCheck")
    @ResponseBody
    public EasyUIDataGridResult getProjectCheck(String rows,String page,String pName){
        System.out.println(pName);
        int start=Integer.parseInt(page);
        int end=Integer.parseInt(rows);
        ProjectExample projectExample=new ProjectExample();
        projectExample.setStratRow((start-1)*end+1);
        projectExample.setEndRow(end*start);
        projectExample.setName(pName);
        if (null != pName && !"".equals(pName)) {
            projectExample.setName(pName);
            ProjectExample.Criteria criteria = projectExample.createCriteria();
            criteria.andPNameLike("'%"+pName+"%'");
        }
        List<Project> projects = projectService.selectByExamplePage(projectExample);
        EasyUIDataGridResult result = new EasyUIDataGridResult();
        List list=new ArrayList<Map<String,Object>>();
        for(Project p:projects){
            Map<String,Object> map=new HashMap<String,Object>();
            map.put("pNumber",p.getpNumber());
            map.put("pName",p.getpName());
            map.put("pCaptain",p.getpCaptain());
            map.put("pType",p.getpType());
            RecordExample recordExample = new RecordExample();
            recordExample.createCriteria().andPIdEqualTo(p.getpNumber());
            recordExample.createCriteria().andPrStateEqualTo(new BigDecimal(0));
            List<Record> records = recordService.selectByExample(recordExample);
            map.put("noCheck",records.size());
            list.add(map);
        }
        result.setRows(list);
        ProjectExample projectExample1 = new ProjectExample();
        ProjectExample.Criteria criteria = projectExample1.createCriteria();
        criteria.andPStateEqualTo(new BigDecimal(0));
        long l = projectService.countByExample(projectExample1);
        if (null != pName && !"".equals(pName)) {
            int i=0;
            for(Project p:projects){
                i++;
            }
            result.setTotal(i);
        }else {
            result.setTotal((int) l);
        }
        return  result;
    }
    //模糊查询工程
    @RequestMapping("getLikeProjectCheck")
    @ResponseBody
    public EasyUIDataGridResult getLikeProject(String rows,String page,String pName,String pFType,String pType){
        System.out.println(pName+"  "+pFType+"  "+pType);
        int start=Integer.parseInt(page);
        int end=Integer.parseInt(rows);
        ProjectExample projectExample=new ProjectExample();
        projectExample.setStratRow((start-1)*end+1);
        projectExample.setEndRow(end*start);
        projectExample.setName(pName);
        projectExample.setpFType(pFType);
        projectExample.setpType(pType);
        List<Project> projects = projectService.selectByExamplePage2(projectExample);
        List list=new ArrayList<Map<String,Object>>();
        for(Project p:projects){
            Map<String,Object> map=new HashMap<String,Object>();
            map.put("pNumber",p.getpNumber());
            map.put("pName",p.getpName());
            map.put("pCaptain",p.getpCaptain());
            map.put("pType",p.getpType());
            RecordExample recordExample = new RecordExample();
            recordExample.createCriteria().andPIdEqualTo(p.getpNumber());
            recordExample.createCriteria().andPrStateEqualTo(new BigDecimal(0));
            List<Record> records = recordService.selectByExample(recordExample);
            map.put("noCheck",records.size());
            list.add(map);
        }
        EasyUIDataGridResult result = new EasyUIDataGridResult();
        result.setRows(list);
        if (null != pName && !"".equals(pName)) {
            int i=0;
            for(Project p:projects){
                i++;
            }
            result.setTotal(i);
        }else if(pFType!=null && !pFType.equals("0")){
            int i=0;
            for(Project p:projects){
                i++;
            }
            result.setTotal(i);
        }else {
            ProjectExample projectExample1 = new ProjectExample();
            ProjectExample.Criteria criteria = projectExample1.createCriteria();
            criteria.andPStateEqualTo(new BigDecimal(0));
            long l = projectService.countByExample(projectExample1);
            result.setTotal((int) l);
        }
        return  result;
    }
}
