package org.trc.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.trc.IBaseService;
import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.common.MySqlMapper;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 * Created by hzwzhen on 2017/6/6.
 */
public class BaseService<T,PK> implements IBaseService<T,PK> {

    @Autowired
    private Mapper<T> mapper;
    @Autowired
    private MySqlMapper<T> mySqlMapper;

    @Override
    public int insert(T record) {
        return mapper.insert(record);
    }

    @Override
    public int insertList(List<T> records) {
        return mySqlMapper.insertList(records);
    }

    @Override
    public int insertSelective(T record) {
        return mapper.insertSelective(record);
    }

    @Override
    public int deleteByPrimaryKey(PK key) {
        return mapper.deleteByPrimaryKey(key);
    }

    @Override
    public int updateByPrimaryKey(T record) {
        return mapper.updateByPrimaryKey(record);
    }

    @Override
    public int updateByPrimaryKeySelective(T record) {
        return mapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByExample(T t, Example example) {
        return mapper.updateByExample(t, example);
    }

    @Override
    public T selectOne(T record) {
        return mapper.selectOne(record);
    }

    @Override
    public List<T> select(T record) {
        return mapper.select(record);
    }

    @Override
    public List<T> selectByExample(Object example) {
        return mapper.selectByExample(example);
    }
}
