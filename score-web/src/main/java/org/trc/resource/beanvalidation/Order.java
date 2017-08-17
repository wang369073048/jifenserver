package org.trc.resource.beanvalidation;

/**
 * author: hzwzhen
 * JDK-version:  JDK1.8
 * comments:
 * since Date： 2017/8/17
 */
import java.util.List;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class Order {
    @NotNull(message = "订单号不能为空 ")
    @Size(max = 11, message = "订单号长度不能超过11")
    private String PlatformOrderID;
    @Valid // 级联验证
    private Receiver Receiver;
    @Valid // 级联验证
    private List<Product> ProductList;

    public String getPlatformOrderID() {
        return PlatformOrderID;
    }

    public void setPlatformOrderID(String platformOrderID) {
        PlatformOrderID = platformOrderID;
    }

    public Receiver getReceiver() {
        return Receiver;
    }

    public void setReceiver(Receiver receiver) {
        Receiver = receiver;
    }

    public List<Product> getProductList() {
        return ProductList;
    }

    public void setProductList(List<Product> productList) {
        ProductList = productList;
    }

}
