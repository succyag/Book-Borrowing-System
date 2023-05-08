package com.yx.controller;

import com.github.pagehelper.PageInfo;
import com.yx.po.Admin;
import com.yx.po.Notice;
import com.yx.service.AdminService;
import com.yx.service.NoticeService;
import com.yx.service.ReaderInfoService;
import com.yx.utils.DataInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class BaseController {

    @Autowired
    private NoticeService noticeService;

    /**
     * 首页
     * @return
     */
    @GetMapping("/index")
    public String index(){
        return "index";
    }

    /**
     * 欢迎页面跳转
     * @return
     */
    @GetMapping("/welcome")
    public String welcome(Model model){
        //提供公告信息
        PageInfo<Notice> pageInfo =  noticeService.queryAllNotice(null,1,5);
        if (pageInfo!=null){
            List<Notice> noticeList = pageInfo.getList();
            model.addAttribute("noticeList",noticeList);
        }
        return "welcome";
    }

    @GetMapping("/updatePassword")
    public String updatePwd(){
        return "pwdUpdate/updatePwd";
    }

}
