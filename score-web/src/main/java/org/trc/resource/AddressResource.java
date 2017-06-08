package org.trc.resource;

import com.alibaba.fastjson.JSONObject;
import org.hibernate.validator.constraints.NotEmpty;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.trc.biz.impl.consumer.AddressBiz;
import org.trc.constants.ScoreConstants;
import org.trc.domain.consumer.Address;
import org.trc.util.CommonConstants;
import org.trc.util.CustomAck;
import org.trc.util.TxJerseyTools;

import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;
import java.util.Calendar;
import java.util.Date;


/**
 * Created by hzwzhen on 2017/6/6.
 */
@Component
@Path("test")

public class AddressResource {

    private Logger logger = LoggerFactory.getLogger(AddressResource.class);
    @Autowired
    private AddressBiz addressBiz;

    @POST
    @Path(ScoreConstants.Route.Address.ADD)
    public Response addAddress(@NotEmpty @FormParam("provinceCode") String provinceCode, @NotEmpty @FormParam("cityCode") String cityCode,
                               @FormParam("areaCode") String areaCode, @NotEmpty @FormParam("address") String address,
                               @NotEmpty @FormParam("receiverName") String receiverName, @NotEmpty @FormParam("phone") String phone,
                               @FormParam("postcode") String postcode, @FormParam("isDefault") boolean isDefault){
        String userId = null;
        try {
            AddressDO addressDO = new AddressDO();
            addressDO.setUserId(userId);
            addressDO.setIsDeleted(false);
            addressDO.setAddress(address);
            addressDO.setProvinceCode(provinceCode);
            addressDO.setCityCode(cityCode);
            addressDO.setAreaCode(areaCode);
            addressDO.setReceiverName(receiverName);
            addressDO.setPhone(phone);
            addressDO.setPostcode(postcode);
            addressDO.setIsDefault(isDefault);
            Date time = Calendar.getInstance().getTime();
            addressDO.setCreateTime(time);
            addressDO.setUpdateTime(time);
            ScoreProvider.addressService.addAddressDO(addressDO);
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("addressId", addressDO.getId());
            return TxJerseyTools.returnSuccess(jsonObject.toJSONString());
        } catch (AddressException e){
            logger.error("====>addAddress exception", e.getCode());
            return CustomAck.customError(e.getMessage());
        } catch (Exception e) {
            logger.error("====>addAddress exception", e);
            return TxJerseyTools.returnAbort(CommonConstants.ErrorCode.ERROR_SERVICE_IN_REST);
        }

    }
    @GET
    @Path("address")
    public void test(){
        Address address = new Address();
        address.setUserId("userId1");
        address.setProvinceCode("00");
        address.setCityCode("11");
        address.setAreaCode("22");
        address.setAddress("北京市");
        address.setReceiverName("zhangsan");
        address.setPhone("18012341234");
        address.setPostcode("88");
        address.setIsDefault(true);
        address.setIsDeleted(false);
        address.setCreateTime(new Date());
        try {
            int num = addressBiz.saveAddress(address);
            System.out.println(num);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
