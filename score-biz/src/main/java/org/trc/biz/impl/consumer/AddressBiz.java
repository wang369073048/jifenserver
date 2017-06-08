package org.trc.biz.impl.consumer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.trc.biz.consumer.IAddressBiz;
import org.trc.domain.consumer.Address;
import org.trc.service.consumer.IAddressService;

/**
 * Created by hzwzhen on 2017/6/6.
 */
@Service("addressBiz")
public class AddressBiz implements IAddressBiz{

    @Autowired
    private IAddressService addressService;

    @Override
    public int saveAddress(Address address) throws Exception {
        return addressService.insertSelective(address);
    }

    @Override
    public int updateAddress(Address address) throws Exception {
        return addressService.updateByPrimaryKeySelective(address);
    }
}
