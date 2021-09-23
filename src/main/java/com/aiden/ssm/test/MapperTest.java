package com.aiden.ssm.test;

/**
 * @author aiden
 * @create 2021-09-09 21:43
 */

import com.aiden.ssm.bean.Employee;
import com.aiden.ssm.dao.DepartmentMapper;
import com.aiden.ssm.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/*
 * 一、测试 DAO 层的工作
 * 推荐 Spring 的项目就可以使用 Spring 的单元测试，可以自动注入我们需要的组件
 *      1、导入 SpringTest 模块
 *      2、@ContextConfiguration 指定 Spring 配置文件的位置
 *      3、直接 @Autowired 要使用的组件即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring_config.xml")
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD() {
/*
        // 1、创建 SpringIOC 容器
        ApplicationContext ioc = new ClassPathXmlApplicationContext("spring_config.xml");

        // 2、从容器中获取 mapper
        Department department = ioc.getBean(Department.class);
*/

        System.out.println(departmentMapper);

        // 1、插入几个部门
/*
        departmentMapper.insertSelective(new Department(null, "开发部"));
        departmentMapper.insertSelective(new Department(null, "技术部"));
*/

        // 2、生成员工数据，测试员工插入
        employeeMapper.insertSelective(new Employee(null, "Aiden", "M", "aidenskr1@gmail.com", 1));

        // 3、批量插入多个员工，使用可批量执行的 SqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, uid, "M", uid + "@gmail.com", 1));
        }
        System.out.println("批量插入完成");
    }
}
