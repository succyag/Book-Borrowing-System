package com.yx.service;

import com.github.pagehelper.PageInfo;
import com.yx.po.LendList;

import java.util.List;

public interface LendListService {

    //分页查询
    PageInfo<LendList> queryLendListAll(LendList lendList, int page, int limit);

    //添加借阅记录
    void addLendListSubmit(LendList lendList);


    /**
     * 删除
     */
    void deleteLendListById(List<String> ids, List<String> bookIds);

    /**
     * 还书
     */
    void updateLendListSubmit(List<String> ids, List<String> bookIds);

    /**
     * 异常还书
     */
    void backBook(LendList lendList);

    /**
     * 时间线查询
     */
    List<LendList> queryLookBookList(Integer rid, Integer bid);
}
