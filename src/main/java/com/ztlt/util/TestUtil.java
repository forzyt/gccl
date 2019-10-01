package com.ztlt.util;

import com.ztlt.entity.ProjectType;

import java.util.List;

public class TestUtil {

    private Object ResultCode;
    private String ResultMsg;
    private List<?> ResultOBJ;

    public List<?> getResultOBJ() {
        return ResultOBJ;
    }

    public void setResultOBJ(List<?> resultOBJ) {
        ResultOBJ = resultOBJ;
    }

    public Object getResultCode() {
        return ResultCode;
    }

    public void setResultCode(Object resultCode) {
        ResultCode = resultCode;
    }

    public String getResultMsg() {
        return ResultMsg;
    }

    public void setResultMsg(String resultMsg) {
        ResultMsg = resultMsg;
    }
}
