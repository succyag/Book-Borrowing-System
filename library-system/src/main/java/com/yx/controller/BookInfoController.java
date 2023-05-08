package com.yx.controller;

import com.github.pagehelper.PageInfo;
import com.yx.po.BookInfo;
import com.yx.po.TypeInfo;
import com.yx.service.BookInfoService;
import com.yx.service.TypeInfoService;
import com.yx.utils.DataInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@Controller
public class BookInfoController {

    @Autowired
    private BookInfoService bookInfoService;

    @Autowired
    private TypeInfoService typeInfoService;

    /**
     * 图书管理首页
     * @return
     */
    @GetMapping("/bookIndex")
    public String bookIndex(){
        return "book/bookIndex";
    }

    /**
     * 获取book信息，封装成json
     * @param bookInfo
     * @param pageNum
     * @param limit
     * @return
     */
    @RequestMapping("/bookAll")
    @ResponseBody       //@ResponseBody将java对象转为json格式的数据，表示该方法的返回结果直接写入 HTTP response body 中，一般在异步ajax获取数据时使用
    public DataInfo bookAll(BookInfo bookInfo, @RequestParam(defaultValue = "1") Integer pageNum, @RequestParam(defaultValue = "15") Integer limit){
        PageInfo<BookInfo> pageInfo = bookInfoService.queryBookInfoAll(bookInfo,pageNum,limit);
        return DataInfo.ok("成功",pageInfo.getTotal(),pageInfo.getList());//总条数getTotal，数据封装成list,以便加载分页显示,由于加了ResponseBody,就会返回一个字符串
    }

    /**
     * 添加页面的跳转
     */
    @GetMapping("/bookAdd")
    public String bookAdd(){
        return "book/bookAdd";
    }

    /**
     * 类型添加提交
     */
    @RequestMapping("/addBookSubmit")
    @ResponseBody
    public DataInfo addBookSubmit(BookInfo info){
        bookInfoService.addBookSubmit(info);
        return DataInfo.ok();
    }

    /**
     * 类型根据id查询(修改)
     */
    @GetMapping("/queryBookInfoById")
    public String queryTypeInfoById(Integer id, Model model){
        BookInfo bookInfo= bookInfoService.queryBookInfoById(id);
        model.addAttribute("info",bookInfo);
        return "book/updateBook";
    }

    /**
     * 修改提交功能
     */

    @RequestMapping("/updateBookSubmit")
    @ResponseBody
    public DataInfo updateBookSubmit(@RequestBody BookInfo info){
        bookInfoService.updateBookSubmit(info);
        return DataInfo.ok();
    }
    /**
     * 类型删除
     */

    @RequestMapping("/deleteBook")
    @ResponseBody
    public DataInfo deleteBook(String ids){
        List<String> list= Arrays.asList(ids.split(","));
        bookInfoService.deleteBookByIds(list);
        return DataInfo.ok();
    }

    @RequestMapping("/findAllList")
    @ResponseBody
    public List<TypeInfo> findAll(){
        PageInfo<TypeInfo> pageInfo = typeInfoService.queryTypeInfoAll(null,1,100);
        List<TypeInfo> lists = pageInfo.getList();
        return lists;
    }
}
