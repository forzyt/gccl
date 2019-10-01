package com.ztlt.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class SubtaskExample implements Serializable {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table TB_SUBTASK
     *
     * @mbg.generated Tue Dec 25 13:13:28 CST 2018
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table TB_SUBTASK
     *
     * @mbg.generated Tue Dec 25 13:13:28 CST 2018
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table TB_SUBTASK
     *
     * @mbg.generated Tue Dec 25 13:13:28 CST 2018
     */
    protected List<Criteria> oredCriteria;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SUBTASK
     *
     * @mbg.generated Tue Dec 25 13:13:28 CST 2018
     */
    public SubtaskExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SUBTASK
     *
     * @mbg.generated Tue Dec 25 13:13:28 CST 2018
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SUBTASK
     *
     * @mbg.generated Tue Dec 25 13:13:28 CST 2018
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SUBTASK
     *
     * @mbg.generated Tue Dec 25 13:13:28 CST 2018
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SUBTASK
     *
     * @mbg.generated Tue Dec 25 13:13:28 CST 2018
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SUBTASK
     *
     * @mbg.generated Tue Dec 25 13:13:28 CST 2018
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SUBTASK
     *
     * @mbg.generated Tue Dec 25 13:13:28 CST 2018
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SUBTASK
     *
     * @mbg.generated Tue Dec 25 13:13:28 CST 2018
     */
    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SUBTASK
     *
     * @mbg.generated Tue Dec 25 13:13:28 CST 2018
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
     * This method corresponds to the database table TB_SUBTASK
     *
     * @mbg.generated Tue Dec 25 13:13:28 CST 2018
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SUBTASK
     *
     * @mbg.generated Tue Dec 25 13:13:28 CST 2018
     */
    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table TB_SUBTASK
     *
     * @mbg.generated Tue Dec 25 13:13:28 CST 2018
     */
    protected abstract static class GeneratedCriteria {
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

        public Criteria andSNameIsNull() {
            addCriterion("S_NAME is null");
            return (Criteria) this;
        }

        public Criteria andSNameIsNotNull() {
            addCriterion("S_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andSNameEqualTo(String value) {
            addCriterion("S_NAME =", value, "sName");
            return (Criteria) this;
        }

        public Criteria andSNameNotEqualTo(String value) {
            addCriterion("S_NAME <>", value, "sName");
            return (Criteria) this;
        }

        public Criteria andSNameGreaterThan(String value) {
            addCriterion("S_NAME >", value, "sName");
            return (Criteria) this;
        }

        public Criteria andSNameGreaterThanOrEqualTo(String value) {
            addCriterion("S_NAME >=", value, "sName");
            return (Criteria) this;
        }

        public Criteria andSNameLessThan(String value) {
            addCriterion("S_NAME <", value, "sName");
            return (Criteria) this;
        }

        public Criteria andSNameLessThanOrEqualTo(String value) {
            addCriterion("S_NAME <=", value, "sName");
            return (Criteria) this;
        }

        public Criteria andSNameLike(String value) {
            addCriterion("S_NAME like", value, "sName");
            return (Criteria) this;
        }

        public Criteria andSNameNotLike(String value) {
            addCriterion("S_NAME not like", value, "sName");
            return (Criteria) this;
        }

        public Criteria andSNameIn(List<String> values) {
            addCriterion("S_NAME in", values, "sName");
            return (Criteria) this;
        }

        public Criteria andSNameNotIn(List<String> values) {
            addCriterion("S_NAME not in", values, "sName");
            return (Criteria) this;
        }

        public Criteria andSNameBetween(String value1, String value2) {
            addCriterion("S_NAME between", value1, value2, "sName");
            return (Criteria) this;
        }

        public Criteria andSNameNotBetween(String value1, String value2) {
            addCriterion("S_NAME not between", value1, value2, "sName");
            return (Criteria) this;
        }

        public Criteria andSSummaryIsNull() {
            addCriterion("S_SUMMARY is null");
            return (Criteria) this;
        }

        public Criteria andSSummaryIsNotNull() {
            addCriterion("S_SUMMARY is not null");
            return (Criteria) this;
        }

        public Criteria andSSummaryEqualTo(String value) {
            addCriterion("S_SUMMARY =", value, "sSummary");
            return (Criteria) this;
        }

        public Criteria andSSummaryNotEqualTo(String value) {
            addCriterion("S_SUMMARY <>", value, "sSummary");
            return (Criteria) this;
        }

        public Criteria andSSummaryGreaterThan(String value) {
            addCriterion("S_SUMMARY >", value, "sSummary");
            return (Criteria) this;
        }

        public Criteria andSSummaryGreaterThanOrEqualTo(String value) {
            addCriterion("S_SUMMARY >=", value, "sSummary");
            return (Criteria) this;
        }

        public Criteria andSSummaryLessThan(String value) {
            addCriterion("S_SUMMARY <", value, "sSummary");
            return (Criteria) this;
        }

        public Criteria andSSummaryLessThanOrEqualTo(String value) {
            addCriterion("S_SUMMARY <=", value, "sSummary");
            return (Criteria) this;
        }

        public Criteria andSSummaryLike(String value) {
            addCriterion("S_SUMMARY like", value, "sSummary");
            return (Criteria) this;
        }

        public Criteria andSSummaryNotLike(String value) {
            addCriterion("S_SUMMARY not like", value, "sSummary");
            return (Criteria) this;
        }

        public Criteria andSSummaryIn(List<String> values) {
            addCriterion("S_SUMMARY in", values, "sSummary");
            return (Criteria) this;
        }

        public Criteria andSSummaryNotIn(List<String> values) {
            addCriterion("S_SUMMARY not in", values, "sSummary");
            return (Criteria) this;
        }

        public Criteria andSSummaryBetween(String value1, String value2) {
            addCriterion("S_SUMMARY between", value1, value2, "sSummary");
            return (Criteria) this;
        }

        public Criteria andSSummaryNotBetween(String value1, String value2) {
            addCriterion("S_SUMMARY not between", value1, value2, "sSummary");
            return (Criteria) this;
        }

        public Criteria andPIdIsNull() {
            addCriterion("P_ID is null");
            return (Criteria) this;
        }

        public Criteria andPIdIsNotNull() {
            addCriterion("P_ID is not null");
            return (Criteria) this;
        }

        public Criteria andPIdEqualTo(String value) {
            addCriterion("P_ID =", value, "pId");
            return (Criteria) this;
        }

        public Criteria andPIdNotEqualTo(String value) {
            addCriterion("P_ID <>", value, "pId");
            return (Criteria) this;
        }

        public Criteria andPIdGreaterThan(String value) {
            addCriterion("P_ID >", value, "pId");
            return (Criteria) this;
        }

        public Criteria andPIdGreaterThanOrEqualTo(String value) {
            addCriterion("P_ID >=", value, "pId");
            return (Criteria) this;
        }

        public Criteria andPIdLessThan(String value) {
            addCriterion("P_ID <", value, "pId");
            return (Criteria) this;
        }

        public Criteria andPIdLessThanOrEqualTo(String value) {
            addCriterion("P_ID <=", value, "pId");
            return (Criteria) this;
        }

        public Criteria andPIdLike(String value) {
            addCriterion("P_ID like", value, "pId");
            return (Criteria) this;
        }

        public Criteria andPIdNotLike(String value) {
            addCriterion("P_ID not like", value, "pId");
            return (Criteria) this;
        }

        public Criteria andPIdIn(List<String> values) {
            addCriterion("P_ID in", values, "pId");
            return (Criteria) this;
        }

        public Criteria andPIdNotIn(List<String> values) {
            addCriterion("P_ID not in", values, "pId");
            return (Criteria) this;
        }

        public Criteria andPIdBetween(String value1, String value2) {
            addCriterion("P_ID between", value1, value2, "pId");
            return (Criteria) this;
        }

        public Criteria andPIdNotBetween(String value1, String value2) {
            addCriterion("P_ID not between", value1, value2, "pId");
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

        public Criteria andUIdIsNull() {
            addCriterion("U_ID is null");
            return (Criteria) this;
        }

        public Criteria andUIdIsNotNull() {
            addCriterion("U_ID is not null");
            return (Criteria) this;
        }

        public Criteria andUIdEqualTo(BigDecimal value) {
            addCriterion("U_ID =", value, "uId");
            return (Criteria) this;
        }

        public Criteria andUIdNotEqualTo(BigDecimal value) {
            addCriterion("U_ID <>", value, "uId");
            return (Criteria) this;
        }

        public Criteria andUIdGreaterThan(BigDecimal value) {
            addCriterion("U_ID >", value, "uId");
            return (Criteria) this;
        }

        public Criteria andUIdGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("U_ID >=", value, "uId");
            return (Criteria) this;
        }

        public Criteria andUIdLessThan(BigDecimal value) {
            addCriterion("U_ID <", value, "uId");
            return (Criteria) this;
        }

        public Criteria andUIdLessThanOrEqualTo(BigDecimal value) {
            addCriterion("U_ID <=", value, "uId");
            return (Criteria) this;
        }

        public Criteria andUIdIn(List<BigDecimal> values) {
            addCriterion("U_ID in", values, "uId");
            return (Criteria) this;
        }

        public Criteria andUIdNotIn(List<BigDecimal> values) {
            addCriterion("U_ID not in", values, "uId");
            return (Criteria) this;
        }

        public Criteria andUIdBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("U_ID between", value1, value2, "uId");
            return (Criteria) this;
        }

        public Criteria andUIdNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("U_ID not between", value1, value2, "uId");
            return (Criteria) this;
        }

        public Criteria andSStateIsNull() {
            addCriterion("S_STATE is null");
            return (Criteria) this;
        }

        public Criteria andSStateIsNotNull() {
            addCriterion("S_STATE is not null");
            return (Criteria) this;
        }

        public Criteria andSStateEqualTo(BigDecimal value) {
            addCriterion("S_STATE =", value, "sState");
            return (Criteria) this;
        }

        public Criteria andSStateNotEqualTo(BigDecimal value) {
            addCriterion("S_STATE <>", value, "sState");
            return (Criteria) this;
        }

        public Criteria andSStateGreaterThan(BigDecimal value) {
            addCriterion("S_STATE >", value, "sState");
            return (Criteria) this;
        }

        public Criteria andSStateGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("S_STATE >=", value, "sState");
            return (Criteria) this;
        }

        public Criteria andSStateLessThan(BigDecimal value) {
            addCriterion("S_STATE <", value, "sState");
            return (Criteria) this;
        }

        public Criteria andSStateLessThanOrEqualTo(BigDecimal value) {
            addCriterion("S_STATE <=", value, "sState");
            return (Criteria) this;
        }

        public Criteria andSStateIn(List<BigDecimal> values) {
            addCriterion("S_STATE in", values, "sState");
            return (Criteria) this;
        }

        public Criteria andSStateNotIn(List<BigDecimal> values) {
            addCriterion("S_STATE not in", values, "sState");
            return (Criteria) this;
        }

        public Criteria andSStateBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("S_STATE between", value1, value2, "sState");
            return (Criteria) this;
        }

        public Criteria andSStateNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("S_STATE not between", value1, value2, "sState");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table TB_SUBTASK
     *
     * @mbg.generated do_not_delete_during_merge Tue Dec 25 13:13:28 CST 2018
     */
    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table TB_SUBTASK
     *
     * @mbg.generated Tue Dec 25 13:13:28 CST 2018
     */
    public static class Criterion {
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