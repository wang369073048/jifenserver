package org.trc.resource;


import java.io.Serializable;
import java.util.*;

/**
 * Created by george on 2017/5/3.
 */
public class ActivityPrizesDO implements Serializable, Comparable<ActivityPrizesDO> {


    public ActivityPrizesDO(Long goodsId, Integer winningProbability) {
        this.goodsId = goodsId;
        this.winningProbability = winningProbability;
    }

    private final static List<ActivityPrizesDO> defaultActivityPrizes = new ArrayList<>();
    private final static Map<String, ActivityPrizesDO> defaultDataMap = new HashMap<>();

    /**
     * 已中奖率排序
     * @param o
     * @return
     */
    @Override
    public int compareTo(ActivityPrizesDO o) {
        if(null == this.winningProbability && null == o.winningProbability){
            return 0;
        }else if(null == this.winningProbability){
            return -1;
        }else if(null == o.winningProbability){
            return 1;
        }
        return this.winningProbability.compareTo(o.winningProbability);
    }

    /**
     * 主键
     */
    private Long id;

    /**
     * 店铺id
     */
    private Long shopId;

    /**
     * 抽奖活动id
     */
    private Long luckyDrawId;

    /**
     * 奖品id
     */
    private Long goodsId;

    /**
     * 奖品编码
     */
    private String goodsNo;

    /**
     * 奖品类型 SCORE|TCOIN|GOODS
     */
    private String prizeType;

    /**
     * 商品类型  1虚拟，2实物
     */
    private String goodsType;

    /**
     * 奖品图片
     */
    private String prizeUrl;

    /**
     * 奖品名称
     */
    private String name;

    /**
     * 单次中奖奖品数量
     */
    private Integer numberOfPrizes;

    /**
     * 用户中奖次数限制
     */
    private Integer winningLimit;

    /**
     * 中奖次数限制
     */
    private Integer winningTimes;
    /**
     * 中奖次数限制类型:PER_DAY每天,THE_WHOLE_ACTIVITY全程
     */
    private String winningType;

    /**
     * 中奖几率:单位/万分之一
     */
    private Integer winningProbability;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新时间
     */
    private Date updateTime;

    private Long category;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getShopId() {
        return shopId;
    }

    public void setShopId(Long shopId) {
        this.shopId = shopId;
    }

    public Long getLuckyDrawId() {
        return luckyDrawId;
    }

    public void setLuckyDrawId(Long luckyDrawId) {
        this.luckyDrawId = luckyDrawId;
    }

    public Long getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Long goodsId) {
        this.goodsId = goodsId;
    }

    public String getGoodsNo() {
        return goodsNo;
    }

    public void setGoodsNo(String goodsNo) {
        this.goodsNo = goodsNo;
    }

    public String getPrizeType() {
        return prizeType;
    }

    public void setPrizeType(String prizeType) {
        this.prizeType = prizeType;
    }

    public String getGoodsType() {
        return goodsType;
    }

    public void setGoodsType(String goodsType) {
        this.goodsType = goodsType;
    }

    public String getPrizeUrl() {
        return prizeUrl;
    }

    public void setPrizeUrl(String prizeUrl) {
        this.prizeUrl = prizeUrl;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getNumberOfPrizes() {
        return numberOfPrizes;
    }

    public void setNumberOfPrizes(Integer numberOfPrizes) {
        this.numberOfPrizes = numberOfPrizes;
    }

    public Integer getWinningLimit() {
        return winningLimit;
    }

    public void setWinningLimit(Integer winningLimit) {
        this.winningLimit = winningLimit;
    }

    public Integer getWinningTimes() {
        return winningTimes;
    }

    public void setWinningTimes(Integer winningTimes) {
        this.winningTimes = winningTimes;
    }

    public String getWinningType() {
        return winningType;
    }

    public void setWinningType(String winningType) {
        this.winningType = winningType;
    }

    public Integer getWinningProbability() {
        return winningProbability;
    }

    public void setWinningProbability(Integer winningProbability) {
        this.winningProbability = winningProbability;
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

    public Long getCategory() {
        return category;
    }

    public void setCategory(Long category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "ActivityPrizesDO{" +
                "id=" + id +
                ", shopId=" + shopId +
                ", luckyDrawId=" + luckyDrawId +
                ", goodsId=" + goodsId +
                ", goodsNo=" + goodsNo +
                ", prizeType='" + prizeType + '\'' +
                ", goodsType='" + goodsType + '\'' +
                ", prizeUrl='" + prizeUrl + '\'' +
                ", name='" + name + '\'' +
                ", numberOfPrizes=" + numberOfPrizes +
                ", winningLimit='" + winningLimit + '\'' +
                ", winningTimes='" + winningTimes + '\'' +
                ", winningType='" + winningType + '\'' +
                ", winningProbability=" + winningProbability +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }


}