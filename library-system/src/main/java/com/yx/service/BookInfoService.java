package com.yx.service;

import com.github.pagehelper.PageInfo;
import com.yx.po.BookInfo;

import java.util.List;

public interface BookInfoService {

    /**
     * 查询所有记录
     */
    PageInfo<BookInfo> queryBookInfoAll(BookInfo bookInfo,Integer pageNum,Integer limit);

    /**
     * 添加图书记录
     */
    void addBookSubmit(BookInfo bookInfo);
    /**
     * 修改 根据id查询记录信息
     */
    BookInfo queryBookInfoById(Integer id);

    /**
     * 修改提交
     */
    void updateBookSubmit(BookInfo info);

    /**
     * 根据ids删除记录信息
     */
    void deleteBookByIds(List<String> ids);

    /**
     * 根据类型获取图书数量
     */
    List<BookInfo> getBookCountByType();
}
