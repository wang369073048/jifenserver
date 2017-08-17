package org.trc.resource.beanvalidation;

import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
/**
 * author: hzwzhen
 * JDK-version:  JDK1.8
 * comments:
 * since Date： 2017/8/17
 */
public class Product {
    @NotNull(message = "英文品名不能为空")
    private String CustomsName;
    private String CustomsCnName;
    @DecimalMin(value = "0", message = "申报价值不能小于0")
    private String DeclareValue;
    @Pattern(regexp = "\\d", message = "数量不合法") // 正则验证
    private String Quantity;

    public String getCustomsName() {
        return CustomsName;
    }

    public void setCustomsName(String customsName) {
        CustomsName = customsName;
    }

    public String getCustomsCnName() {
        return CustomsCnName;
    }

    public void setCustomsCnName(String customsCnName) {
        CustomsCnName = customsCnName;
    }

    public String getDeclareValue() {
        return DeclareValue;
    }

    public void setDeclareValue(String declareValue) {
        DeclareValue = declareValue;
    }

    public String getQuantity() {
        return Quantity;
    }

    public void setQuantity(String quantity) {
        Quantity = quantity;
    }

}
