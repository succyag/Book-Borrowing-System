package com.yx.dao;

import com.yx.po.TypeInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TypeInfoMapper {
    /**
     * 查询所有的记录信息
     */
    List<TypeInfo> queryTypeInfoAll(@Param(value = "name") String name);

    /**
     * 添加图书类型
     */
    void addTypeSubmit(TypeInfo info);

    /**
     * 修改 根据id查询记录信息，查询弹出修改界，然后修改进行确认提交
     */
    TypeInfo queryTypeInfoById(Integer id);

    /**
     * 修改提交
     */
    void updateTypeSubmit(TypeInfo info);

    /**
     * 根据ids删除记录信息
     */
    void deleteTypeByIds(List<Integer> id);

    //List<TypeInfo> queryTypeName();
}