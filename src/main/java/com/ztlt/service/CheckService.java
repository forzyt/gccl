package com.ztlt.service;

import com.ztlt.entity.Check;
import com.ztlt.entity.CheckExample;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

public interface CheckService {

    //实现分页查询
    List<Check> selectByExamplePage(CheckExample example);
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Wed Jan 30 10:08:30 CST 2019
     */
    long countByExample(CheckExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Wed Jan 30 10:08:30 CST 2019
     */
    int deleteByExample(CheckExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Wed Jan 30 10:08:30 CST 2019
     */
    int deleteByPrimaryKey(BigDecimal id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Wed Jan 30 10:08:30 CST 2019
     */
    int insert(Check record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Wed Jan 30 10:08:30 CST 2019
     */
    int insertSelective(Check record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Wed Jan 30 10:08:30 CST 2019
     */
    List<Check> selectByExample(CheckExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Wed Jan 30 10:08:30 CST 2019
     */
    Check selectByPrimaryKey(BigDecimal id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Wed Jan 30 10:08:30 CST 2019
     */
    int updateByExampleSelective(@Param("record") Check record, @Param("example") CheckExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Wed Jan 30 10:08:30 CST 2019
     */
    int updateByExample(@Param("record") Check record, @Param("example") CheckExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Wed Jan 30 10:08:30 CST 2019
     */
    int updateByPrimaryKeySelective(Check record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Wed Jan 30 10:08:30 CST 2019
     */
    int updateByPrimaryKey(Check record);
}
