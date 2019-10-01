package com.ztlt.service;

import com.ztlt.entity.Drecord;
import com.ztlt.entity.DrecordExample;
import com.ztlt.mapper.DrecordMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class DrecordServiceImpl implements DrecordService{

    @Autowired
    private DrecordMapper drecordMapper;

    @Override
    public List<Drecord> selectByExamplePage(DrecordExample example) {
        List<Drecord> drecords = drecordMapper.selectByExamplePage(example);
        return drecords;
    }

    @Override
    public long countByExample(DrecordExample example) {
        long l = drecordMapper.countByExample(example);
        return l;
    }

    @Override
    public int deleteByExample(DrecordExample example) {
        return 0;
    }

    @Override
    public int deleteByPrimaryKey(BigDecimal id) {
        return 0;
    }

    @Override
    public int insert(Drecord record) {
        return 0;
    }

    @Override
    public int insertSelective(Drecord record) {
        int i = drecordMapper.insertSelective(record);
        return i;
    }

    @Override
    public List<Drecord> selectByExample(DrecordExample example) {
        List<Drecord> drecords = drecordMapper.selectByExample(example);
        return drecords;
    }

    @Override
    public Drecord selectByPrimaryKey(BigDecimal id) {
        return null;
    }

    @Override
    public int updateByExampleSelective(Drecord record, DrecordExample example) {
        return 0;
    }

    @Override
    public int updateByExample(Drecord record, DrecordExample example) {
        return 0;
    }

    @Override
    public int updateByPrimaryKeySelective(Drecord record) {
        return 0;
    }

    @Override
    public int updateByPrimaryKey(Drecord record) {
        return 0;
    }
}
