package com.ztlt.service;

import com.ztlt.entity.ProjectType;
import com.ztlt.entity.ProjectTypeExample;
import com.ztlt.mapper.ProjectTypeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class ProjectTypeServiceImpl implements ProjectTypeService{

    @Autowired
    private ProjectTypeMapper projectTypeMapper;

    @Override
    public long countByExample(ProjectTypeExample example) {
        return 0;
    }

    @Override
    public int deleteByExample(ProjectTypeExample example) {
        return 0;
    }

    @Override
    public int deleteByPrimaryKey(BigDecimal id) {
        return 0;
    }

    @Override
    public int insert(ProjectType record) {
        return 0;
    }

    @Override
    public int insertSelective(ProjectType record) {
        return 0;
    }

    @Override
    public List<ProjectType> selectByExample(ProjectTypeExample example) {
        List<ProjectType> projectTypes = projectTypeMapper.selectByExample(example);
        return projectTypes;
    }

    @Override
    public ProjectType selectByPrimaryKey(BigDecimal id) {
        ProjectType projectType = projectTypeMapper.selectByPrimaryKey(id);
        return projectType;
    }

    @Override
    public int updateByExampleSelective(ProjectType record, ProjectTypeExample example) {
        return 0;
    }

    @Override
    public int updateByExample(ProjectType record, ProjectTypeExample example) {
        return 0;
    }

    @Override
    public int updateByPrimaryKeySelective(ProjectType record) {
        return 0;
    }

    @Override
    public int updateByPrimaryKey(ProjectType record) {
        return 0;
    }
}
