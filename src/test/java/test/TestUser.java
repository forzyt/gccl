package test;

import com.ztlt.entity.*;
import com.ztlt.mapper.UserMapper;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

public class TestUser {
    private ClassPathXmlApplicationContext appCtx;

    UserMapper userMapper;
    @Before
    public void init() {
        appCtx = new ClassPathXmlApplicationContext(
                "classpath:/spring/applicationContext.xml", "classpath:/mybatis/mybatis-config.xml");
        userMapper = appCtx.getBean( "userMapper",UserMapper.class);
    }

    @Test
    public void selectAllStudent(){
        System.out.println("gogogogog");
        UserExample userExample = new UserExample();
        List<User> users = userMapper.selectByExample(userExample);
        for(User u:users){
            System.out.println(u.getuName()+"123");
        }

    }

/*    @Test
    public void insert(){
        System.out.println("gogogogog");
        Tea tea=new Tea();
        tea.setId(new BigDecimal(6));
        tea.settName("赵八");
        int i = teaMapper.insert(tea);
        System.out.println(i);
        if(i>0){
            System.out.println("添加成功");
        }
    }

    @Test
    public void update(){
        System.out.println("gogogogog");
        Tea tea=new Tea();
        tea.setId(new BigDecimal(3));
        tea.settName("王三");
        int i = teaMapper.updateByPrimaryKey(tea);
        System.out.println(i);
        if(i>0){
            System.out.println("修改成功");
        }
    }

    @Test
    public void delete(){
        System.out.println("gogogogog");
        int i = teaMapper.deleteByPrimaryKey(new BigDecimal(6));
        System.out.println(i);
        if(i>0){
            System.out.println("删除成功");
        }
    }*/

    //获取表数据的总个数
    @Test
    public void getCountTea(){
        long l = userMapper.countByExample(new UserExample());
        System.out.println("TEA表的数据个数为："+l);
    }

    @Test
    public void cc() throws IOException {
        File file = new File("F:/WorkSpace/gccl/Project/前期资料/0123");
        boolean newFile = file.mkdirs();
        System.out.println(newFile);
    }

    @Test
    public void TestNumber(){
        String s="59";
        int i=0;
        try {
             i= Integer.parseInt(s);
        }catch (Exception e){
            System.out.println("数字转换异常！");
        }
        System.out.println(i);
    }
}
