<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<html>
<head>
    <meta charset="utf-8">
    <title>修改密码</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <style>
        body {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div class="layui-form layuimini-form">
    <input type="hidden" name="id"  value="${id}">
    <div class="layui-form-item">
        <label class="layui-form-label required">旧密码</label>
        <div class="layui-input-block">
            <input type="password" name="oldPwd" lay-verify="required" lay-reqtext="旧密码不能为空" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label required">新密码</label>
        <div class="layui-input-block">
            <input type="password" name="newPwd" lay-verify="required" lay-reqtext="新密码不能为空" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label required">确认新密码</label>
        <div class="layui-input-block">
            <input type="password" name="newPwdAgain" lay-verify="required" lay-reqtext="新密码不能为空" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认修改</button>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$;

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            var datas=data.field;//form单中的数据信息
            if (datas.newPwd != datas.newPwdAgain){
                layer.msg("两次输入的新密码不一致,请重新输入")
            }else{
                //向后台发送数据提交添加
                $.ajax({
                    url:"updatePwdSubmit",
                    type:"POST",
                    data: {
                        id:datas.id,
                        oldPwd:datas.oldPwd,
                        newPwd:datas.newPwd
                    },
                    success:function(result){
                        if(result.code==0){//如果成功
                            layer.msg("修改成功",{
                                icon:6,
                                time:500
                            },function(){
                                parent.window.location.reload();
                                var iframeIndex = parent.layer.getFrameIndex(window.name);
                                parent.layer.close(iframeIndex);
                            })
                        }else{
                            layer.msg(result.msg);
                        }
                    }
                })
            }
            return false;
        });

    });
</script>
</body>
</html>
