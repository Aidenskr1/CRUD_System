<%@page pageEncoding="UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表</title>
    <%
        request.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- 引入 Bootstrap -->
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css"/>
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.6.0.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="${APP_PATH}/static/bootstrap/js/bootstrap.bundle.js"></script>
</head>
<body>
<div class="container">
    <!-- 这个 div 盒子用来显示标题，row 表示这个 div 盒子占一行，一行有 12 列，col-md-12 表示当前 div 盒子占满 12 列 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD 系统</h1>
        </div>
    </div>
    <!-- 这个 div 盒子用来显示按钮，offset-md-9 表示当前 div 盒子向左偏移 9 列 -->
    <div class="row">
        <div class="col-md-4 offset-md-9">
            <button class="btn btn-outline-primary">新增</button>
            <button class="btn btn-outline-danger">删除</button>
        </div>
    </div>

    <!-- 这个 div 盒子用来显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>Employee_Name</th>
                    <th>Gender</th>
                    <th>Email</th>
                    <th>Department_Name</th>
                    <th>Actions</th>
                </tr>
                <!-- items 指明了要循环的集合，var 是我们定义的变量 -->
                <c:forEach items="${pageInfo.list}" var="employee">
                    <tr>
                        <td>${employee.empId}</td>
                        <td>${employee.empName}</td>
                        <td>${employee.gender == "F"?"男":"女"}</td>
                        <td>${employee.email}</td>
                        <td>${employee.department.deptName }</td>
                        <td>
                            <button type="button" class="btn btn-primary">
                                编辑
                            </button>
                            <button type="button" class="btn btn-danger">
                                删除
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>

    <!-- 这个 div 盒子用来显示分页信息 -->
    <div class="row">
        <div class="col-md-6">
            当前是 <span class="text text-primary">${pageInfo.pageNum}</span> 页，
            总共有 <span class="text text-primary">${pageInfo.pages}</span> 页，
            总共有 <span class="text text-primary">${pageInfo.total}</span> 条记录
        </div>
        <!-- 下面是分页条，可以切换不同的页数 -->
        <div class="col-md-6">
            <!-- nav-tabs / nav-item / nav-link 是一套的，分别用于 ul / li / a 标签 -->
            <ul class="nav nav-tabs">
                <!-- 首页 -->
                <li class="nav-item">
                    <a href="${APP_PATH}/emps?pageNum=1" class="nav-link active">首页</a>
                </li>

                <!-- 判断是否有上一页，有才显示这个列表项，没有就不显示 -->
                <c:if test="${pageInfo.hasPreviousPage}">
                    <li class="nav-item">
                        <a href="${APP_PATH}/emps?pageNum=${pageInfo.pageNum-1}" class="nav-link active">
                            <span>&laquo;</span>        <!-- &laquo; 是 << 的转义字符 -->
                        </a>
                    </li>
                </c:if>

                <!-- 循环输出要显示的页码 -->
                <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
                    <!-- 先判断一下显示的页码是不是当前页，如果是的话就显示以下列表项 -->
                    <c:if test="${page_num == pageInfo.pageNum}">
                        <li class="nav-item">
                            <a href="#" class="nav-link bg-primary text-light">${page_num}</a>
                        </li>
                    </c:if>

                    <!-- 如果不是当前页，就显示以下列表项 -->
                    <c:if test="${page_num != pageInfo.pageNum}">
                        <li class="nav-item">
                            <a href="${APP_PATH}/emps?pageNum=${page_num}" class="nav-link active">${page_num}</a>
                        </li>
                    </c:if>
                </c:forEach>

                <!-- 判断是否有下一页，有的话就显示以下列表项 -->
                <c:if test="${pageInfo.hasNextPage}">
                    <li class="nav-item">
                        <a href="${APP_PATH}/emps?pageNum=${pageInfo.pageNum+1}" class="nav-link active">
                            <span>&raquo;</span>        <!-- &raquo; 是 >> 的转义字符 -->
                        </a>
                    </li>
                </c:if>

                <!-- 末页 -->
                <li class="nav-item">
                    <a href="${APP_PATH}/emps?pageNum=${pageInfo.pages}" class="nav-link active">末页</a>
                </li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>
