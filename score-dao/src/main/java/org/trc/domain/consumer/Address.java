package org.trc.domain.consumer;

import org.trc.domain.BaseDO;

import javax.persistence.*;
import javax.ws.rs.PathParam;
import java.util.Date;

/**
 * Created by hzwzhen on 2017/6/6.
 */
@Table(name="address")
public class Address extends BaseDO{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "userId")
    private String userId; //用户ID
    @Column(name = "provinceCode")
    private String provinceCode; //省行政编码
    @Column(name = "cityCode")
    private String cityCode; //城市行政编码
    @Column(name = "areaCode")
    private String areaCode; //地区行政编码
    private String address; //具体地址
    @Column(name = "receiverName")
    private String receiverName;//收货人姓名
    private String phone;//联系人手机号
    private String postcode;//邮编
    @Column(name = "isDefault")
    private Boolean isDefault;//0 非默认 ;1 默认
    @Column(name = "isDeleted")
    private Boolean isDeleted;
    @Column(name = "createTime")
    private Date createTime;//创建时间
    @Column(name = "updateTime")
    private Date updateTime;//修改时间

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getProvinceCode() {
        return provinceCode;
    }

    public void setProvinceCode(String provinceCode) {
        this.provinceCode = provinceCode;
    }

    public String getCityCode() {
        return cityCode;
    }

    public void setCityCode(String cityCode) {
        this.cityCode = cityCode;
    }

    public String getAreaCode() {
        return areaCode;
    }

    public void setAreaCode(String areaCode) {
        this.areaCode = areaCode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public Boolean getIsDefault() {
        return isDefault;
    }

    public void setIsDefault(boolean aDefault) {
        isDefault = aDefault;
    }

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
