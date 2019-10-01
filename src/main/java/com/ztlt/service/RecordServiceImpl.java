package com.ztlt.service;

import com.ztlt.entity.Record;
import com.ztlt.entity.RecordExample;
import com.ztlt.mapper.RecordMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class RecordServiceImpl implements RecordService{

    @Autowired
    private RecordMapper recordMapper;

    @Override
    public long countByExample(RecordExample example) {
        long l = recordMapper.countByExample(example);
        return l;
    }

    @Override
    public int deleteByExample(RecordExample example) {
        return 0;
    }

    @Override
    public int deleteByPrimaryKey(BigDecimal id) {
        return 0;
    }

    @Override
    public int insert(Record record) {
        return 0;
    }

    @Override
    public int insertSelective(Record record) {
        int i = recordMapper.insertSelective(record);
        return i;
    }

    @Override
    public List<Record> selectByExample(RecordExample example) {
        List<Record> records = recordMapper.selectByExample(example);
        return records;
    }

    @Override
    public List<Record> selectByExamplePage(RecordExample example) {
        List<Record> records = recordMapper.selectByExamplePage(example);
        return records;
    }

    @Override
    public Record selectByPrimaryKey(BigDecimal id) {
        Record record = recordMapper.selectByPrimaryKey(id);
        return record;
    }

    @Override
    public int updateByExampleSelective(Record record, RecordExample example) {
        int i = recordMapper.updateByExampleSelective(record, example);
        return i;
    }

    @Override
    public int updateByExample(Record record, RecordExample example) {
        return 0;
    }

    @Override
    public int updateByPrimaryKeySelective(Record record) {
        return 0;
    }

    @Override
    public int updateByPrimaryKey(Record record) {
        return 0;
    }
}
