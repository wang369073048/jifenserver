package org.trc.biz.consumer;

import org.trc.domain.consumer.Address;

/**
 * Created by hzwzhen on 2017/6/6.
 */
public interface IAddressBiz {

    /**
     * 保存地址
     * @param address
     * @throws Exception
     */
    int saveAddress(Address address) throws Exception;

    int updateAddress(Address address) throws  Exception;
}
