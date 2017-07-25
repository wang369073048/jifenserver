package org.trc.resource;

import com.alibaba.fastjson.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * author: hzwzhen
 * JDK-version:  JDK1.8
 * comments:
 * since Date： 2017/7/10
 */
public class Test {

    public static void main(String[] args) {
        List<Student> list = new ArrayList<Student>();
        Student student = new Student();
        student.setAge("12");

        Student student2 = new Student();
        student2.setAge("13");
        list.add(student);
        list.add(student2);
        System.out.println(JSONObject.toJSONString(list));
    }
}
