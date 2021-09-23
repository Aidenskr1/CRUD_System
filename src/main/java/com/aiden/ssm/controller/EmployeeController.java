package com.aiden.ssm.controller;

import com.aiden.ssm.bean.Employee;
import com.aiden.ssm.bean.Message;
import com.aiden.ssm.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author aiden
 * @create 2021-09-15 20:06
 * @description 用于处理员工的 CRUD 请求
 */
@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    // 下面这个方法用于没有使用 ajax + json 的查询
    // @RequestMapping("/emps")
    public String selectAllEmp(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum, Model model) {
        PageHelper.startPage(pageNum, 6);    // 这里我们是传入了当前页码 pageNum 以及每页的大小是 6
        // 但这还不是一个分页查询，因此我们需要使用 PageHelper 分页插件
        List<Employee> employeeList = employeeService.getAll(); // 现在紧跟在 startPage() 方法后面的这个查询就是一个分页查询
        PageInfo pageInfo = new PageInfo(employeeList, 5);  // 我们使用 PageInfo 来包装查询后的结果，同时传入要连续显示的页数
        model.addAttribute("pageInfo", pageInfo);
        return "list";
    }

    // ---------------------- 分隔线 ----------------------

    /**
     * 这个方法用来查询所有员工信息
     */
    @RequestMapping("/emps")
    @ResponseBody   // @ResponseBody 的作用是将 java 对象转为 json 格式的数据，就是说我们的方法运行之后，对象会被转换成 json 再返回
    public Message selectAllEmployee(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        PageHelper.startPage(pageNum, 5);
        List<Employee> employeeList = employeeService.getAll();
        PageInfo pageInfo = new PageInfo(employeeList, 5);
        /**
         * 这里我们返回了 “处理成功！” 的消息，但是我们希望在返回的时候，把查询到的数据也一并返回，所以我们又增加了一个 add() 方法，
         * 将查询到的结果一并返回，这种思想可以学习一下
         */
        return Message.success().add("pageInfo", pageInfo);
    }

    /**
     * 这个方法用来新增员工，同时具有后端校验功能，进行后端校验是非常有必要的，因为前端校验可能会因为禁用 javaScript 而导致失效，
     * 因此对于重要的数据，应当由以下校验构成 :
     * jQuery 前端检验，ajax 用户名重复校验，重要数据( 后端校验( JSR303 )，唯一约束 )
     */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    // @Valid 注解用于验证，配合 BindingResult result 可以直接提供参数 employee 的验证结果。使用该注解记得给 javaBean 中相对应的属性加上验证注解
    public Message saveEmployee(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名：" + fieldError.getField());
                System.out.println("错误信息：" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Message.fail().add("errorFields", map);
        } else {
            Message message = employeeService.addEmployee(employee);
            return message;
        }
    }

    /**
     * 这个方法用来查询用户名
     */
    @RequestMapping(value = "/checkuser", method = RequestMethod.POST)
    @ResponseBody
    public Message checkUser(@RequestParam("empName") String empName) {
        //先判断用户名是否是合法的表达式，正则表达式和前端相比没有斜杠，且原本斜杠的地方要写成双斜杠
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        // matches() 方法就相当于前端的 test() 方法用于匹配正则表达式
        if (!empName.matches(regx)) {
            return Message.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
        }

        //数据库用户名重复校验
        boolean checkResult = employeeService.getUserName(empName);
        return checkResult == true ? Message.success() : Message.fail();
    }

    /**
     * 这个方法用来查询用户信息以便显示在模拟框中
     */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Message getEmployeeInfo(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmployeeInfo(id);
        return Message.success().add("employeeInfo", employee);
    }

    /**
     * 这个方法用于更新员工信息
     * <p>
     * 期间遇到的问题：
     * 1、如果直接发送 ajax=PUT 请求，所封装的数据结果如下：
     * Employee{empId=3, empName='null', gender='null', email='null', dId=null, department=null}
     * <p>
     * 问题在于请求体中有数据，但是 Employee 对象封装不上，这就导致 SQL 语句变成 update tbl_emp where emp_id = 3； 这样的错误
     * <p>
     * 其原因是 :
     * Tomcat 会进行如下操作 :
     * (1) 将请求体中的数据，封装成一个 map
     * (2) request.getParameter("empName") 就会从这个 map 中取值。
     * (3) SpringMVC 封装 POJO 对象时，会把 POJO 中的每个属性的值通过 request.getParamter(); 来取。
     * <p>
     * ajax 可以直接发送 PUT 请求，但是当 ajax 发送 PUT 请求时，就会发生以下血案 :
     * 发送 PUT 请求，请求体中的数据无法通过 request.getParameter() 拿到
     * Tomcat 一看是 PUT 就不会封装请求体中的数据为 map，只有 POST 形式的请求才封装请求体为 map
     * <p>
     * 解决的办法如下：
     * 我们要能支持直接发送 PUT 之类的请求还要封装请求体中的数据
     * (1) 在 web.xml 中配置 FormContentFilter 过滤器
     * (2) 它的作用是能将请求体中的数据解析包装成一个 map
     * (3) request 被重新包装，request.getParameter() 被重写，就会从自己封装的 map 中取数据
     */
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)  // 这里写 empId 而不是 id 是为了能封装上 id 值
    @ResponseBody
    public Message updateEmployeeInfo(Employee employee, HttpServletRequest request) {
        System.out.println(request.getParameter("gender"));
        System.out.println("所要打印的对象是: " + employee);
        employeeService.updateEmpInfo(employee);
        return Message.success();
    }

    /**
     * 这个方法用于删除单个员工或批量删除
     * 批量删除时，请求参数是 1-2-3
     * 单个删除时，请求参数时 1
     */
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Message deleteEmployee(@PathVariable("ids") String ids) {
        // 所以包含 - 的就是批量删除
        if (ids.contains("-")) {
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for (String str : str_ids) {
                del_ids.add(Integer.parseInt(str));
            }
            employeeService.deleteBatch(del_ids);
        } else {            // 否则就是单个删除
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmpInfo(id);
        }
        return Message.success();
    }
}
