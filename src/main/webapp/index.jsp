<%@page pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <title>首页</title>
    <%
        request.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    <!-- 引入 Bootstrap -->
    <link href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="${APP_PATH}/static/js/jquery-3.6.0.js" type="text/javascript"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="${APP_PATH}/static/bootstrap/js/bootstrap.bundle.js"></script>

</head>
<body>
<div class="container">
    <!-- 这个只是来占个位置，让页面好看一点儿而已 -->
    <div class="row">
        <div class="col-md-12">
            <h1 class="text text-white">&nbsp;</h1>
        </div>
    </div>

    <!-- 这个 div 盒子用于标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD 系统</h1>
        </div>
    </div>

    <!-- 这个 div 盒子用于按钮 -->
    <div class="row">
        <div class="col-md-4 offset-md-9">
            <button class="btn btn-primary" id="add_btn">
                <i class="bi bi-clipboard"></i> 新增
            </button>
            <button class="btn btn-danger" id="delete_more_btn">
                <i class="bi bi-trash"></i> 删除
            </button>
        </div>
    </div>

    <!-- 这个 div 盒子用于显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="table_employee">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>Employee_Name</th>
                    <th>Gender</th>
                    <th>Email</th>
                    <th>Department_Name</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <!-- 这个 div 盒子用来显示分页信息 -->
    <div class="row">
        <div class="col-md-6" id="page_info"></div>
        <div class="col-md-6" id="page_btn"></div>
    </div>
</div>

<!-- 这是新增按钮的模拟框，data-bs-backdrop="static" 和 data-bs-keyboard="false" 是设置当前模拟框必须点击按钮或 × 标志才退出 -->
<div class="modal fade" id="addModal" tabindex="-1">
    <!-- modal-dialog-centered 是设置模拟框垂直居中 -->
    <div class="modal-dialog modal-dialog-centered model-lg">
        <div class="modal-content">
            <!-- 这是模拟框头部 -->
            <div class="modal-header">
                <h5 class="modal-title">添加员工</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <!-- 这是模拟框主体 -->
            <div class="modal-body">
                <form>
                    <div class="row mb-3">
                        <label class="col-sm-4 col-form-label">empName</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" name="empName" placeholder="empName"
                                   id="empName_input"/>
                            <span></span>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-sm-4 col-form-label">Email</label>
                        <div class="col-sm-8">
                            <input type="email" class="form-control" name="email" placeholder="email" id="email_input"/>
                            <span></span>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-sm-4 col-form-label">gender</label>
                        <div class="col-sm-4">
                            <input type="radio" name="gender" value="M" id="boy" checked="checked"/>boy&nbsp;&nbsp;&nbsp;
                            <input type="radio" name="gender" value="F" id="girl"/>girl
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-sm-4 col-form-label">departmentName</label>
                        <div class="col-sm-4">
                            <select class="form-select" name="dId"></select>
                        </div>
                    </div>
                </form>
            </div>
            <!-- 这是模拟框底部 -->
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="saveInfo_btn">确定</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<!-- 这是编辑按钮的模拟框，data-bs-backdrop="static" 和 data-bs-keyboard="false" 是设置当前模拟框必须点击按钮或 × 标志才退出 -->
<div class="modal fade" id="updateModal" tabindex="-1">
    <!-- modal-dialog-centered 是设置模拟框垂直居中 -->
    <div class="modal-dialog modal-dialog-centered model-lg">
        <div class="modal-content">
            <!-- 这是模拟框头部 -->
            <div class="modal-header">
                <h5 class="modal-title">修改员工</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <!-- 这是模拟框主体 -->
            <div class="modal-body">
                <form>
                    <div class="row mb-3">
                        <label class="col-sm-4 col-form-label">empName</label>
                        <div class="col-sm-8">
                            <input class="form-control-plaintext" readonly name="empName" id="autoEmpId"></input>
                            <span></span>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-sm-4 col-form-label">Email</label>
                        <div class="col-sm-8">
                            <input type="email" class="form-control" name="email" placeholder="email"
                                   id="update_email_input"/>
                            <span></span>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-sm-4 col-form-label">gender</label>
                        <div class="col-sm-4">
                            <input type="radio" name="gender" value="M" id="updateBoy" checked="checked"/>boy&nbsp;&nbsp;&nbsp;
                            <input type="radio" name="gender" value="F" id="updateGirl"/>girl
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-sm-4 col-form-label">departmentName</label>
                        <div class="col-sm-4">
                            <select class="form-select" name="dId"></select>
                        </div>
                    </div>
                </form>
            </div>
            <!-- 这是模拟框底部 -->
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="updateInfo_btn">确定</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    // 我觉得 result.extend.pageInfo 重复写还挺长的，所以定义了一个变量来替代它，结果是可行的，不过为了加强记忆，暂时不用
    // var jsonPageInfo = result.extend.pageInfo;

    var pageSum;        // 这个用来指向总的记录数，方便跳转到最后一页
    var currentPage;    // 这个用来指向当前页面
    var addModal;       // 这个用来指向 "新增" 模拟框
    var updateModal;    // 这个用来指向 "编辑" 模拟框

    // 页面加载完成以后，应当直接去发送 ajax 请求，查询到分页数据
    $(function () {
        // 执行 to_page 函数，并传入 1 表示去首页
        to_page(1);
    });

    // 这个函数用来发出请求，以便切换页面
    function to_page(pageNum) {
        $.ajax({                            // 这是 jQuery 调用 ajax 的方法
            url: "${APP_PATH}/emps",        // 请求地址
            data: "pageNum=" + pageNum,     // 要发送给服务器的数据
            type: "GET",                    // 请求参数
            success: function (result) {    // 成功时调用该函数
                // console.log(result);
                // 1、解析并显示员工数据
                build_employee_table(result);   // result 就是服务器返回给浏览器的 json 数据

                // 2、解析并显示分页信息
                build_employee_pageInfo(result);

                // 3、解析显示分页条数据
                build_employee_pageBtn(result);
            }
        });
    }

    // 这个函数用于显示分页内容
    function build_employee_table(result) {
        // 清空 table 表格中 tbody 标签里的内容
        $("#table_employee tbody").empty();

        // 从返回的 json 数据中可以看出，我们是先找到 key 为 extend 再找到 pageInfo 再找到 list 才拿到所有的员工数据
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {   // $.each() 是遍历，emps 是要遍历的数据，index 是索引，item 是变量
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);    // append() 是追加，它会将 () 里的数据添加到对应的标签中
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == "M" ? "boy" : "girl");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);

            // eidtBtn 是编辑按钮，addClass() 用于给前面的标签添加样式，添加 edit_btn 是为了方便后期绑定点击事件
            var editBtn = $("<button type='button'></button>").addClass("btn btn-outline-primary edit_btn")
                .append($("<i></i>").addClass("bi bi-pencil-square"))
                .append("  编辑");
            editBtn.attr("edit-id", item.empId);

            var deleteBtn = $("<button type='button'></button>").addClass("btn btn-outline-danger delete_btn")
                .append($("<i></i>").addClass("bi bi-trash"))
                .append("  删除");
            deleteBtn.attr("delete_id", item.empId);

            var btnTd = $("<td></td>").append(editBtn).append("&nbsp;&nbsp;&nbsp;").append(deleteBtn);

            $("<tr></tr>")
                .append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                // appendTo() 指定我们当前元素要添加到哪里去，这里是添加到 id 为 table_employee 元素下的 tbody 标签
                .appendTo("#table_employee tbody");
        });
    }

    // 这个函数用于显示分页信息
    function build_employee_pageInfo(result) {
        // 清空分页条信息内容
        $("#page_info").empty();
        var pageNum = $("<span></span>").addClass("text text-primary").append(result.extend.pageInfo.pageNum);
        var pages = $("<span></span>").addClass("text text-primary").append(result.extend.pageInfo.pages);
        var total = $("<span></span>").addClass("text text-primary").append(result.extend.pageInfo.total);
        $("#page_info")
            .append("当前是第 ")
            .append(pageNum)
            .append(" 页，总共有 ")
            .append(pages)
            .append(" 页，总共有 ")
            .append(total)
            .append(" 条记录");

        // 将记录数赋值给 pageSum
        pageSum = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    // 这个函数用于切换分页
    function build_employee_pageBtn(result) {
        // 清空分页条内容
        $("#page_btn").empty();

        // 先声明一个无序列表
        var pageUl = $("<ul></ul>").addClass("nav nav-tabs");

        // 这是首页
        var FirstPageLi = $("<li></li>").addClass("nav-item").append("<a></a>").addClass("nav-link active").append("首页").attr("href", "#");

        // 这是上一页
        var PrePageLi = $("<li></li>").addClass("nav-item").append("<a></a>").addClass("nav-link active").append("&laquo;").attr("href", "#");

        // 判断当前页面是否有上一页，如果没有就表明在第一页，所以 FirstPageLi 和 PrePageLi 都应该不能点击，也就是 disabled
        if (result.extend.pageInfo.hasPreviousPage == false) {
            FirstPageLi.addClass("disabled");
            PrePageLi.addClass("disabled");
        } else {      // 如果有上一页，那就设置好当我们点击时会发出请求跳转到哪一页
            PrePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);    // 当前页 - 1 就是上一页
            });
            FirstPageLi.click(function () {
                to_page(1);                                     // 1 就是第一页
            });
        }

        // 这是下一页
        var NextPageLi = $("<li></li>").addClass("nav-item").append("<a></a>").addClass("nav-link active").append("&raquo;").attr("href", "#");

        // 这是末页
        var LastPageLi = $("<li></li>").addClass("nav-item").append("<a></a>").addClass("nav-link active").append("末页").attr("href", "#");

        // 判断当前页面是否有下一页，如果没有就表明在最后一页，所以 NextPageLi 和 LastPageLi 都应该不能点击，也就是 disabled
        if (result.extend.pageInfo.hasNextPage == false) {
            NextPageLi.addClass("disabled");
            LastPageLi.addClass("disabled");
        } else {      // 如果有下一页，那就设置好当我们点击时会发出请求跳转到哪一页
            NextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);    // 当前页 + 1 就是下一页
            });
            LastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);          // 总页数就是最后一页
            });
        }

        // 将 首页 和 上一页 这两个列表项添加到无序列表中
        pageUl.append(FirstPageLi).append(PrePageLi);

        // navigatepageNums 存储了我们每次要连续显示的页码，里面的元素都是整数
        var pageArr = result.extend.pageInfo.navigatepageNums;

        // 循环遍历，增加相应的列表项
        $.each(pageArr, function (index, item) {
            var numLi = $("<li></li>").addClass("nav-item").append("<a></a>").addClass("nav-link active").append(item);

            // 判断要连续显示的页码数是否时当前页码，如果是，就改变样式
            if (item == result.extend.pageInfo.pageNum) {
                numLi.addClass("nav-link bg-primary text-light")
            }

            // 点击相应页码发出请求跳转
            numLi.click(function () {
                to_page(item);
            })

            // 将每一个列表项添加到无序列表中
            pageUl.append(numLi);
        });

        // 将 下一页 和 末页 这两个列表项添加到无序列表中
        pageUl.append(NextPageLi).append(LastPageLi);

        // 将整个无序列表添加到相应的 div 盒子中
        $("#page_btn").append(pageUl);
    }

    // 这个函数用于点击 “新增按钮” 后弹出新增对话框
    $("#add_btn").click(function () {
        // 清除表单数据( 表单完整重置( 表单的数据，表单的样式 ) )
        resetForm("#addModal form");

        // 在展示模拟框之前要先查询到部门信息
        getDepartments("#addModal select");

        // 创建一个模拟框，设置为静态背景
        addModal = new bootstrap.Modal($("#addModal"), {
            backdrop: 'static',
            keyboard: false
        });
        // 展示模拟框
        addModal.show();
    });

    // 这个函数用于查询所有的部门，以便显示在模拟框的下拉列表中
    function getDepartments(element) {
        $(element).empty();
        // 发出 ajax 请求，去查询部门信息
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                // console(result);
                $.each(result.extend.departments, function () {
                    $("<option></option>")
                        .append(this.deptName)
                        .attr("value", this.deptId)
                        .appendTo(element);
                });
            }
        });
    };

    /**
     * 先来规定一下 REST 风格的请求
     * /emp/{id}    请求方式是 GET 的话就是查询员工
     * /emp         请求方式是 POST 的话就是新增员工
     * /emp/{id}    请求方式是 DELETE 的话就是删除员工
     * /emp/{id}    请求方式是 PUT 的话就是修改员工
     */

    // 这个函数用于新增员工
    $("#saveInfo_btn").click(function () {
        // 调用数据校验函数
        if (!dataCheck()) {
            return false;
        }

        // 判断之前的 ajax 用户名校验是否成功
        if ($(this).attr("ajax-value") == "error") {
            return false;
        }

        // alert($("#addModal form").serialize());

        // 发送 ajax 请求，保存员工
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            // $().serialize() 方法通过序列化表单值，创建 URL 编码文本字符串。就是说我们在表单上填的那些值都会被直接序列化成请求参数
            data: $("#addModal form").serialize(),
            success: function (result) {
                // alert($("#addModal form").serialize());
                // alert(result);
                if (result.code == 100) {
                    // 1、关闭模拟框
                    addModal.hide();

                    // 2、跳转到最后一页，显示新添加的数据
                    to_page(pageSum);
                } else {
                    // 显示失败信息
                    console.log(result);
                }
            }
        })
    });

    // 这个函数用于进行数据校验，只有检验成功才允许插入
    function dataCheck() {
        // .val() 方法适用于获取当前元素的值
        var empName = $("#empName_input").val();
        // 下面正则表达式的意思是以 6 到 16 位小写字母 a-z 或大写字母 A-Z 或数字 0-9 开始,或以 2 到 5 位汉字开始
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        // 调用正则表达式的 test() 方法看看元素值是否符合正则表达式
        if (!regName.test(empName)) {
            // alert("用户名可以是 2-5 位中文或者 6-16 大小写英文和数字的组合");
            showTips("#empName_input", "error", "用户名可以是 2-5 位中文或者 6-16 大小写英文和数字的组合")
            return false;
        } else {
            showTips("#empName_input", "success", "校验通过")
        }

        // 下面是邮箱的校验
        var email = $("#email_input").val();
        // \. 是 . 的转义字符, + 表示当前值可能会重复出现
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            // alert("邮箱格式不正确");
            showTips("#email_input", "error", "邮箱格式不正确")
            return false;
        } else {
            showTips("#email_input", "success", "校验通过")
        }
        return true;
    }

    // 这个函数用来进行校验结果的提示
    function showTips(elements, status, message) {
        // next("span") 方法会指向当前元素的下一个 span 元素, removeClass() 就是移除样式, text() 就是设置提示内容
        $(elements).next("span").removeClass("text-success text-danger").text("");
        if ("success" == status) {
            $(elements).next("span").addClass("text-success").text(message);
        } else if ("error" == status) {
            $(elements).next("span").addClass("text-danger").text(message);
        }
    }

    // 这个函数用于清除表单样式及内容
    function resetForm(elements) {
        $(elements)[0].reset();
        $(elements).find("*").removeClass("text-success text-danger");
        $(elements).find("span").text("");
    }

    // 检验用户名是否可用, change() 是当用户名改变时发送请求检查是否有重复的名字
    $("#empName_input").change(function () {
        var empName = this.value();
        $.ajax({
            url: "${APP_PATH}/checkuser",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    showTips("#empName_input", "success", "用户名可用");
                    $("#saveInfo_btn").attr("ajax-value", "success");
                } else {
                    showTips("#empName_input", "error", "用户名不可用");
                    $("#saveInfo_btn").attr("ajax-value", "error");
                }
            }
        });
    });

    /**
     * 给编辑按钮绑定点击事件，应当注意的是，我们的按钮是在查完数据库之后才追加上去的，所以不能再用 click 绑定点击事件了，绑定不了，
     * 使用 on 来绑定，click 即是点击事件，.edit_btn 是 “ 编辑 ” 按钮的类标识，function 是点击完之后要执行的方法
     */
    $(document).on("click", ".edit_btn", function () {
        // 1、查出部门信息，并显示部门列表
        getDepartments("#updateModal select");

        // 2、查出员工信息，显示员工信息
        getEmployeeInfo($(this).attr("edit-id"));

        // 3、把员工的 id 传递给模拟框的更新按钮
        $("#updateInfo_btn").attr("edit-id", $(this).attr("edit-id"));

        // 创建一个模拟框，设置为静态背景
        updateModal = new bootstrap.Modal($("#updateModal"), {
            backdrop: 'static',
            keyboard: false
        });
        // 展示模拟框
        updateModal.show();
    });

    // 这个函数用来获取员工信息，以便用于编辑模拟框
    function getEmployeeInfo(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                // console.log(result);
                var employeeData = result.extend.employeeInfo;
                $("#autoEmpId").val(employeeData.empName);
                $("#update_email_input").val(employeeData.email);
                $("#updateModal input[name=gender]").val([employeeData.gender]);
                $("#updateModal select").val([employeeData.dId]);
            }
        });
    }

    // 点击确定更新，更新员工信息
    $("#updateInfo_btn").click(function () {
        // 先获取邮箱的值进行验证是否合法
        var email = $("#update_email_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            showTips("#update_email_input", "error", "邮箱格式不正确");
            return false;
        } else {
            showTips("#update_email_input", "success", "校验通过");
            // alert($("#updateModal form").serialize());
        }

        // 发送 ajax 请求，保存更新后的员工信息
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
            /**
             *  // 如果使用 _method=PUT 这种方式的话，请求方式要使用 POST
             *  type: "POST",
             *  data: $("#updateModal form").serialize()+"&_method=PUT",
             */
            type: "PUT",
            data: $("#updateModal form").serialize(),
            success: function () {
                // 1、关闭对话框
                updateModal.hide();

                // 2、回到本页面
                to_page(currentPage);
            }
        });
    });

    // 单个删除
    $(document).on("click", ".delete_btn", function () {
        // 1、弹出是否确认删除对话框，this 代指每一条记录， parents() 是找到当前记录的父元素，td:eq(2) 是找到第三个 td 元素
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("delete_id");

        // alert($(this).parents("tr").find("td:eq(1)").text());

        if (confirm("确认删除 【" + empName + "】吗？")) {
            // 确认，发送 ajax 请求删除即可
            $.ajax({
                url: "${APP_PATH}/emp/" + empId,
                type: "DELETE",
                success: function (result) {
                    alert(result.message);
                    // 回到本页
                    to_page(currentPage);
                }
            });
        }
    });

    // 完成全选/全不选功能
    $("#check_all").click(function () {
        /**
         * attr() 方法获取 checked 是 undefined
         * attr() 是用于获取自定义属性的值，而 prop() 能够修改和读取 DOM 原生属性的值
         */
        $(".check_item").prop("checked", $(this).prop("checked"));
    });

    // check_item
    $(document).on("click", ".check_item", function () {
        // 判断当前选择中的元素是否 5 个
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    });

    // 点击全部删除，就批量删除
    $("#delete_more_btn").click(function () {
        var empNames = "";
        var delete_id_str = "";
        $.each($(".check_item:checked"), function () {
            // this
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            // 组装员工 id 字符串
            delete_id_str += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });

        // 去除 empNames 多余的逗号 ,
        empNames = empNames.substring(0,empNames.length-1);
        // 去除 delete_id_str 多余的减号 -
        delete_id_str = delete_id_str.substring(0,delete_id_str.length-1);

        if(confirm("确认删除【"+empNames+"】吗？")){
            // 发送 ajax 请求删除
            $.ajax({
                url:"${APP_PATH}/emp/"+delete_id_str,
                type:"DELETE",
                success:function(result){
                    alert(result.message);
                    // 回到当前页面
                    to_page(currentPage);
                }
            });
        }
    });
</script>

</body>
</html>
