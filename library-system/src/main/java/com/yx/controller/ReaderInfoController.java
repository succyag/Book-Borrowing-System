package com.yx.controller;

import com.github.pagehelper.PageInfo;
import com.yx.po.Admin;
import com.yx.po.BookInfo;
import com.yx.po.ReaderInfo;
import com.yx.po.TypeInfo;
import com.yx.service.AdminService;
import com.yx.service.ReaderInfoService;
import com.yx.utils.DataInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;

@Controller
public class ReaderInfoController {

    @Autowired
    private ReaderInfoService readerInfoService;

    @Autowired
    private AdminService adminService;

    /**
     * 跳转读者管理页面
     */
    @GetMapping("/readerIndex")
    public String readerIndex(){
        return "reader/readerIndex";
    }

    /**
     * 查询所有数据
     */
    @RequestMapping("/readerAll")
    @ResponseBody
    public DataInfo queryReaderAll(ReaderInfo readerInfo, @RequestParam(defaultValue = "1") Integer pageNum, @RequestParam(defaultValue = "15") Integer limit){
        PageInfo<ReaderInfo> pageInfo = readerInfoService.queryAllReaderInfo(readerInfo,pageNum,limit);
        return DataInfo.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }

    /**
     * 添加页面跳转
     */
    @RequestMapping("/readerAdd")
    public String readerAdd(){
        return "reader/readerAdd";
    }

    /**
     * 添加页面提交
     */
    @RequestMapping("/addReaderSubmit")
    @ResponseBody
    public DataInfo addReaderSubmit(@RequestBody ReaderInfo readerInfo){
        readerInfo.setPassword("123456");//设置默认密码
        readerInfoService.addReaderInfoSubmit(readerInfo);
        return DataInfo.ok();
    }

    /**
     * 根据id查询数据再跳转到修改页面
     */
    @GetMapping("/queryReaderInfoById")
    public String queryReaderInfoById(Integer id, Model model){
        ReaderInfo readerInfo = readerInfoService.queryReaderInfoById(id);
        model.addAttribute("info",readerInfo);
        return "reader/updateReader";
    }

    /**
     * 修改提交
     */
    @RequestMapping("/updateReaderSubmit")
    @ResponseBody
    public DataInfo updateReaderSubmit(@RequestBody ReaderInfo readerInfo){
        readerInfoService.updateReaderInfoSubmit(readerInfo);
        return DataInfo.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/deleteReader")
    @ResponseBody
    public DataInfo deleteReader(String ids){
        List<String> list= Arrays.asList(ids.split(","));
        readerInfoService.deleteReaderInfoByIds(list);
        return DataInfo.ok();
    }

    /**
     * 修改提交（右上角修改密码）
     */
    @RequestMapping("/updatePwdSubmit2")
    @ResponseBody
    public DataInfo updatePwdSubmit(HttpServletRequest request, String oldPwd, String newPwd){
        HttpSession session = request.getSession();
        if(session.getAttribute("type")=="admin"){
            //管理员
            Admin admin = (Admin)session.getAttribute("user");
            Admin admin1 = (Admin)adminService.queryAdminById(admin.getId());
            if (!oldPwd.equals(admin1.getPassword())){
                return DataInfo.fail("输入的旧密码错误");
            }else{
                admin1.setPassword(newPwd);
                adminService.updateAdminSubmit(admin1);//数据库修改
            }
        }else{
            //读者
            ReaderInfo readerInfo = (ReaderInfo) session.getAttribute("user");
            ReaderInfo readerInfo1 = readerInfoService.queryReaderInfoById(readerInfo.getId());//根据id查询对象
            if (!oldPwd.equals(readerInfo1.getPassword())){
                return DataInfo.fail("输入的旧密码错误");
            }else{
                readerInfo1.setPassword(newPwd);
                readerInfoService.updateReaderInfoSubmit(readerInfo1);//数据库修改
            }
        }
        return DataInfo.ok();
    }
}
