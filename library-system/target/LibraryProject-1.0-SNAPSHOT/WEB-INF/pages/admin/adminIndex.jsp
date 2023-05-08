<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>管理员管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <div class="demoTable">
            <div class="layui-form-item layui-form">
                用户名：
                <div class="layui-inline">
                    <input class="layui-input" name="username" id="username" autocomplete="off">
                </div>
                管理员类型：
                <div class="layui-inline">
                    <select id="adminType" name="adminType" class="layui-input">
                        <option value="">请选择</option>
                        <option value="0">普通管理员</option>
                        <option value="1">高级管理员</option>
                    </select>
                </div>
                <button class="layui-btn" data-type="reload">搜索</button>
            </div>
        </div>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除 </button>
            </div>
        </script>

        <!--表单，查询出的数据在这里显示-->
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">修改密码</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
        </script>

    </div>
</div>

<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/adminAll',//查询全部数据
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                //{field: 'id', width: 100, title: 'ID', sort: true},
                {field: 'username', width: 150, title: '用户名'},
                {field: 'adminType', width: 200, title: '管理员类型',templet:function (res) {
                        if (res.adminType == '0'){
                            return '<span class="layui-btn layui-btn-normal layui-btn-xs">普通管理员</span>';
                        }else{
                            return '<span class="layui-btn layui-btn-normal layui-btn-xs" style="background-color: orangered;">高级管理员</span>';
                        }
                    }},
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,  <!--默认显示15条-->
            page: true,
            skin: 'line',
            id:'testReload'
        });

        var $ = layui.$, active = {
            reload: function(){
                var username = $('#username').val();
                var adminType = $('#adminType').val();
                console.log(name)
                //执行重载
                table.reload('testReload', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        username: username,
                        adminType:adminType
                    }
                }, 'data');
            }
        };

        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

        /**
         * tool操作栏监听事件
         */
        table.on('tool(currentTableFilter)', function (obj) {
            var data=obj.data;
            if (obj.event === 'edit') {  // 监听修改操作
                var index = layer.open({
                    title: '修改管理员信息',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '60%'],
                    content: '${pageContext.request.contextPath}/queryAdminById?id='+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {  // 监听删除操作
                layer.confirm('确定是否删除', function (index) {
                    //调用删除功能
                    deleteInfoByIds(data.id,index);
                    layer.close(index);
                });
            }
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        /**
         * 获取选中记录的id信息
         */
        function getCheackId(data){
            var arr=new Array();
            for(var i=0;i<data.length;i++){
                arr.push(data[i].id);
            }
            //拼接id,变成一个字符串
            return arr.join(",");
        };


        /**
         * 提交删除功能
         */
        function deleteInfoByIds(ids ,index){
            //向后台发送请求
            $.ajax({
                url: "deleteAdminByIds",
                type: "POST",
                data: {ids: ids},
                success: function (result) {
                    if (result.code == 0) {//如果成功
                        layer.msg('删除成功', {
                            icon: 6,
                            time: 500
                        }, function () {
                            parent.window.location.reload();
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        });
                    } else {
                        layer.msg("删除失败");
                    }
                }
            })
        };

        /**
         * toolbar栏监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '添加管理员',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '60%'],
                    content: '${pageContext.request.contextPath}/adminAdd',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {
                /*
                  1、提示内容，必须删除大于0条
                  2、获取要删除记录的id信息
                  3、提交删除功能 ajax
                */
                //获取选中的记录信息
                var checkStatus=table.checkStatus(obj.config.id);
                var data=checkStatus.data;
                if(data.length==0){//如果没有选中信息
                    layer.msg("请选择要删除的记录信息");
                }else{
                    //获取记录信息的id集合,拼接的ids
                    var ids=getCheackId(data);
                    layer.confirm('确定是否删除', function (index) {
                        //调用删除功能
                        deleteInfoByIds(ids,index);
                        layer.close(index);
                    });
                }
            }
        });

    });
</script>

</body>
</html>
