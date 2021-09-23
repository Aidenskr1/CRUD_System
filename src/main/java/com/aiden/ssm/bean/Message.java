package com.aiden.ssm.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * @author aiden
 * @create 2021-09-16 20:27
 */
public class Message {
    private int code;           // 状态码，我们规定 100 是成功，200 是失败
    private String message;     // 提示信息

    // 用户要返回给浏览器的数据
    private Map<String, Object> extend = new HashMap<String, Object>();

    // 处理成功时调用
    public static Message success() {
        Message result = new Message();
        result.setCode(100);
        result.setMessage("处理成功！");
        return result;
    }

    // 处理失败时调用
    public static Message fail() {
        Message result = new Message();
        result.setCode(200);
        result.setMessage("处理失败！");
        return result;
    }

    // 我们希望返回成功或失败的消息时，顺便返回一些其他数据
    public Message add(String key,Object value){
        // 调用当前对象的 getExtend() 获取到 Map 集合，往里面放入我们想返回的数据
        this.getExtend().put(key,value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
