package com.absensi.backend.config;

public class StaticFunction {
  public static ResultFormat format(Object obj, int status){
    ResultFormat res = new ResultFormat();
    res.setData(obj);
    res.setStatusCode(status);
    return res;
  }
}
