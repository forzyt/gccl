package com.ztlt.mapper;

import com.ztlt.entity.Record;
import com.ztlt.entity.RecordExample;
import java.math.BigDecimal;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface RecordMapper {

    int selectLastId(RecordExample recordExample);
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_RECORD
     *
     * @mbg.generated Wed Dec 26 10:39:50 CST 2018
     */
    long countByExample(RecordExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_RECORD
     *
     * @mbg.generated Wed Dec 26 10:39:50 CST 2018
     */
    int deleteByExample(RecordExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_RECORD
     *
     * @mbg.generated Wed Dec 26 10:39:50 CST 2018
     */
    int deleteByPrimaryKey(BigDecimal id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_RECORD
     *
     * @mbg.generated Wed Dec 26 10:39:50 CST 2018
     */
    int insert(Record record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_RECORD
     *
     * @mbg.generated Wed Dec 26 10:39:50 CST 2018
     */
    int insertSelective(Record record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_RECORD
     *
     * @mbg.generated Wed Dec 26 10:39:50 CST 2018
     */
    List<Record> selectByExample(RecordExample example);

    List<Record> selectByExamplePage(RecordExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_RECORD
     *
     * @mbg.generated Wed Dec 26 10:39:50 CST 2018
     */
    Record selectByPrimaryKey(BigDecimal id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_RECORD
     *
     * @mbg.generated Wed Dec 26 10:39:50 CST 2018
     */
    int updateByExampleSelective(@Param("record") Record record, @Param("example") RecordExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_RECORD
     *
     * @mbg.generated Wed Dec 26 10:39:50 CST 2018
     */
    int updateByExample(@Param("record") Record record, @Param("example") RecordExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_RECORD
     *
     * @mbg.generated Wed Dec 26 10:39:50 CST 2018
     */
    int updateByPrimaryKeySelective(Record record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_PROCESS_RECORD
     *
     * @mbg.generated Wed Dec 26 10:39:50 CST 2018
     */
    int updateByPrimaryKey(Record record);
}