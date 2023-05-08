<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>统计数据</title>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-min">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body">
                    <div id="main" style="width: 100%;min-height:500px"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['layer', 'miniTab','echarts'], function () {
        var $ = layui.jquery,
            layer = layui.layer,
            miniTab = layui.miniTab,
            echarts = layui.echarts;


        layui.use(['echarts'], function () {
            var echarts = layui.echarts,
                $ = layui.jquery;
            console.log(echarts);
            // 基于准备好的dom，初始化echarts实例
            var myChart = echarts.init(document.getElementById('main'));
            //var myChart2 = echarts.init(document.getElementById('main2'));

            // 指定图表的配置项和数据
            var option = {
                series : [
                    {
                        name: '访问来源',
                        type: 'pie',
                        radius: '55%',
                        data:[
                            <c:forEach items="${list}" var="type">
                            {value:${type.counts}, name:'${type.name}'},
                            </c:forEach>
                            ,0
                        ],
                        roseType: 'angle',
                        itemStyle: {
                            normal: {
                                shadowBlur: 200,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };

            // 使用刚指定的配置项和数据显示图表
            myChart.setOption(option);
        });
    });
</script>
</body>
</html>
