package com.ztlt.service;

import com.ztlt.entity.Process;
import com.ztlt.entity.ProcessExample;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

public interface ProcessService {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    long countByExample(ProcessExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    int deleteByExample(ProcessExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    int deleteByPrimaryKey(BigDecimal id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    int insert(Process record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    int insertSelective(Process record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    List<Process> selectByExample(ProcessExample example);

    //质量分页查询
    List<Process> selectByExamplePage(ProcessExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    Process selectByPrimaryKey(BigDecimal id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    int updateByExampleSelective(@Param("record") Process record, @Param("example") ProcessExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    int updateByExample(@Param("record") Process record, @Param("example") ProcessExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    int updateByPrimaryKeySelective(Process record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_CHECK
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    int updateByPrimaryKey(Process record);
}
