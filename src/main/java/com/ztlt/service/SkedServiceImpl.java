package com.ztlt.service;

import com.ztlt.entity.Sked;
import com.ztlt.entity.SkedExample;
import com.ztlt.mapper.SkedMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class SkedServiceImpl implements SkedService {

    @Autowired
    private SkedMapper skedMapper;

    @Override
    public long countByExample(SkedExample example) {
        long l = skedMapper.countByExample(example);
        return l;
    }

    @Override
    public int deleteByExample(SkedExample example) {
        return 0;
    }

    @Override
    public int deleteByPrimaryKey(BigDecimal id) {
        return 0;
    }

    @Override
    public int insert(Sked record) {
        return 0;
    }

    @Override
    public int insertSelective(Sked record) {
        int i = skedMapper.insertSelective(record);
        return i;
    }

    @Override
    public List<Sked> selectByExample(SkedExample example) {
        List<Sked> skeds = skedMapper.selectByExample(example);
        return skeds;
    }

    @Override
    public Sked selectByPrimaryKey(BigDecimal id) {
        Sked sked = skedMapper.selectByPrimaryKey(id);
        return sked;
    }

    @Override
    public int updateByExampleSelective(Sked record, SkedExample example) {
        return 0;
    }

    @Override
    public int updateByExample(Sked record, SkedExample example) {
        return 0;
    }

    @Override
    public int updateByPrimaryKeySelective(Sked record) {
        int i = skedMapper.updateByPrimaryKeySelective(record);
        return i;
    }

    @Override
    public int updateByPrimaryKey(Sked record) {
        return 0;
    }
}
