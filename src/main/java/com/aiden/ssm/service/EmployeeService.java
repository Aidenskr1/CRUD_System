package com.aiden.ssm.service;

import com.aiden.ssm.bean.Employee;
import com.aiden.ssm.bean.EmployeeExample;
import com.aiden.ssm.bean.EmployeeExample.Criteria;
import com.aiden.ssm.bean.Message;
import com.aiden.ssm.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author aiden
 * @create 2021-09-15 20:10
 */
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 获取所有的员工信息
     *
     * @return
     */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 添加员工
     *
     * @param employee
     * @return
     */
    public Message addEmployee(Employee employee) {
        employeeMapper.insertSelective(employee);
        return Message.success();
    }

    /**
     * 获取用户名
     *
     * @param empName
     * @return
     */
    public boolean getUserName(String empName) {
        EmployeeExample example = new EmployeeExample();
        Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    /**
     * 获取员工信息
     *
     * @param id
     * @return
     */
    public Employee getEmployeeInfo(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    /**
     * 更新员工信息
     *
     * @param employee
     */
    public void updateEmpInfo(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 删除单个员工
     *
     * @param id
     */
    public void deleteEmpInfo(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 员工批量删除
     *
     * @param del_ids
     */
    public void deleteBatch(List<Integer> del_ids) {
        EmployeeExample example = new EmployeeExample();
        Criteria criteria = example.createCriteria();
        // delete from xxx where emp_id in (1,2,3)
        criteria.andEmpIdIn(del_ids);
        employeeMapper.deleteByExample(example);
    }
}
