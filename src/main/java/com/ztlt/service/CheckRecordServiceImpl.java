package com.ztlt.service;

import com.ztlt.entity.CheckRecord;
import com.ztlt.entity.CheckRecordExample;
import com.ztlt.mapper.CheckRecordMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class CheckRecordServiceImpl implements CheckRecordService {
    @Autowired
    private CheckRecordMapper checkRecordMapper;

    @Override
    public long countByExample(CheckRecordExample example) {
        return 0;
    }

    @Override
    public int deleteByExample(CheckRecordExample example) {
        return 0;
    }

    @Override
    public int deleteByPrimaryKey(BigDecimal id) {
        return 0;
    }

    @Override
    public int insert(CheckRecord record) {
        return 0;
    }

    @Override
    public int insertSelective(CheckRecord record) {
        return 0;
    }

    @Override
    public List<CheckRecord> selectByExample(CheckRecordExample example) {
        List<CheckRecord> checkRecords = checkRecordMapper.selectByExample(example);
        return checkRecords;
    }

    @Override
    public CheckRecord selectByPrimaryKey(BigDecimal id) {
        return null;
    }

    @Override
    public int updateByExampleSelective(CheckRecord record, CheckRecordExample example) {
        return 0;
    }

    @Override
    public int updateByExample(CheckRecord record, CheckRecordExample example) {
        return 0;
    }

    @Override
    public int updateByPrimaryKeySelective(CheckRecord record) {
        return 0;
    }

    @Override
    public int updateByPrimaryKey(CheckRecord record) {
        return 0;
    }
}
