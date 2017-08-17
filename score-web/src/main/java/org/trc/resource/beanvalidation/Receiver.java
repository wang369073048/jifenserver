package org.trc.resource.beanvalidation;

/**
 * author: hzwzhen
 * JDK-version:  JDK1.8
 * comments:
 * since Date： 2017/8/17
 */
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

public class Receiver {
    @NotEmpty(message = "国家不能空")
    private String Country;
    private String CountryCode;
    @NotNull(message = "邮箱不能为空")
    @org.hibernate.validator.constraints.Email(message = "邮箱格式不正确")
    private String Email;

    public String getCountry() {
        return Country;
    }

    public void setCountry(String country) {
        Country = country;
    }

    public String getCountryCode() {
        return CountryCode;
    }

    public void setCountryCode(String countryCode) {
        CountryCode = countryCode;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

}
