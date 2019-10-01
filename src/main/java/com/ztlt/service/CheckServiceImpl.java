package com.ztlt.service;

import com.ztlt.entity.Check;
import com.ztlt.entity.CheckExample;
import com.ztlt.mapper.CheckMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class CheckServiceImpl implements CheckService{

    @Autowired
    private CheckMapper checkMapper;

    @Override
    public List<Check> selectByExamplePage(CheckExample example) {
        List<Check> checks = checkMapper.selectByExamplePage(example);
        return checks;
    }

    @Override
    public long countByExample(CheckExample example) {
        long l = checkMapper.countByExample(example);
        return l;
    }

    @Override
    public int deleteByExample(CheckExample example) {
        return 0;
    }

    @Override
    public int deleteByPrimaryKey(BigDecimal id) {
        return 0;
    }

    @Override
    public int insert(Check record) {
        return 0;
    }

    @Override
    public int insertSelective(Check record) {
        return 0;
    }

    @Override
    public List<Check> selectByExample(CheckExample example) {
        return null;
    }

    @Override
    public Check selectByPrimaryKey(BigDecimal id) {
        Check check = checkMapper.selectByPrimaryKey(id);
        return check;
    }

    @Override
    public int updateByExampleSelective(Check record, CheckExample example) {
        return 0;
    }

    @Override
    public int updateByExample(Check record, CheckExample example) {
        return 0;
    }

    @Override
    public int updateByPrimaryKeySelective(Check record) {
        return 0;
    }

    @Override
    public int updateByPrimaryKey(Check record) {
        return 0;
    }
}
