package com.ztlt.service;

import com.ztlt.entity.Process;
import com.ztlt.entity.ProcessExample;
import com.ztlt.mapper.ProcessMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class ProcessServiceImpl implements ProcessService{

    @Autowired
    private ProcessMapper processMapper;

    @Override
    public long countByExample(ProcessExample example) {
        long l = processMapper.countByExample(example);
        return l;
    }

    @Override
    public int deleteByExample(ProcessExample example) {
        return 0;
    }

    @Override
    public int deleteByPrimaryKey(BigDecimal id) {
        return 0;
    }

    @Override
    public int insert(Process record) {
        return 0;
    }

    @Override
    public int insertSelective(Process record) {
        return 0;
    }

    @Override
    public List<Process> selectByExample(ProcessExample example) {
        List<Process> processes = processMapper.selectByExample(example);
        return processes;
    }

    @Override
    public List<Process> selectByExamplePage(ProcessExample example) {
        List<Process> processes = processMapper.selectByExamplePage(example);
        return processes;
    }

    @Override
    public Process selectByPrimaryKey(BigDecimal id) {
        Process process = processMapper.selectByPrimaryKey(id);
        return process;
    }

    @Override
    public int updateByExampleSelective(Process record, ProcessExample example) {
        return 0;
    }

    @Override
    public int updateByExample(Process record, ProcessExample example) {
        return 0;
    }

    @Override
    public int updateByPrimaryKeySelective(Process record) {
        return 0;
    }

    @Override
    public int updateByPrimaryKey(Process record) {
        return 0;
    }
}
