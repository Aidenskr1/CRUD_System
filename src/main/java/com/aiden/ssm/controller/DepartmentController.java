package com.aiden.ssm.controller;

import com.aiden.ssm.bean.Department;
import com.aiden.ssm.bean.Message;
import com.aiden.ssm.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author aiden
 * @create 2021-09-19 17:21
 */
@Controller
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Message getAllDepartment() {
        List<Department> departmentList = departmentService.getAllDepartment();
        return Message.success().add("departments", departmentList);
    }
}
