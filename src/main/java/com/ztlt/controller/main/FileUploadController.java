package com.ztlt.controller.main;

import com.alibaba.druid.util.StringUtils;
import com.ztlt.util.TestUtil;
import com.ztlt.util.TestUtiles;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;

//SpringMVC实现文件上传功能
@Controller
public class FileUploadController {
    private static final long MAX_FILE_SISE = 1000000;

    @RequestMapping("/upload")
    @ResponseBody
    public TestUtiles uploadFile(@RequestParam("file") MultipartFile file, HttpServletRequest request,String filePaths) {
        String path = request.getSession().getServletContext().getRealPath("/");
        path = path.replaceAll("\\\\", "/");
        path= StringUtils.subString(path,"","target")+filePaths+"/";
        TestUtiles testUtiles=new TestUtiles();
        if(!file.isEmpty()) {
            //获取文件类型
            String contentType = file.getContentType();
            if(!contentType.equals("")) {
                //可以对文件类型进行检查
            }
            //获取input域的name属性
            String name = file.getName();
            //获取文件名，带扩展名
            String originFileName = file.getOriginalFilename();
            //获取文件扩展名
            String extension = originFileName.substring(originFileName.lastIndexOf("."));
            //获取文件大小，单位字节
            long site = file.getSize();
            if(site > MAX_FILE_SISE) {
                //可以对文件大小进行检查
            }
            //构造文件上传后的文件绝对路径，这里取系统时间戳＋文件名作为文件名
            //不推荐这么写，这里只是举例子，这么写会有并发问题
            //应该采用一定的算法生成独一无二的的文件名
            //获取不带扩展名的文件名
            String names=StringUtils.subString(originFileName, "",".");
            String fileName = names+String.valueOf(System.currentTimeMillis()) + extension;
            String filePath=path+fileName;
            File file1 = new File(path);
            file1.mkdirs();
            System.out.println(filePath);
            try {
                file.transferTo(new File(filePath));
            } catch (Exception e) {
                e.printStackTrace();
            }
            testUtiles.setResultCode(0);
            testUtiles.setResultMsg(originFileName);
            testUtiles.setResultOBJ(filePaths+"/"+fileName);
            testUtiles.setFilePath(filePath);
            return  testUtiles;
        }else {
            testUtiles.setResultCode(1);
            return testUtiles;
        }
    }

    @RequestMapping("deleteFile")
    @ResponseBody
    public TestUtiles deleteFile(String filePath){
        File delFile = new File(filePath);
        TestUtiles testUtiles = new TestUtiles();
        if(delFile.isFile() && delFile.exists()) {
            delFile.delete();
            System.out.println("删除文件成功");
            testUtiles.setResultCode(0);
            return testUtiles;
        }else {
            System.out.println("没有该文件，删除失败");
            testUtiles.setResultCode(1);
            return testUtiles;
        }
    }
}
