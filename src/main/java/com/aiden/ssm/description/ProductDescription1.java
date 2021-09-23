package com.aiden.ssm.description;

/**
 * @author aiden
 * @create 2021-09-08 17:35
 */

/*
 * 一、项目介绍
 *     SSM-CRUD 是一个基于 mysql + spring + springMVC + mybatis + maven + github 实现的简单的增删改查项目。其中 CRUD 的 C 是
 *     创建 Create( 创建 )、Retrieve( 查询 )、Update( 更新 )、Delete( 删除 )。
 *
 * 二、功能点
 *     1、分页功能
 *     2、数据校验功能
 *     3、Ajax
 *     4、REST 风格的 URI : 使用 HTTP 协议请求方式的动词，来表示对资源的操作【 GET( 查询 )、POST( 新增 )、PUT( 修改 )、DELETE(
 *        删除 ) 】
 *
 * 三、技术点
 *     1、基础框架       -->   ssm( spring + springMVC + MyBatis )
 *     2、数据库         -->   MySQL
 *     3、前端框架       -->   Bootstrap 快速搭建简洁美观的界面
 *     4、项目的依赖管理  -->   Maven
 *     5、分页          -->    PageHelper
 *     6、逆向工程       -->   MyBatis-Generator
 *
 * 四、基础环境搭建
 *     1、创建一个 Maven 工程
 *
 *     2、引入项目依赖的 jar 包
 *        Spring
 *        SpringMVC
 *        Mybatis
 *        数据库连接池、驱动包
 *        其他( jstl、servlet-api、junit )
 *
 *     3、引入 Bootstrap 前端框架
 *
 *     4、编写 ssm 整合的关键配置文件
 *        web.xml、spring、springMVC、mybatis，使用 mybatis 的逆向工程生成对应的 bean 以及 mapper
 *
 *     5、测试 mapper
 *
 * 五、未使用 ajax + json 的查询
 *     1、访问 index.jsp 页面
 *     2、index.jsp 页面发送出查询员工的列表请求
 *     3、EmployeeController 来接受请求，查询员工数据
 *     4、来到 list.jsp 页面进行展示
 *     5、pageHelper 分页插件完成分页查询功能
 *
 * 六、使用 ajax + json 后的查询
 *     使用 ajax + json 是为了客户端无关性，这样就算是手机平板也能正常显示
 *
 *     1、index.jsp 页面直接发送 ajax 请求进行员工分页数据的查询
 *     2、服务器将查出的数据，以 json 字符串的形式返回给浏览器
 *     3、浏览器收到 js 字符串，可以使用 js 对 json 进行解析，使用 js 通过 dom 增删改改变页面。
 *     4、返回 json 。实现客户端的无关性。
 *
 * 七、新增-逻辑
 *     1、在 index.jsp 页面点击 “新增”
 *     2、弹出新增对话框
 *     3、去数据库查询部门列表，显示在对话框中
 *     4、用户输入数据，并进行校验
 *        jQuery 前端检验，ajax 用户名重复校验，重要数据( 后端校验( JSR303 )，唯一约束 )
 *     5、完成保存
 *
 * 八、修改-逻辑
 *     1、点击编辑
 *     2、弹出用户修改的模拟框( 显示用户信息 )
 *     3、点击更新，完成用户修改
 *
 * 九、删除-逻辑
 *     1、单个删除
 *     2、批量删除
 */
public class ProductDescription1 {
}
