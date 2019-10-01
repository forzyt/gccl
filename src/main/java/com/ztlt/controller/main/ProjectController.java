package com.ztlt.controller.main;

import com.alibaba.fastjson.JSON;
import com.sun.imageio.plugins.common.I18N;
import com.ztlt.entity.*;
import com.ztlt.service.*;
import com.ztlt.util.EasyUIDataGridResult;
import com.ztlt.util.TestUtiles;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class ProjectController {

    @Autowired
    private ProjectService projectService;
    @Autowired
    private ProjectTypeService projectTypeService;
    @Autowired
    private ProjectFileService projectFileService;
    @Autowired
    private SubtaskService subtaskService;
    @Autowired
    private SkedService skedService;

    //获取所有工程
    @RequestMapping("getProject")
    @ResponseBody
    public EasyUIDataGridResult getProject(String rows,String page,String pName){
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
        result.setRows(projects);
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
    @RequestMapping("getLikeProject")
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
        EasyUIDataGridResult result = new EasyUIDataGridResult();
        result.setRows(projects);
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
    //查看某项目的详细信息
    @RequestMapping("showCheckproject")
    public String showCheckproject(String pNumber, HttpServletRequest request,String page,String option){
        System.out.println("当前页:"+page);
        Project project = projectService.selectByPrimaryKey(pNumber);
        String pStartTime = new SimpleDateFormat("yyyy-MM-dd").format(project.getpStartTime());
        String pEndTime = new SimpleDateFormat("yyyy-MM-dd").format(project.getpEndTime());
        ProjectType projectType = projectTypeService.selectByPrimaryKey(project.getpType());
        ProjectType projectType1 = projectTypeService.selectByPrimaryKey(project.getpFType());
        request.setAttribute("typeName",projectType1.getTypeName());
        request.setAttribute("pType",projectType.getTypeName());
        request.setAttribute("pStartTime",pStartTime);
        request.setAttribute("pEndTime",pEndTime);
        request.setAttribute("project",project);
        request.setAttribute("page",page);
        if(option.equals("1")){
            return "checkproject";
        }else {
            return "checkprojectCopy";
        }
    }
    //项目修改前的回显
    @RequestMapping("updateProject")
    public String updateProject(String pNumber,HttpServletRequest request,String page){
        System.out.println(pNumber);
        Project project = projectService.selectByPrimaryKey(pNumber);
        request.setAttribute("project",project);
        request.setAttribute("page",page);
        return "Edit_project";
    }
    //回显文件
    @RequestMapping("getFiles")
    @ResponseBody
    public HashMap<String, Object>  getFiles(String pNumber){
        ProjectFileExample projectFileExample = new ProjectFileExample();
        ProjectFileExample.Criteria criteria = projectFileExample.createCriteria();
        criteria.andPIdEqualTo(pNumber);
        criteria.andFStateEqualTo(new BigDecimal(0));
        List<ProjectFile> projectFiles = projectFileService.selectByExample(projectFileExample);
        HashMap<String, Object> map = new HashMap<String, Object>();
        if(projectFiles.size()>0){
            map.put("files",projectFiles);
            map.put("haveFile",1);
            return map;
        }else{
            map.put("haveFile",0);
            return map;
        }
    }

    //删除文件
    @RequestMapping("updateFileState")
    @ResponseBody
    public TestUtiles updateFileState(String id){
        System.out.println(id);
        ProjectFile projectFile = new ProjectFile();
        projectFile.setId(new BigDecimal(Integer.parseInt(id)));
        projectFile.setfState(new BigDecimal(1));
        int i = projectFileService.updateByPrimaryKeySelective(projectFile);
        System.out.println(i);
        TestUtiles testUtiles = new TestUtiles();
        if(i>0){
            testUtiles.setResultCode(0);
            return testUtiles;
        }else{
            testUtiles.setResultCode(1);
            return testUtiles;
        }
    }

    //回显子任务和计划表
    @RequestMapping("getSubtask")
    @ResponseBody
    public HashMap<String, Object>  getSubtask(String pNumber){
        //子任务
        SubtaskExample subtaskExample = new SubtaskExample();
        SubtaskExample.Criteria criteria = subtaskExample.createCriteria();
        criteria.andPIdEqualTo(pNumber);
        criteria.andSStateEqualTo(new BigDecimal(0));
        List<Subtask> subtasks = subtaskService.selectByExample(subtaskExample);
        //计划表
        SkedExample skedExample = new SkedExample();
        SkedExample.Criteria criteria1 = skedExample.createCriteria();
        criteria1.andPIdEqualTo(pNumber);
        criteria1.andSStateEqualTo(new BigDecimal(0));
        List<Sked> skeds = skedService.selectByExample(skedExample);
        HashMap<String, Object> map = new HashMap<String, Object>();
        if(subtasks.size()>0){
            map.put("subtask",subtasks);
            if(skeds.size()>0){
                map.put("noSked",0);
                map.put("sked",skeds);
            }else{
                map.put("noSked",1);
            }
            map.put("noSubtask",0);
            return map;
        }else{
            if(skeds.size()>0){
                map.put("sked",skeds);
                map.put("noSked",0);
            }else{
                map.put("noSked",1);
            }
            map.put("noSubtask",1);
            return map;
        }
    }
    //修改工程信息
    @RequestMapping(value="updateAddProject", method= RequestMethod.POST)
    @ResponseBody
    public TestUtiles updateAddProject(@RequestBody Map<String,Object> map){
        Project project=JSON.parseObject(JSON.toJSONString(map.get("project")),Project.class);
        int i = projectService.updateByPrimaryKeySelective(project);
        System.out.println(i+"工程");

        //修改文件
        JSONArray json = JSONArray.fromObject(map.get("file"));
        List<ProjectFile> projectFiles=(List<ProjectFile>)JSONArray.toCollection(json, ProjectFile.class);
        if(projectFiles.size()>0){
            for(ProjectFile p:projectFiles){
                ProjectFileExample projectFileExample = new ProjectFileExample();
                ProjectFileExample.Criteria criteria = projectFileExample.createCriteria();
                criteria.andPIdEqualTo(p.getpId());
                criteria.andFileNameEqualTo(p.getFileName());
                criteria.andFStateEqualTo(new BigDecimal(0));
                List<ProjectFile> projectFiles1 = projectFileService.selectByExample(projectFileExample);
                if(projectFiles1.size()==0){
                    long l = projectFileService.countByExample(new ProjectFileExample());
                    p.setId(new BigDecimal((int)l+1));
                    p.setFileTime(new Date());
                    int j = projectFileService.insertSelective(p);
                    System.out.println(j+"文件");
                }
            }
        }
        //修改子任务
        int id=0;
        JSONArray json2 = JSONArray.fromObject(map.get("subtask"));
        List<Subtask> subtasks=(List<Subtask>)JSONArray.toCollection(json2, Subtask.class);
        if(subtasks.size()>0){
            for(Subtask subtask:subtasks){
                if(subtask.getId().intValue()<0){
                    long l = subtaskService.countByExample(new SubtaskExample());
                    id=(int)l+1;
                    subtask.setId(new BigDecimal(id));
                    int s = subtaskService.insertSelective(subtask);
                    System.out.println(s+"子任务");
                }
                System.out.println(subtask.toString()+"0123");
            }
        }
        //修改作业计划
        JSONArray json3 = JSONArray.fromObject(map.get("sked"));
        List<Sked> skeds=(List<Sked>)JSONArray.toCollection(json3, Sked.class);
        if(skeds.size()>0){
            System.out.println(skeds.size()+"进入工作计划区");
            for(Sked sked:skeds){
                if(sked.getId().intValue()<0){
                    try{
                        int ids=0;
                        ids=sked.getPsId().intValue();
                        sked.setPsId(new BigDecimal(ids));
                    }catch (Exception e){
                        System.out.println("数字转换异常！");
                        sked.setPsId(new BigDecimal(id));
                    }
                    long l = skedService.countByExample(new SkedExample());
                    sked.setId(new BigDecimal((int)l+1));
                    int k = skedService.insertSelective(sked);
                    System.out.println(k+" 添加作业计划");
                }else{
                    int i1 = skedService.updateByPrimaryKeySelective(sked);
                    System.out.println(i1+" 修改作业计划");
                }

            }
        }
        TestUtiles testUtiles = new TestUtiles();
        if(i>0){
            testUtiles.setResultCode(0);
            return testUtiles;
        }else{
            testUtiles.setResultCode(1);
            testUtiles.setResultMsg("修改失败,请正确输入！");
            return testUtiles;
        }

    }

    //删除子任务
    @RequestMapping("deleteSubtask")
    @ResponseBody()
    public TestUtiles deleteSubtask(String id){
        System.out.println(id);
        Subtask subtask = subtaskService.selectByPrimaryKey(new BigDecimal(Integer.parseInt(id)));
        subtask.setsState(new BigDecimal(1));
        int i = subtaskService.updateByPrimaryKeySelective(subtask);
        SkedExample skedExample = new SkedExample();
        SkedExample.Criteria criteria = skedExample.createCriteria();
        criteria.andPsIdEqualTo(new BigDecimal(Integer.parseInt(id)));
        List<Sked> skeds = skedService.selectByExample(skedExample);
        if(skeds.size()>0){
            for(Sked sked:skeds){
                sked.setsState(new BigDecimal(1));
                System.out.println(sked.toString()+"删除子任务的作业计划");
                skedService.updateByPrimaryKeySelective(sked);
            }
        }
        TestUtiles testUtiles = new TestUtiles();
        if(i>0){
            testUtiles.setResultOBJ(0);
            return testUtiles;
        }else{
            testUtiles.setResultOBJ(1);
            return testUtiles;
        }
    }

    //添加项目
    @RequestMapping(value="addNewProject", method= RequestMethod.POST)
    @ResponseBody
    public TestUtiles addNewProject(@RequestBody Map<String,Object> map){
        Project project=JSON.parseObject(JSON.toJSONString(map.get("project")),Project.class);
        project.setpTime(new Date());
        int i = projectService.insertSelective(project);
        System.out.println(i+"工程");

        //修改文件
        JSONArray json = JSONArray.fromObject(map.get("file"));
        List<ProjectFile> projectFiles=(List<ProjectFile>)JSONArray.toCollection(json, ProjectFile.class);
        System.out.println(projectFiles.size()+"  1");
        if(projectFiles.size()>0){
            for(ProjectFile p:projectFiles){
                System.out.println(p.toString()+"测试工程文件");
                long l = projectFileService.countByExample(new ProjectFileExample());
                p.setId(new BigDecimal((int)l+1));
                p.setFileTime(new Date());
                int i1 = projectFileService.insertSelective(p);
                System.out.println(i1+"工程相关文件");
            }
        }
        //修改子任务
        int j=0;
        JSONArray json2 = JSONArray.fromObject(map.get("subtask"));
        List<Subtask> subtasks=(List<Subtask>)JSONArray.toCollection(json2, Subtask.class);
        System.out.println(subtasks.size()+"  2");
        if(subtasks.size()>0){
            for(Subtask subtask:subtasks){
                System.out.println("测试子任务");
                long l = subtaskService.countByExample(new SubtaskExample());
                j=(int)l+1;
                subtask.setId(new BigDecimal((int)l+1));
                int i1 = subtaskService.insertSelective(subtask);
                System.out.println(i1+"工程子任务");
            }
        }
        //修改作业计划
        JSONArray json3 = JSONArray.fromObject(map.get("sked"));
        List<Sked> skeds=(List<Sked>)JSONArray.toCollection(json3, Sked.class);
        System.out.println(skeds.size()+"  3");
        if(skeds.size()>0){
            System.out.println(skeds.get(0).getPsName()+" 这里是");
            for(Sked sked:skeds){
                SubtaskExample subtaskExample = new SubtaskExample();
                SubtaskExample.Criteria criteria = subtaskExample.createCriteria();
                criteria.andPIdEqualTo(sked.getpId());
                criteria.andSNameEqualTo(sked.getPsName());
                List<Subtask> subtasks1 = subtaskService.selectByExample(subtaskExample);
                if(subtasks1.size()>0){
                    sked.setPsId(subtasks1.get(0).getId());
                }else{
                    sked.setPsId(new BigDecimal(0));
                }
                System.out.println(sked.toString()+"测试作业计划");
                long l = skedService.countByExample(new SkedExample());
                sked.setId(new BigDecimal((int)l+1));
                int i1 = skedService.insertSelective(sked);
                System.out.println(i1+"工程作业计划");
            }
        }
        TestUtiles testUtiles = new TestUtiles();
        if(i>0){
            testUtiles.setResultCode(0);
            return testUtiles;
        }else{
            testUtiles.setResultCode(1);
            testUtiles.setResultMsg("添加失败,请正确输入！");
            return testUtiles;
        }
    }

    @RequestMapping("deleteProject")
    @ResponseBody
    public TestUtiles deleteProject(String pNumber){
        System.out.println(pNumber);
        Project project = new Project();
        project.setpNumber(pNumber);
        project.setpState(new BigDecimal(1));
        int i = projectService.updateByPrimaryKeySelective(project);
        TestUtiles testUtiles = new TestUtiles();
        if(i>0){
            testUtiles.setResultMsg("0");
            return testUtiles;
        }else{
            testUtiles.setResultMsg("1");
            return testUtiles;
        }
    }
    @RequestMapping("selectSkeds")
    @ResponseBody
    public TestUtiles selectSkeds(String pNumber,String psId){
        System.out.println(pNumber+" "+psId);
        SkedExample skedExample = new SkedExample();
        SkedExample.Criteria criteria = skedExample.createCriteria();
        criteria.andPIdEqualTo(pNumber);
        int i=0;
        try {
            i= Integer.parseInt(psId);
        }catch (Exception e){
            System.out.println("数字转换异常！");
        }
        criteria.andPsIdEqualTo(new BigDecimal(i));
        criteria.andSStateEqualTo(new BigDecimal(0));
        List<Sked> skeds = skedService.selectByExample(skedExample);
        TestUtiles testUtiles = new TestUtiles();
        if(skeds.size()>0){
            testUtiles.setResultOBJ(skeds);
            testUtiles.setResultCode(0);
            return testUtiles;
        }else{
            testUtiles.setResultCode(1);
            return testUtiles;
        }
    }

    @RequestMapping("selectProjects")
    @ResponseBody
    public List<Project> selectProjects(){

        List<Project> projects = projectService.selectByExample(new ProjectExample());
        return projects;
    }
}
