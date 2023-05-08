<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<!DOCTYPE html>
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
        .layui-form-item .layui-input-company {width: auto;padding-right: 10px;line-height: 38px;}
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <div class="layui-form layuimini-form">
            <div class="layui-form-item">
                <label class="layui-form-label required">旧的密码</label>
                <div class="layui-input-block">
                    <input type="password" name="oldPwd" id="oldPwd" lay-verify="required" lay-reqtext="旧密码不能为空" placeholder="请输入旧的密码"  value="" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label required">新的密码</label>
                <div class="layui-input-block">
                    <input type="password" name="newPwd" id="newPwd" lay-verify="required" lay-reqtext="新密码不能为空" placeholder="请输入新的密码"  value="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label required">确认密码</label>
                <div class="layui-input-block">
                    <input type="password" name="againPwd" id="againPwd" lay-verify="required" lay-reqtext="密码不能为空" placeholder="请输入新的密码"  value="" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认保存</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$;

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            var datas=data.field;//form单中的数据信息
            if (datas.newPwd != datas.againPwd){
                layer.msg("两次输入的新密码不一致,请重新输入")
            }else{
                //向后台发送数据提交添加
                $.ajax({
                    url:"updatePwdSubmit2", //读者的修改密码
                    type:"POST",
                    data: {
                        oldPwd:datas.oldPwd,
                        newPwd:datas.newPwd
                    },
                    success:function(result){
                        if(result.code==0){//如果成功
                            layer.msg("修改成功",{
                                icon:6,
                                time:500
                            },function(){
                                var oldPassword = document.getElementById("oldPwd");
                                var newPassword = document.getElementById("newPwd");
                                var againPassword = document.getElementById("againPwd");
                                oldPassword.value = "";
                                newPassword.value = "";
                                againPassword.value = "";
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