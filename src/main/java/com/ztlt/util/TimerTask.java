package com.ztlt.util;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class TimerTask {

    @Scheduled(cron = "0/2 * * * * ?")//每隔2秒隔行一次
    public void test2()
    {
        System.out.println("job2 开始执行");
    }
}
