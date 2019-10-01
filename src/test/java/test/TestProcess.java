package test;

import com.ztlt.entity.*;
import com.ztlt.entity.Process;
import com.ztlt.mapper.ProcessMapper;
import com.ztlt.mapper.ProjectMapper;
import com.ztlt.mapper.RecordMapper;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.math.BigDecimal;
import java.util.List;

public class TestProcess {
    private ClassPathXmlApplicationContext appCtx;

    RecordMapper recordMapper;
    @Before
    public void init() {
        appCtx = new ClassPathXmlApplicationContext(
                "classpath:/spring/applicationContext.xml", "classpath:/mybatis/mybatis-config.xml");
        recordMapper = appCtx.getBean( "recordMapper",RecordMapper.class);
    }

    @Test
    public void getCountTea(){
        List<Record> records = recordMapper.selectByExample(new RecordExample());
        for(Record record:records){
            System.out.println(record.toString());
        }
    }

    @Test
    public void TestWan(){
        int i = recordMapper.selectLastId(new RecordExample());
        System.out.println(i);
    }
}
