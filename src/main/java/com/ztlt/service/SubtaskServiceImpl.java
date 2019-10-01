package com.ztlt.service;

import com.ztlt.entity.Subtask;
import com.ztlt.entity.SubtaskExample;
import com.ztlt.mapper.SubtaskMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class SubtaskServiceImpl implements SubtaskService{

    @Autowired
    private SubtaskMapper subtaskMapper;

    @Override
    public long countByExample(SubtaskExample example) {
        long l = subtaskMapper.countByExample(example);
        return l;
    }

    @Override
    public int deleteByExample(SubtaskExample example) {
        return 0;
    }

    @Override
    public int deleteByPrimaryKey(BigDecimal id) {
        return 0;
    }

    @Override
    public int insert(Subtask record) {
        return 0;
    }

    @Override
    public int insertSelective(Subtask record) {
        int i = subtaskMapper.insertSelective(record);
        return i;
    }

    @Override
    public List<Subtask> selectByExample(SubtaskExample example) {
        List<Subtask> subtasks = subtaskMapper.selectByExample(example);
        return subtasks;
    }

    @Override
    public Subtask selectByPrimaryKey(BigDecimal id) {
        Subtask subtask = subtaskMapper.selectByPrimaryKey(id);
        return subtask;
    }

    @Override
    public int updateByExampleSelective(Subtask record, SubtaskExample example) {
        return 0;
    }

    @Override
    public int updateByExample(Subtask record, SubtaskExample example) {
        return 0;
    }

    @Override
    public int updateByPrimaryKeySelective(Subtask record) {
        int i = subtaskMapper.updateByPrimaryKeySelective(record);
        return i;
    }

    @Override
    public int updateByPrimaryKey(Subtask record) {
        return 0;
    }
}
