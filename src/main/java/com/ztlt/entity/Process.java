package com.ztlt.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class Process implements Serializable {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TB_PROCESS_CHECK.ID
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    private BigDecimal id;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TB_PROCESS_CHECK.P_ID
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    private String pId;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TB_PROCESS_CHECK.R_ID
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    private BigDecimal rId;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TB_PROCESS_CHECK.FRACTION
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    private String fraction;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TB_PROCESS_CHECK.REMARK
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    private String remark;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TB_PROCESS_CHECK.T_ID
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    private BigDecimal tId;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TB_PROCESS_CHECK.U_ID
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    private BigDecimal uId;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TB_PROCESS_CHECK.C_TIME
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    private Date cTime;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TB_PROCESS_CHECK.PC_STATE
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    private BigDecimal pcState;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TB_PROCESS_CHECK.ID
     *
     * @return the value of TB_PROCESS_CHECK.ID
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    public BigDecimal getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TB_PROCESS_CHECK.ID
     *
     * @param id the value for TB_PROCESS_CHECK.ID
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    public void setId(BigDecimal id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TB_PROCESS_CHECK.P_ID
     *
     * @return the value of TB_PROCESS_CHECK.P_ID
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    public String getpId() {
        return pId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TB_PROCESS_CHECK.P_ID
     *
     * @param pId the value for TB_PROCESS_CHECK.P_ID
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    public void setpId(String pId) {
        this.pId = pId == null ? null : pId.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TB_PROCESS_CHECK.R_ID
     *
     * @return the value of TB_PROCESS_CHECK.R_ID
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    public BigDecimal getrId() {
        return rId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TB_PROCESS_CHECK.R_ID
     *
     * @param rId the value for TB_PROCESS_CHECK.R_ID
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    public void setrId(BigDecimal rId) {
        this.rId = rId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TB_PROCESS_CHECK.FRACTION
     *
     * @return the value of TB_PROCESS_CHECK.FRACTION
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    public String getFraction() {
        return fraction;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TB_PROCESS_CHECK.FRACTION
     *
     * @param fraction the value for TB_PROCESS_CHECK.FRACTION
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    public void setFraction(String fraction) {
        this.fraction = fraction == null ? null : fraction.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TB_PROCESS_CHECK.REMARK
     *
     * @return the value of TB_PROCESS_CHECK.REMARK
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    public String getRemark() {
        return remark;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TB_PROCESS_CHECK.REMARK
     *
     * @param remark the value for TB_PROCESS_CHECK.REMARK
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TB_PROCESS_CHECK.T_ID
     *
     * @return the value of TB_PROCESS_CHECK.T_ID
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    public BigDecimal gettId() {
        return tId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TB_PROCESS_CHECK.T_ID
     *
     * @param tId the value for TB_PROCESS_CHECK.T_ID
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    public void settId(BigDecimal tId) {
        this.tId = tId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TB_PROCESS_CHECK.U_ID
     *
     * @return the value of TB_PROCESS_CHECK.U_ID
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    public BigDecimal getuId() {
        return uId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TB_PROCESS_CHECK.U_ID
     *
     * @param uId the value for TB_PROCESS_CHECK.U_ID
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    public void setuId(BigDecimal uId) {
        this.uId = uId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TB_PROCESS_CHECK.C_TIME
     *
     * @return the value of TB_PROCESS_CHECK.C_TIME
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    public Date getcTime() {
        return cTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TB_PROCESS_CHECK.C_TIME
     *
     * @param cTime the value for TB_PROCESS_CHECK.C_TIME
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    public void setcTime(Date cTime) {
        this.cTime = cTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TB_PROCESS_CHECK.PC_STATE
     *
     * @return the value of TB_PROCESS_CHECK.PC_STATE
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    public BigDecimal getPcState() {
        return pcState;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TB_PROCESS_CHECK.PC_STATE
     *
     * @param pcState the value for TB_PROCESS_CHECK.PC_STATE
     *
     * @mbg.generated Tue Dec 25 09:43:24 CST 2018
     */
    public void setPcState(BigDecimal pcState) {
        this.pcState = pcState;
    }

    @Override
    public String toString() {
        return "Process{" +
                "id=" + id +
                ", pId='" + pId + '\'' +
                ", rId=" + rId +
                ", fraction='" + fraction + '\'' +
                ", remark='" + remark + '\'' +
                ", tId=" + tId +
                ", uId=" + uId +
                ", cTime=" + cTime +
                ", pcState=" + pcState +
                '}';
    }
}