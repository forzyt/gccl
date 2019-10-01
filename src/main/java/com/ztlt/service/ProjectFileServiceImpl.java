package com.ztlt.service;

import com.ztlt.entity.ProjectFile;
import com.ztlt.entity.ProjectFileExample;
import com.ztlt.mapper.ProjectFileMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class ProjectFileServiceImpl implements ProjectFileService{

    @Autowired
    private ProjectFileMapper projectFileMapper;

    @Override
    public long countByExample(ProjectFileExample example) {
        long l = projectFileMapper.countByExample(example);
        return l;
    }

    @Override
    public int deleteByExample(ProjectFileExample example) {
        return 0;
    }

    @Override
    public int deleteByPrimaryKey(BigDecimal id) {
        return 0;
    }

    @Override
    public int insert(ProjectFile record) {
        return 0;
    }

    @Override
    public int insertSelective(ProjectFile record) {
        int i = projectFileMapper.insertSelective(record);
        return i;
    }

    @Override
    public List<ProjectFile> selectByExample(ProjectFileExample example) {
        List<ProjectFile> projectFiles = projectFileMapper.selectByExample(example);
        return projectFiles;
    }

    @Override
    public ProjectFile selectByPrimaryKey(BigDecimal id) {
        ProjectFile projectFile = projectFileMapper.selectByPrimaryKey(id);
        return projectFile;
    }

    @Override
    public int updateByExampleSelective(ProjectFile record, ProjectFileExample example) {
        return 0;
    }

    @Override
    public int updateByExample(ProjectFile record, ProjectFileExample example) {
        return 0;
    }

    @Override
    public int updateByPrimaryKeySelective(ProjectFile record) {
        int i = projectFileMapper.updateByPrimaryKeySelective(record);
        return i;
    }

    @Override
    public int updateByPrimaryKey(ProjectFile record) {
        return 0;
    }
}
