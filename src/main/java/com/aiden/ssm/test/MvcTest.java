package com.aiden.ssm.test;

import com.aiden.ssm.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @author aiden
 * @create 2021-09-15 21:25
 */
//@ExtendWith(SpringExtension.class)
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring_config.xml", "classpath:springMVC_config.xml"})
// @WebAppConfiguration 表示测试环境使用，用来表示测试环境使用的 ApplicationContext 将是 WebApplicationContext
@WebAppConfiguration
public class MvcTest {
    /**
     * WebApplicationContext 用来传入 SpringMVC 的 IOC 容器，一般我们都是只能传入 IOC 容器里的东西嘛，如果要传入整个 IOC 容器就
     * 应该使用 WebApplicationContext ，使用该类记得加上 @WebAppConfiguration 注解
     */
    @Autowired
    WebApplicationContext context;

    // MockMvc 用来虚拟 mvc 请求，获取到处理结果
    MockMvc mockMvc;

    // @BeforeEach
    @Before
    public void initMockMvc() {
        // MockMvcBuilders.webAppContextSetup(context).build() 要用来从该 context 上下文获取相应的控制器并且得到相应的 MockMvc
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        /**
         * MockMvcRequestBuilders.get("/emps") 是用来构造一个 "/emps" 请求，param() 即所带的参数，所以完整的请求是 "/emps?pageNum=1"
         * mockMvc.perform() 用来执行一个请求，andReturn() 用来返回一个 MvcResult 结果集
         */
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNum", "1")).andReturn();

        // 请求成功以后，请求域中会有 pageInfo ，我们可以去除 pageInfo 进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码" + pi.getPageNum());
        System.out.println("总页码" + pi.getPages());
        System.out.println("总记录数" + pi.getTotal());
        System.out.println("在页面需要连续显示的页码");
        int[] nums = pi.getNavigatepageNums();
        for (int i : nums) {
            System.out.println("" + i);
        }

        // 获取员工数据
        List<Employee> list = pi.getList();
        for (Employee employee : list) {
            System.out.println("ID : " + employee.getEmpId() + "--> Name : " + employee.getEmpName());
        }
    }
}
