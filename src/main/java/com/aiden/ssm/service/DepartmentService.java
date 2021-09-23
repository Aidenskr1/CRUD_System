package com.aiden.ssm.service;

import com.aiden.ssm.bean.Department;
import com.aiden.ssm.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author aiden
 * @create 2021-09-19 19:38
 */
@Service
public class DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;

    public List<Department> getAllDepartment() {
        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;
    }
}
