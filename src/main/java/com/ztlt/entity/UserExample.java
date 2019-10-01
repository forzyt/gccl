package com.ztlt.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UserExample implements Serializable {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table TB_USER
     *
     * @mbg.generated Fri Dec 21 10:10:22 CST 2018
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table TB_USER
     *
     * @mbg.generated Fri Dec 21 10:10:22 CST 2018
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table TB_USER
     *
     * @mbg.generated Fri Dec 21 10:10:22 CST 2018
     */
    protected List<Criteria> oredCriteria;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_USER
     *
     * @mbg.generated Fri Dec 21 10:10:22 CST 2018
     */
    public UserExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_USER
     *
     * @mbg.generated Fri Dec 21 10:10:22 CST 2018
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_USER
     *
     * @mbg.generated Fri Dec 21 10:10:22 CST 2018
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_USER
     *
     * @mbg.generated Fri Dec 21 10:10:22 CST 2018
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_USER
     *
     * @mbg.generated Fri Dec 21 10:10:22 CST 2018
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_USER
     *
     * @mbg.generated Fri Dec 21 10:10:22 CST 2018
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_USER
     *
     * @mbg.generated Fri Dec 21 10:10:22 CST 2018
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_USER
     *
     * @mbg.generated Fri Dec 21 10:10:22 CST 2018
     */
    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_USER
     *
     * @mbg.generated Fri Dec 21 10:10:22 CST 2018
     */
    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_USER
     *
     * @mbg.generated Fri Dec 21 10:10:22 CST 2018
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_USER
     *
     * @mbg.generated Fri Dec 21 10:10:22 CST 2018
     */
    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table TB_USER
     *
     * @mbg.generated Fri Dec 21 10:10:22 CST 2018
     */
    protected abstract static class GeneratedCriteria implements Serializable{
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andIdIsNull() {
            addCriterion("ID is null");
            return (Criteria) this;
        }

        public Criteria andIdIsNotNull() {
            addCriterion("ID is not null");
            return (Criteria) this;
        }

        public Criteria andIdEqualTo(BigDecimal value) {
            addCriterion("ID =", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotEqualTo(BigDecimal value) {
            addCriterion("ID <>", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThan(BigDecimal value) {
            addCriterion("ID >", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("ID >=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThan(BigDecimal value) {
            addCriterion("ID <", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThanOrEqualTo(BigDecimal value) {
            addCriterion("ID <=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdIn(List<BigDecimal> values) {
            addCriterion("ID in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotIn(List<BigDecimal> values) {
            addCriterion("ID not in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("ID between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("ID not between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andUNameIsNull() {
            addCriterion("U_NAME is null");
            return (Criteria) this;
        }

        public Criteria andUNameIsNotNull() {
            addCriterion("U_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andUNameEqualTo(String value) {
            addCriterion("U_NAME =", value, "uName");
            return (Criteria) this;
        }

        public Criteria andUNameNotEqualTo(String value) {
            addCriterion("U_NAME <>", value, "uName");
            return (Criteria) this;
        }

        public Criteria andUNameGreaterThan(String value) {
            addCriterion("U_NAME >", value, "uName");
            return (Criteria) this;
        }

        public Criteria andUNameGreaterThanOrEqualTo(String value) {
            addCriterion("U_NAME >=", value, "uName");
            return (Criteria) this;
        }

        public Criteria andUNameLessThan(String value) {
            addCriterion("U_NAME <", value, "uName");
            return (Criteria) this;
        }

        public Criteria andUNameLessThanOrEqualTo(String value) {
            addCriterion("U_NAME <=", value, "uName");
            return (Criteria) this;
        }

        public Criteria andUNameLike(String value) {
            addCriterion("U_NAME like", value, "uName");
            return (Criteria) this;
        }

        public Criteria andUNameNotLike(String value) {
            addCriterion("U_NAME not like", value, "uName");
            return (Criteria) this;
        }

        public Criteria andUNameIn(List<String> values) {
            addCriterion("U_NAME in", values, "uName");
            return (Criteria) this;
        }

        public Criteria andUNameNotIn(List<String> values) {
            addCriterion("U_NAME not in", values, "uName");
            return (Criteria) this;
        }

        public Criteria andUNameBetween(String value1, String value2) {
            addCriterion("U_NAME between", value1, value2, "uName");
            return (Criteria) this;
        }

        public Criteria andUNameNotBetween(String value1, String value2) {
            addCriterion("U_NAME not between", value1, value2, "uName");
            return (Criteria) this;
        }

        public Criteria andPwdIsNull() {
            addCriterion("PWD is null");
            return (Criteria) this;
        }

        public Criteria andPwdIsNotNull() {
            addCriterion("PWD is not null");
            return (Criteria) this;
        }

        public Criteria andPwdEqualTo(String value) {
            addCriterion("PWD =", value, "pwd");
            return (Criteria) this;
        }

        public Criteria andPwdNotEqualTo(String value) {
            addCriterion("PWD <>", value, "pwd");
            return (Criteria) this;
        }

        public Criteria andPwdGreaterThan(String value) {
            addCriterion("PWD >", value, "pwd");
            return (Criteria) this;
        }

        public Criteria andPwdGreaterThanOrEqualTo(String value) {
            addCriterion("PWD >=", value, "pwd");
            return (Criteria) this;
        }

        public Criteria andPwdLessThan(String value) {
            addCriterion("PWD <", value, "pwd");
            return (Criteria) this;
        }

        public Criteria andPwdLessThanOrEqualTo(String value) {
            addCriterion("PWD <=", value, "pwd");
            return (Criteria) this;
        }

        public Criteria andPwdLike(String value) {
            addCriterion("PWD like", value, "pwd");
            return (Criteria) this;
        }

        public Criteria andPwdNotLike(String value) {
            addCriterion("PWD not like", value, "pwd");
            return (Criteria) this;
        }

        public Criteria andPwdIn(List<String> values) {
            addCriterion("PWD in", values, "pwd");
            return (Criteria) this;
        }

        public Criteria andPwdNotIn(List<String> values) {
            addCriterion("PWD not in", values, "pwd");
            return (Criteria) this;
        }

        public Criteria andPwdBetween(String value1, String value2) {
            addCriterion("PWD between", value1, value2, "pwd");
            return (Criteria) this;
        }

        public Criteria andPwdNotBetween(String value1, String value2) {
            addCriterion("PWD not between", value1, value2, "pwd");
            return (Criteria) this;
        }

        public Criteria andIssubpackageIsNull() {
            addCriterion("ISSUBPACKAGE is null");
            return (Criteria) this;
        }

        public Criteria andIssubpackageIsNotNull() {
            addCriterion("ISSUBPACKAGE is not null");
            return (Criteria) this;
        }

        public Criteria andIssubpackageEqualTo(BigDecimal value) {
            addCriterion("ISSUBPACKAGE =", value, "issubpackage");
            return (Criteria) this;
        }

        public Criteria andIssubpackageNotEqualTo(BigDecimal value) {
            addCriterion("ISSUBPACKAGE <>", value, "issubpackage");
            return (Criteria) this;
        }

        public Criteria andIssubpackageGreaterThan(BigDecimal value) {
            addCriterion("ISSUBPACKAGE >", value, "issubpackage");
            return (Criteria) this;
        }

        public Criteria andIssubpackageGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("ISSUBPACKAGE >=", value, "issubpackage");
            return (Criteria) this;
        }

        public Criteria andIssubpackageLessThan(BigDecimal value) {
            addCriterion("ISSUBPACKAGE <", value, "issubpackage");
            return (Criteria) this;
        }

        public Criteria andIssubpackageLessThanOrEqualTo(BigDecimal value) {
            addCriterion("ISSUBPACKAGE <=", value, "issubpackage");
            return (Criteria) this;
        }

        public Criteria andIssubpackageIn(List<BigDecimal> values) {
            addCriterion("ISSUBPACKAGE in", values, "issubpackage");
            return (Criteria) this;
        }

        public Criteria andIssubpackageNotIn(List<BigDecimal> values) {
            addCriterion("ISSUBPACKAGE not in", values, "issubpackage");
            return (Criteria) this;
        }

        public Criteria andIssubpackageBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("ISSUBPACKAGE between", value1, value2, "issubpackage");
            return (Criteria) this;
        }

        public Criteria andIssubpackageNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("ISSUBPACKAGE not between", value1, value2, "issubpackage");
            return (Criteria) this;
        }

        public Criteria andUStateIsNull() {
            addCriterion("U_STATE is null");
            return (Criteria) this;
        }

        public Criteria andUStateIsNotNull() {
            addCriterion("U_STATE is not null");
            return (Criteria) this;
        }

        public Criteria andUStateEqualTo(BigDecimal value) {
            addCriterion("U_STATE =", value, "uState");
            return (Criteria) this;
        }

        public Criteria andUStateNotEqualTo(BigDecimal value) {
            addCriterion("U_STATE <>", value, "uState");
            return (Criteria) this;
        }

        public Criteria andUStateGreaterThan(BigDecimal value) {
            addCriterion("U_STATE >", value, "uState");
            return (Criteria) this;
        }

        public Criteria andUStateGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("U_STATE >=", value, "uState");
            return (Criteria) this;
        }

        public Criteria andUStateLessThan(BigDecimal value) {
            addCriterion("U_STATE <", value, "uState");
            return (Criteria) this;
        }

        public Criteria andUStateLessThanOrEqualTo(BigDecimal value) {
            addCriterion("U_STATE <=", value, "uState");
            return (Criteria) this;
        }

        public Criteria andUStateIn(List<BigDecimal> values) {
            addCriterion("U_STATE in", values, "uState");
            return (Criteria) this;
        }

        public Criteria andUStateNotIn(List<BigDecimal> values) {
            addCriterion("U_STATE not in", values, "uState");
            return (Criteria) this;
        }

        public Criteria andUStateBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("U_STATE between", value1, value2, "uState");
            return (Criteria) this;
        }

        public Criteria andUStateNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("U_STATE not between", value1, value2, "uState");
            return (Criteria) this;
        }

        public Criteria andUTypeIsNull() {
            addCriterion("U_TYPE is null");
            return (Criteria) this;
        }

        public Criteria andUTypeIsNotNull() {
            addCriterion("U_TYPE is not null");
            return (Criteria) this;
        }

        public Criteria andUTypeEqualTo(BigDecimal value) {
            addCriterion("U_TYPE =", value, "uType");
            return (Criteria) this;
        }

        public Criteria andUTypeNotEqualTo(BigDecimal value) {
            addCriterion("U_TYPE <>", value, "uType");
            return (Criteria) this;
        }

        public Criteria andUTypeGreaterThan(BigDecimal value) {
            addCriterion("U_TYPE >", value, "uType");
            return (Criteria) this;
        }

        public Criteria andUTypeGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("U_TYPE >=", value, "uType");
            return (Criteria) this;
        }

        public Criteria andUTypeLessThan(BigDecimal value) {
            addCriterion("U_TYPE <", value, "uType");
            return (Criteria) this;
        }

        public Criteria andUTypeLessThanOrEqualTo(BigDecimal value) {
            addCriterion("U_TYPE <=", value, "uType");
            return (Criteria) this;
        }

        public Criteria andUTypeIn(List<BigDecimal> values) {
            addCriterion("U_TYPE in", values, "uType");
            return (Criteria) this;
        }

        public Criteria andUTypeNotIn(List<BigDecimal> values) {
            addCriterion("U_TYPE not in", values, "uType");
            return (Criteria) this;
        }

        public Criteria andUTypeBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("U_TYPE between", value1, value2, "uType");
            return (Criteria) this;
        }

        public Criteria andUTypeNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("U_TYPE not between", value1, value2, "uType");
            return (Criteria) this;
        }

        public Criteria andUTimeIsNull() {
            addCriterion("U_TIME is null");
            return (Criteria) this;
        }

        public Criteria andUTimeIsNotNull() {
            addCriterion("U_TIME is not null");
            return (Criteria) this;
        }

        public Criteria andUTimeEqualTo(Date value) {
            addCriterion("U_TIME =", value, "uTime");
            return (Criteria) this;
        }

        public Criteria andUTimeNotEqualTo(Date value) {
            addCriterion("U_TIME <>", value, "uTime");
            return (Criteria) this;
        }

        public Criteria andUTimeGreaterThan(Date value) {
            addCriterion("U_TIME >", value, "uTime");
            return (Criteria) this;
        }

        public Criteria andUTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("U_TIME >=", value, "uTime");
            return (Criteria) this;
        }

        public Criteria andUTimeLessThan(Date value) {
            addCriterion("U_TIME <", value, "uTime");
            return (Criteria) this;
        }

        public Criteria andUTimeLessThanOrEqualTo(Date value) {
            addCriterion("U_TIME <=", value, "uTime");
            return (Criteria) this;
        }

        public Criteria andUTimeIn(List<Date> values) {
            addCriterion("U_TIME in", values, "uTime");
            return (Criteria) this;
        }

        public Criteria andUTimeNotIn(List<Date> values) {
            addCriterion("U_TIME not in", values, "uTime");
            return (Criteria) this;
        }

        public Criteria andUTimeBetween(Date value1, Date value2) {
            addCriterion("U_TIME between", value1, value2, "uTime");
            return (Criteria) this;
        }

        public Criteria andUTimeNotBetween(Date value1, Date value2) {
            addCriterion("U_TIME not between", value1, value2, "uTime");
            return (Criteria) this;
        }

        public Criteria andURNameIsNull() {
            addCriterion("U_R_NAME is null");
            return (Criteria) this;
        }

        public Criteria andURNameIsNotNull() {
            addCriterion("U_R_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andURNameEqualTo(String value) {
            addCriterion("U_R_NAME =", value, "uRName");
            return (Criteria) this;
        }

        public Criteria andURNameNotEqualTo(String value) {
            addCriterion("U_R_NAME <>", value, "uRName");
            return (Criteria) this;
        }

        public Criteria andURNameGreaterThan(String value) {
            addCriterion("U_R_NAME >", value, "uRName");
            return (Criteria) this;
        }

        public Criteria andURNameGreaterThanOrEqualTo(String value) {
            addCriterion("U_R_NAME >=", value, "uRName");
            return (Criteria) this;
        }

        public Criteria andURNameLessThan(String value) {
            addCriterion("U_R_NAME <", value, "uRName");
            return (Criteria) this;
        }

        public Criteria andURNameLessThanOrEqualTo(String value) {
            addCriterion("U_R_NAME <=", value, "uRName");
            return (Criteria) this;
        }

        public Criteria andURNameLike(String value) {
            addCriterion("U_R_NAME like", value, "uRName");
            return (Criteria) this;
        }

        public Criteria andURNameNotLike(String value) {
            addCriterion("U_R_NAME not like", value, "uRName");
            return (Criteria) this;
        }

        public Criteria andURNameIn(List<String> values) {
            addCriterion("U_R_NAME in", values, "uRName");
            return (Criteria) this;
        }

        public Criteria andURNameNotIn(List<String> values) {
            addCriterion("U_R_NAME not in", values, "uRName");
            return (Criteria) this;
        }

        public Criteria andURNameBetween(String value1, String value2) {
            addCriterion("U_R_NAME between", value1, value2, "uRName");
            return (Criteria) this;
        }

        public Criteria andURNameNotBetween(String value1, String value2) {
            addCriterion("U_R_NAME not between", value1, value2, "uRName");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table TB_USER
     *
     * @mbg.generated do_not_delete_during_merge Fri Dec 21 10:10:22 CST 2018
     */
    public static class Criteria extends GeneratedCriteria implements Serializable{

        protected Criteria() {
            super();
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table TB_USER
     *
     * @mbg.generated Fri Dec 21 10:10:22 CST 2018
     */
    public static class Criterion implements Serializable{
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}