package com.yx.controller;

import com.github.pagehelper.PageInfo;
import com.yx.po.TypeInfo;
import com.yx.service.TypeInfoService;
import com.yx.utils.DataInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@Controller //声明后端控制器
public class TypeInfoController {

    @Autowired
    private TypeInfoService typeInfoService;

    /**
     * 类型管理首页
     * @return
     */
    @GetMapping("/typeIndex")
    public String typeIndex(){
        return "type/typeIndex";
    }

    /**
     * 获取type数据信息，分页
     */
    @RequestMapping("/typeAll")
    @ResponseBody       //@ResponseBody将java对象转为json格式的数据，表示该方法的返回结果直接写入 HTTP response body 中，一般在异步ajax获取数据时使用
    public DataInfo typeAll(String name, @RequestParam(defaultValue = "1") Integer pageNum, @RequestParam(defaultValue = "15") Integer limit){
        PageInfo<TypeInfo> pageInfo = typeInfoService.queryTypeInfoAll(name,pageNum,limit);
        return DataInfo.ok("成功",pageInfo.getTotal(),pageInfo.getList());//总条数getTotal，数据封装成list,以便加载分页显示,由于加了ResponseBody,就会返回一个字符串
    }

    /**
     * 添加页面的跳转
     */
    @GetMapping("/typeAdd")
    public String typeAdd(){
        return "type/typeAdd";
    }

    /**
     * 类型添加提交
     */
    @PostMapping("/addTypeSubmit")
    @ResponseBody
    public DataInfo addTypeSubmit(TypeInfo info){
        typeInfoService.addTypeSubmit(info);
        return DataInfo.ok();
    }

    /**
     * 类型根据id查询(修改)
     */
    @GetMapping("/queryTypeInfoById")
    public String queryTypeInfoById(Integer id, Model model){
        TypeInfo info= typeInfoService.queryTypeInfoById(id);
        model.addAttribute("info",info);
        return "type/updateType";
    }

    /**
     * 修改提交功能
     */

    @RequestMapping("/updateTypeSubmit")
    @ResponseBody
    public DataInfo updateTypeSubmit(@RequestBody TypeInfo info){
        typeInfoService.updateTypeSubmit(info);
        return DataInfo.ok();
    }
    /**
     * 类型删除
     */

    @RequestMapping("/deleteType")
    @ResponseBody
    public DataInfo deleteType(String ids){
        List<String> list= Arrays.asList(ids.split(","));
        typeInfoService.deleteTypeByIds(list);
        return DataInfo.ok();
    }
}
