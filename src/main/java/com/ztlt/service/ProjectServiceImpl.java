package com.ztlt.service;

import com.ztlt.entity.Project;
import com.ztlt.entity.ProjectExample;
import com.ztlt.mapper.ProjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProjectServiceImpl implements ProjectService {

    @Autowired
    private ProjectMapper projectMapper;

    @Override
    public List<Project> selectByExamplePage(ProjectExample example) {
        List<Project> projects = projectMapper.selectByExamplePage(example);
        return projects;
    }

    @Override
    public List<Project> selectByExamplePage2(ProjectExample example) {
        List<Project> projects = projectMapper.selectByExamplePage2(example);
        return projects;
    }

    @Override
    public long countByExample(ProjectExample example) {
        long l = projectMapper.countByExample(example);
        return l;
    }

    @Override
    public int deleteByExample(ProjectExample example) {
        return 0;
    }

    @Override
    public int deleteByPrimaryKey(String pNumber) {
        return 0;
    }

    @Override
    public int insert(Project record) {
        return 0;
    }

    @Override
    public int insertSelective(Project record) {
        int i = projectMapper.insertSelective(record);
        return i;
    }

    @Override
    public List<Project> selectByExample(ProjectExample example) {
        List<Project> projects = projectMapper.selectByExample(example);
        return projects;
    }

    @Override
    public Project selectByPrimaryKey(String pNumber) {
        Project project = projectMapper.selectByPrimaryKey(pNumber);
        return project;
    }

    @Override
    public int updateByExampleSelective(Project record, ProjectExample example) {
        return 0;
    }

    @Override
    public int updateByExample(Project record, ProjectExample example) {
        return 0;
    }

    @Override
    public int updateByPrimaryKeySelective(Project record) {
        int i = projectMapper.updateByPrimaryKeySelective(record);
        return i;
    }

    @Override
    public int updateByPrimaryKey(Project record) {
        int i = projectMapper.updateByPrimaryKey(record);
        return i;
    }
}
