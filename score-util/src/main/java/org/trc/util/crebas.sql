/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2017/6/26 14:02:45                           */
/*==============================================================*/


drop table if exists activity_prizes;

drop table if exists address;

drop table if exists area;

drop table if exists banner;

drop table if exists banner_content;

drop table if exists barrage;

drop table if exists card_coupons;

drop table if exists card_item;

drop table if exists card_item_abandoned;

drop table if exists category;

drop index unq_user_id_account_day_shop_id on consumption_summary;

drop table if exists consumption_summary;

drop table if exists exchange_rate;

drop table if exists exchange_rate_history;

drop table if exists goods;

drop table if exists goods_recommend;

drop table if exists goods_snapshot;

drop table if exists log_information;

drop table if exists logistic_code;

drop table if exists logistics;

drop table if exists lucky_draw;

drop table if exists manager;

drop index ung_user_id_account_day on membership_score_daily_details;

drop table if exists membership_score_daily_details;

drop table if exists notice;

drop table if exists order_address;

drop table if exists order_locus;

drop table if exists orders;

drop table if exists orders_extend;

drop table if exists participation_record;

drop table if exists request_flow;

drop table if exists resource;

drop table if exists role;

drop table if exists role_resource_relation;

drop table if exists score;

drop table if exists score_auth;

drop table if exists score_change;

drop table if exists score_change_detail;

drop table if exists score_child;

drop table if exists score_converter_flow;

drop table if exists score_exchange_flow;

drop table if exists score_settlement;

drop table if exists score_user;

drop table if exists settlement;

drop table if exists shop;

drop table if exists shopwindow;

drop table if exists user_role_relation;

drop table if exists winning_record;

/*==============================================================*/
/* Table: activity_prizes                                       */
/*==============================================================*/
create table activity_prizes
(
   id                   bigint(20) unsigned not null auto_increment comment '主键',
   shopId               bigint(20) not null comment '店铺id',
   luckyDrawId          bigint(20) not null comment '抽奖活动id',
   goodsId              bigint(20) default NULL comment '奖品id',
   prizeType            varchar(32) not null comment '奖品类型 SCORE|TCOIN|GOODS',
   goodsType            varchar(32) not null comment '1-虚拟;2-实物;3-谢谢参与',
   prizeUrl             varchar(255) not null comment '奖品图片',
   name                 varchar(64) not null comment '奖品名称',
   numberOfPrizes       int(11) default NULL comment '单次中奖奖品数量',
   winningLimit         int(11) default NULL comment '用户中奖次数限制',
   winningTimes         int(11) default NULL comment '中奖次数限制',
   winningType          varchar(32) default NULL comment '中奖次数限制类型:PER_DAY每天,THE_WHOLE_ACTIVITY全程',
   winningProbability   int(11) not null comment '中奖几率:单位/万分之一',
   createTime           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '更新时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=244 DEFAULT CHARSET=utf8 COMMENT='活动奖品信息表';

/*==============================================================*/
/* Table: address                                               */
/*==============================================================*/
create table address
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   userId               varchar(64) not null comment '用户ID',
   provinceCode         varchar(32) not null comment '省行政编码',
   cityCode             varchar(32) not null comment '城市行政编码',
   districtCode         varchar(32) default NULL comment '地区行政编码',
   address              varchar(255) not null comment '具体地址',
   receiverName         varchar(16) not null comment '收货人姓名',
   phone                varchar(16) not null comment '联系人手机号',
   postcode             varchar(12) default NULL comment '邮编',
   isDefault            tinyint(1) not null comment '0 非默认 ;1 默认',
   isDeleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   createTime           timestamp not null default '2017-01-01 00:00:00' comment '创建时间',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COMMENT='地址表';

/*==============================================================*/
/* Table: area                                                  */
/*==============================================================*/
create table area
(
   id                   bigint(20) not null auto_increment,
   code                 varchar(40) not null,
   province             varchar(40) not null,
   city                 varchar(40) not null,
   district             varchar(40) not null,
   parent               bigint(20) not null,
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=3924 DEFAULT CHARSET=utf8 COMMENT='省市区表';

/*==============================================================*/
/* Table: banner                                                */
/*==============================================================*/
create table banner
(
   id                   bigint(20) not null,
   shopId               bigint(20) not null comment '业务方ID',
   name                 varchar(64) not null comment '名称',
   type                 varchar(32) not null comment '类型: PC|APP',
   contentId            bigint(20) default NULL comment 'Banner内容ID',
   isUp                 tinyint(1) default NULL comment '是否上架,0上架,1下架',
   autoEnableTime       timestamp comment '自动生效时间',
   autoDisabledTime     timestamp comment '自动失效时间',
   sort                 int(11) default NULL comment '排序',
   description          varchar(128) default NULL,
   isDeleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   createTime           timestamp not null default '2017-01-01 00:00:00' comment '创建时间',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 COMMENT='banner表';

/*==============================================================*/
/* Table: banner_content                                        */
/*==============================================================*/
create table banner_content
(
   id                   bigint(20) not null comment '主键标示',
   shopId               bigint(20) not null comment '业务方ID',
   title                varchar(64) not null comment '标题',
   type                 varchar(32) not null comment '类型: PC|APP',
   pictureUrl           varchar(128) not null comment '图片url',
   targetUrl            varchar(128) not null comment '跳转url',
   description          varchar(128) not null comment '备注',
   isDeleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   createTime           timestamp not null default '2017-01-01 00:00:00' comment '创建时间',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='banner内容页';

/*==============================================================*/
/* Table: barrage                                               */
/*==============================================================*/
create table barrage
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   shopId               bigint(20) not null comment '商品所属店铺',
   orderId              bigint(20) not null comment '商品名称',
   userId               varchar(64) not null,
   avatar               varchar(128) default NULL comment '头像',
   phone                varchar(32) default NULL comment '联系人手机号(带*的)',
   originalPhone        varchar(32) default NULL comment '原手机号(不带*的)',
   goodsName            varchar(64) default NULL comment '商品名称',
   content              text comment '内容',
   isDeleted            tinyint(1) not null default 0 comment '0 正常 ;1 已删除',
   createTime           timestamp default CURRENT_TIMESTAMP comment '创建时间',
   updateTime           timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='弹幕表';

/*==============================================================*/
/* Table: card_coupons                                          */
/*==============================================================*/
create table card_coupons
(
   id                   bigint(20) not null auto_increment comment '主键',
   shopId               bigint(20) not null comment '店铺id',
   couponName           varchar(64) not null comment '卡券名称',
   remark               varchar(256) default NULL comment '备注',
   batchNumber          varchar(32) not null comment '批次号',
   stock                int(11) not null comment '库存',
   version              bigint(20) not null comment '版本号，并发乐观锁，初始版本1，更新+1',
   isDeleted            tinyint(1) not null comment '状态(0:未删除的，1:被删除)',
   validStartTime       timestamp default NULL comment '有效开始日期',
   validEndTime         timestamp default NULL comment '有效结束日期',
   createTime           timestamp not null default '2017-01-01 00:00:00' comment '创建时间',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   primary key (id),
   unique key batchNumber_UNIQUE (batchNumber)
)
ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='卡券信息表';

/*==============================================================*/
/* Table: card_item                                             */
/*==============================================================*/
create table card_item
(
   id                   bigint(20) unsigned not null auto_increment comment '主键',
   shopId               bigint(20) not null comment '店铺id',
   batchNumber          varchar(32) not null comment '批次号',
   code                 varchar(32) not null comment '券码',
   state                int(11) not null comment '状态(0:未发放，1:已发放)',
   userId               varchar(64) default NULL comment '用户id',
   orderNum             varchar(64) default NULL,
   createTime           timestamp not null default '2017-01-01 00:00:00' comment '创建时间',
   releaseTime          timestamp default NULL comment '发放时间',
   primary key (id),
   unique key code_UNIQUE (code)
)
ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8 COMMENT='卡券明细表';

/*==============================================================*/
/* Table: card_item_abandoned                                   */
/*==============================================================*/
create table card_item_abandoned
(
   id                   bigint(20) unsigned not null auto_increment comment '主键',
   shopId               bigint(20) not null comment '店铺id',
   batchNumber          varchar(32) not null comment '批次号',
   code                 varchar(32) not null comment '券码',
   state                int(11) not null comment '状态(0:未发放，1:已发放)',
   createTime           timestamp not null default '2017-01-01 00:00:00' comment '创建时间',
   abandonedTime        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '废弃时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COMMENT='废弃卡券明细表';

alter table card_item_abandoned comment '废弃卡券明细表';

/*==============================================================*/
/* Table: category                                              */
/*==============================================================*/
create table category
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   pid                  bigint(20) default NULL,
   code                 varchar(32) default NULL comment '编码',
   categoryName         varchar(16) not null comment '类目名称',
   isVirtual            tinyint(4) not null comment '1虚拟类目;2实物类目',
   allowUpdates         tinyint(1) not null comment '0 不允许 ;1 允许',
   pictureUrl           varchar(255) not null comment 'LOGO地址',
   sort                 int(11) default NULL comment '排序',
   description          varchar(255) default NULL comment '备注',
   operatorUserId       varchar(64) not null comment '操作人ID',
   isDeleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   createTime           timestamp not null default '2017-01-01 00:00:00' comment '创建时间',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='类目表';

/*==============================================================*/
/* Table: consumption_summary                                   */
/*==============================================================*/
create table consumption_summary
(
   id                   bigint(20) not null auto_increment comment '主键',
   userId               varchar(64) not null comment '唯一用户标示',
   accountDay           varchar(12) not null comment '记账日',
   shopId               bigint(20) default NULL comment '店铺id',
   phone                varchar(16) not null comment '会员手机号',
   exchangeInNum        bigint(20) not null comment '兑入积分数量',
   consumeNum           bigint(20) not null comment '消费积分数量',
   createTime           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='消费汇总';

/*==============================================================*/
/* Index: unq_user_id_account_day_shop_id                       */
/*==============================================================*/
create unique index unq_user_id_account_day_shop_id on consumption_summary
(
   userId,
   accountDay,
   shopId
);

/*==============================================================*/
/* Table: exchange_rate                                         */
/*==============================================================*/
create table exchange_rate
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   currency             varchar(32) comment '兑换币种',
   shopId               bigint(20) default NULL comment '店铺id',
   channelCode          varchar(32) not null comment '渠道编码',
   amount               int(11) not null comment '兑换金额',
   score                int(11) not null comment '积分',
   direction            varchar(32) not null comment '方向:只进不出；只出不进；可进可出(entranceOnly;exitOnly;bothway)',
   personEverydayInLimit bigint(20) default NULL comment '每人每天可兑入限额（可兑换的外币数量）',
   personEverydayOutLimit bigint(20) default NULL comment '每人每天可兑出限额（可兑换的外币数量）',
   channelEverydayInLimit bigint(20) default NULL comment '渠道每天可兑入限额（可兑换的外币数量）',
   channelEverydayOutLimit bigint(20) default NULL comment '渠道每天可兑出限额（可兑换的外币数量）',
   isDeleted            tinyint(1) not null comment '删除标示',
   createTime           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='积分转换';

/*==============================================================*/
/* Table: exchange_rate_history                                 */
/*==============================================================*/
create table exchange_rate_history
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   currency             varchar(32) comment '兑换币种',
   shopId               bigint(20) default NULL comment '店铺id',
   channelCode          varchar(32) not null comment '渠道编码',
   amount               int(11) not null comment '兑换金额',
   score                int(11) not null comment '积分',
   direction            varchar(32) not null comment '方向:只进不出；只出不进；可进可出(entranceOnly;exitOnly;bothway)',
   personEverydayInLimit bigint(20) default NULL comment '每人每天可兑入限额（可兑换的外币数量）',
   personEverydayOutLimit bigint(20) default NULL comment '每人每天可兑出限额（可兑换的外币数量）',
   channelEverydayInLimit bigint(20) default NULL comment '渠道每天可兑入限额（可兑换的外币数量）',
   channelEverydayOutLimit bigint(20) default NULL comment '渠道每天可兑出限额（可兑换的外币数量）',
   createTime           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='积分转换';

/*==============================================================*/
/* Table: goods                                                 */
/*==============================================================*/
create table goods
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   shopId               bigint(20) not null comment '商品所属店铺',
   category             bigint(20) not null comment '所属类目',
   brandName            varchar(16) default NULL comment '品牌名称',
   goodsName            varchar(64) not null comment '商品名称',
   barcode              varchar(32) not null comment '商品条码',
   goodsNo              varchar(32) default NULL comment '商品货号',
   batchNumber          varchar(32) default NULL comment '虚拟商品批次号',
   goodsSn              varchar(32) not null comment '商品编号',
   mainImg              varchar(128) not null comment '商品主图',
   mediumImg            varchar(1024) default NULL comment '附属图片(json格式)',
   priceMarket          int(11) default NULL comment '市场价',
   priceScore           int(11) not null default 0 comment '积分兑换价格',
   targetUrl            varchar(255) default NULL comment '商品链接',
   stock                int(11) not null default 0 comment '库存',
   stockWarn            int(11) default NULL comment '警报库存',
   exchangeQuantity     int(11) not null default 0 comment '兑换数量',
   virtualExchangeQuantity int(11) not null default 0 comment '虚拟兑换量',
   isUp                 tinyint(1) default NULL comment '是否上架.1上架,0下架',
   content              mediumtext comment '商品详情介绍',
   version              int(11) not null default 1,
   whetherPrizes        tinyint(4) not null default 0 comment '0-非奖品;1-奖品',
   isDeleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   validStartTime       timestamp default NULL comment '有效开始日期',
   validEndTime         timestamp default NULL comment '有效结束日期',
   autoUpTime           timestamp default NULL comment '自动上架日期',
   autoDownTime         timestamp default NULL comment '自动下架日期',
   upTime               timestamp default NULL comment '上架时间',
   snapshotTime         timestamp not null default '2017-01-01 00:00:00' comment '快照时间',
   createTime           timestamp not null default '2017-01-01 00:00:00' comment '创建时间',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   primary key (id),
   unique key goodSn_UNIQUE (goodsSn),
   unique key shopId_barcode (shopId, barcode)
)
ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='商品表';

/*==============================================================*/
/* Table: goods_recommend                                       */
/*==============================================================*/
create table goods_recommend
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   shopId               bigint(20) not null comment '店铺ID',
   goodsId              bigint(20) not null comment '商品ID',
   sort                 int(11) default NULL comment '排序',
   isDeleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   createTime           timestamp not null default '2017-01-01 00:00:00' comment '创建时间',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='商品推荐表';

/*==============================================================*/
/* Table: goods_snapshot                                        */
/*==============================================================*/
create table goods_snapshot
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   goodsId              bigint(20) not null comment '商品id',
   shopId               bigint(20) not null comment '商品所属店铺',
   barCode              varchar(32),
   category             bigint(20) not null comment '所属类目',
   brandName            varchar(16) default NULL comment '品牌名称',
   goodsName            varchar(64) not null comment '商品名称',
   batchNumber          varchar(32) default NULL comment '虚拟商品批次号',
   goodsNo              varchar(32) comment '商品货号',
   goodsSn              varchar(32) not null comment '商品编号',
   mainImg              varchar(128) not null comment '商品主图',
   mediumImg            varchar(1024) default NULL comment '附属图片(json格式)',
   priceMarket          int(11) default NULL comment '市场价',
   priceScore           int(11) not null default 0 comment '积分兑换价格',
   targetUrl            varchar(255) default NULL comment '商品链接',
   isUp                 tinyint(1) comment '上下架:0,下架1,上架',
   content              mediumtext comment '商品详情介绍',
   version              int(11) not null comment '商品版本 ',
   whetherPrizes        tinyint(1) comment '是否是奖品,0:不是,1:是',
   isDeleted            tinyint(1) comment '是否删除,0:否.1:是',
   validStartTime       timestamp default NULL comment '有效开始日期',
   validEndTime         timestamp default NULL comment '有效结束日期',
   createTime           timestamp not null default '2017-01-01 00:00:00' comment '创建时间',
   primary key (id),
   unique key AK_union_key (goodsId, version)
)
ENGINE=InnoDB AUTO_INCREMENT=382 DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Table: log_information                                       */
/*==============================================================*/
create table log_information
(
   id                   bigint(20) not null,
   entityType           varchar(16) not null,
   entityId             varchar(64) not null,
   operation            varchar(32) not null comment '操作类型',
   operatorUserid       varchar(64) not null comment '操作人userId',
   operator             varchar(64) comment '操作人',
   params               varchar(2048) comment '内容',
   remark               varchar(512) comment '备注',
   operateTime          timestamp not null comment '操作时间',
   primary key (id)
);

alter table log_information comment '日志信息表';

/*==============================================================*/
/* Table: logistic_code                                         */
/*==============================================================*/
create table logistic_code
(
   id                   bigint(20) not null auto_increment,
   companyCode          varchar(16) not null,
   companyName          varchar(32) not null,
   createTime           timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   updateTime           timestamp default CURRENT_TIMESTAMP,
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=307 DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Table: logistics                                             */
/*==============================================================*/
create table logistics
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   orderId              bigint(20) not null,
   companyName          varchar(64) default NULL comment '物流公司名称',
   shipperCode          varchar(64) not null comment '物流公司编码',
   logisticsNum         varchar(64) not null comment '物流单号',
   freight              int(11) default NULL comment '运费',
   createTime           timestamp not null default '2017-01-01 00:00:00' comment '创建时间',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   primary key (id),
   unique key ORDERID_UNIQUE (orderId)
)
ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='物流信息表';

/*==============================================================*/
/* Table: lucky_draw                                            */
/*==============================================================*/
create table lucky_draw
(
   id                   bigint(20) unsigned not null auto_increment comment '主键',
   shopId               bigint(20) not null comment '店铺id',
   platform             varchar(16) not null comment '平台:PC|APP',
   activityName         varchar(64) not null comment '活动名称',
   startTime            timestamp comment '起始时间',
   endTime              timestamp comment '结束时间',
   freeLotteryTimes     int(11) not null default 0 comment '免费抽奖次数',
   freeDrawType         varchar(32) not null comment '免费抽奖类型:PER_DAY每天,THE_WHOLE_ACTIVITY全程',
   expenditure          int(11) not null comment '积分消费',
   dailyDrawLimit       int(11) not null comment '每日抽奖次数限制',
   appBackground        varchar(255) default NULL comment '客户端背景图片',
   webBackground        varchar(255) default NULL comment 'pc端背景图片',
   isDeleted            tinyint(4) not null default 0 comment '是否删除：0未删除，1已删除',
   activityRules        varchar(1024) default NULL comment '活动规则',
   createTime           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '更新时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8 COMMENT='抽奖活动信息表';

/*==============================================================*/
/* Table: manager                                               */
/*==============================================================*/
create table manager
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   shopId               bigint(20) default NULL comment '店铺id',
   userId               varchar(64) default NULL comment '用户id',
   phone                varchar(32) default NULL comment '联系人',
   roleType             varchar(32) default NULL comment '角色',
   isDeleted            tinyint(1) not null default 0 comment '删除标志',
   createTime           timestamp not null default '2017-01-01 00:00:00' comment '创建时间',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '更新时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='管理员表';

/*==============================================================*/
/* Table: membership_score_daily_details                        */
/*==============================================================*/
create table membership_score_daily_details
(
   id                   bigint(20) not null auto_increment comment '主键',
   userId               varchar(64) not null comment '唯一用户标示',
   accountDay           varchar(12) not null comment '记账日',
   exchangeInNum        bigint(20) not null comment '兑入积分数量',
   consumeNum           bigint(20) not null comment '消费积分数量',
   balance              bigint(20) not null comment '积分结余',
   createTime           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员积分日结明细';

/*==============================================================*/
/* Index: ung_user_id_account_day                               */
/*==============================================================*/
create unique index ung_user_id_account_day on membership_score_daily_details
(
   userId,
   accountDay
);

/*==============================================================*/
/* Table: notice                                                */
/*==============================================================*/
create table notice
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   title                varchar(128) not null comment '标题',
   type                 varchar(16) not null comment '类型',
   content              text not null comment '内容',
   operatorUserId       varchar(64) not null comment '操作人ID',
   isDeleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   createTime           timestamp not null default '2017-01-01 00:00:00' comment '创建时间',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公告表';

/*==============================================================*/
/* Table: order_address                                         */
/*==============================================================*/
create table order_address
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   orderId              bigint(20) not null,
   provinceCode         varchar(32) not null comment '省行政编码',
   cityCode             varchar(32) not null comment '城市行政编码',
   areaCode             varchar(32) default NULL comment '地区行政编码',
   address              varchar(255) not null comment '具体地址',
   receiverName         varchar(16) not null comment '收货人姓名',
   phone                varchar(16) not null comment '联系人手机号',
   postcode             varchar(12) default NULL comment '邮编',
   createTime           timestamp not null default '2017-01-01 00:00:00' comment '创建时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8 COMMENT='订单地址表';

/*==============================================================*/
/* Table: order_locus                                           */
/*==============================================================*/
create table order_locus
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   orderId              bigint(20) not null,
   beforeStatus         tinyint(4) not null comment '变更前状态',
   afterStatus          tinyint(4) not null comment '变更后状态',
   createTime           timestamp not null default '2017-01-01 00:00:00' comment '创建时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='订单轨迹表\r\n';

/*==============================================================*/
/* Table: orders                                                */
/*==============================================================*/
create table orders
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   shopId               bigint(20) not null comment '店铺id',
   userId               varchar(64) not null,
   username             varchar(64) default NULL,
   orderNum             varchar(64) not null comment '订单编号',
   goodsId              bigint(64) not null comment '商品Id',
   goodsVersion         varchar(16) comment '商品版本',
   barcode              varchar(32) not null comment '商品条码',
   goodsNo              varchar(32) default NULL comment '商品货号',
   goodsName            varchar(64) not null comment '商品名称',
   goodsCount           tinyint(4) not null,
   minImg               varchar(128) default NULL,
   orderState           tinyint(4) not null comment '1未发货(已兑换);2已发货;3已完成(已收货);4系统确认收货;5退货',
   orderType            tinyint(4) not null default 1 comment '1实物订单;2虚拟订单',
   source               tinyint(4) not null default 1 comment '1-积分兑换;2-积分抽奖',
   price                int(11) not null comment '单价',
   payment              int(11) not null comment '实际付款价格',
   freight              int(11) default NULL comment '运费',
   version              int(11) not null default 1,
   isDeleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   createTime           timestamp not null default '2017-01-01 00:00:00' comment '创建时间',
   deliveryTime         timestamp default NULL comment '发货时间',
   confirmTime          timestamp default NULL comment '确认收货时间',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   primary key (id),
   unique key ORDERNUM_UNIQUE (orderNum)
)
ENGINE=InnoDB AUTO_INCREMENT=555 DEFAULT CHARSET=utf8 COMMENT='订单表';

/*==============================================================*/
/* Table: orders_extend                                         */
/*==============================================================*/
create table orders_extend
(
   orderId              bigint(20) not null comment '主键',
   orderNum             varchar(64) not null comment '订单编号',
   couponCode           varchar(64) default NULL comment '券码',
   remark               varchar(512) default NULL comment '备注',
   returnTime           timestamp default NULL comment '退货时间',
   createTime           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   primary key (orderId),
   unique key ORDERNUM_UNIQUE (orderNum)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单扩展表';

/*==============================================================*/
/* Table: participation_record                                  */
/*==============================================================*/
create table participation_record
(
   id                   bigint(20) unsigned not null auto_increment comment '主键',
   shopId               bigint(20) not null comment '店铺id',
   userId               varchar(64) not null comment '用户id',
   luckyDrawId          bigint(20) not null comment '抽奖活动id',
   activityName         varchar(64) not null comment '活动名称',
   platform             varchar(16) not null comment '平台:PC|APP',
   drawData             varchar(16) not null comment '抽奖日期,格式:YYYY-MM-DD',
   drawTime             timestamp default CURRENT_TIMESTAMP comment '抽奖时间',
   lotteryPhone         varchar(16) not null comment '抽奖手机号',
   whetherFree          tinyint(4) not null comment '是否免费抽奖:0-非免费 1-免费',
   expenditure          int(11) not null comment '积分消费',
   requestNo            varchar(32) not null comment '请求编号',
   whetherWinning       tinyint(4) not null comment '是否中奖:0-未中奖 1-中奖',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=646 DEFAULT CHARSET=utf8 COMMENT='参与记录信息表';

/*==============================================================*/
/* Table: request_flow                                          */
/*==============================================================*/
create table request_flow
(
   id                   bigint(20) not null comment '主键',
   requester            varchar(64) not null comment '请求发起方',
   responder            varchar(64) not null comment '请求响应方',
   type                 varchar(16) not null comment '类型',
   requestNum           varchar(64) not null comment '请求流水号',
   status               varchar(32) not null comment '状态',
   requestParam         varchar(2048) not null comment '请求参数',
   responseResult       varchar(2048) not null comment '应答',
   requestTime          timestamp not null comment '请求时间',
   remark               varchar(512) comment '备注',
   primary key (id)
);

alter table request_flow comment '请求流水表';

/*==============================================================*/
/* Table: resource                                              */
/*==============================================================*/
create table resource
(
   id                   bigint(20) unsigned not null auto_increment comment '主键ID',
   code                 bigint(20) default NULL comment '权限编码',
   name                 varchar(32),
   url                  varchar(128),
   method               varchar(16),
   parentId             bigint(20) default NULL comment '父节点ID',
   isDeleted            varchar(2) comment '是否删除:0-否,1-是',
   createTime           timestamp not null default CURRENT_TIMESTAMP comment '创建时间,格式yyyy-mm-dd hh:mi:ss',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '最后更新时间,格式yyyy-mm-dd hh:mi:ss',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=452 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='权限表';

/*==============================================================*/
/* Table: role                                                  */
/*==============================================================*/
create table role
(
   id                   bigint(20) unsigned not null auto_increment comment '主键ID',
   name                 varchar(32) comment '名称',
   roleType             varchar(32) comment '角色类型',
   isValid              varchar(2) comment '是否有效:0-否,1-是',
   remark               varchar(1024) comment '备注',
   isDeleted            tinyint(1) comment '是否删除:0-否,1-是',
   create_time          timestamp not null default CURRENT_TIMESTAMP comment '创建时间,格式yyyy-mm-dd hh:mi:ss',
   update_time          timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '最后更新时间,格式yyyy-mm-dd hh:mi:ss',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色表';

/*==============================================================*/
/* Table: role_resource_relation                                */
/*==============================================================*/
create table role_resource_relation
(
   id                   bigint(20) unsigned not null auto_increment comment '主键ID',
   roleId               bigint(20) not null comment '角色id',
   resourceId           bigint(20) not null comment '权限id',
   createOperator       varchar(32) comment '创建操作人',
   createTime           timestamp not null default CURRENT_TIMESTAMP comment '创建时间,格式yyyy-mm-dd hh:mi:ss',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=803 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色权限关系表';

/*==============================================================*/
/* Table: score                                                 */
/*==============================================================*/
create table score
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   userId               varchar(64) not null comment '唯一用户标示',
   type                 varchar(16) not null comment '账户类型',
   source               varchar(32) not null comment '来源系统',
   previousScore        bigint(20) default NULL comment '前一日积分余额',
   score                bigint(20) not null comment '积分',
   previousFreezingScore bigint(20) default NULL comment '前一日积分冻结余额',
   freezingScore        bigint(20) not null comment '冻结积分',
   version              bigint(20) not null comment '版本号，并发乐观锁，初始版本1，更新+1',
   accumulativeScore    bigint(20) not null comment '累计积分获取',
   createTime           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='积分账户表';

/*==============================================================*/
/* Table: score_auth                                            */
/*==============================================================*/
create table score_auth
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   channelCode          varchar(32) not null comment '渠道编码',
   exchangeCurrency     varchar(32) default NULL comment '外币',
   shopId               bigint(20) default NULL comment '店铺id',
   userId               varchar(64) default NULL comment '用户id',
   phone                varchar(32) default NULL comment '联系人',
   contactsUser         varchar(32) default NULL,
   isDeleted            tinyint(1) not null default 0 comment '删除标志',
   createTime           timestamp not null default '2017-01-01 00:00:00' comment '操作时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='积分权限表';

/*==============================================================*/
/* Table: score_change                                          */
/*==============================================================*/
create table score_change
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   userId               varchar(64) not null comment '唯一用户标示',
   shopId               bigint(20) default NULL comment '店铺id',
   userName             varchar(16) not null comment '用户名',
   theOtherSideUserId   varchar(64) default NULL comment '对方用户标示',
   theOtherSideUserName varchar(16) default NULL comment '对方用户名',
   scoreId              bigint(20) not null comment '积分账户id',
   currencyAmount       bigint(20) default NULL comment '外币数量',
   score                bigint(20) not null comment '变更数量',
   scoreBalance         bigint(20) not null comment '积分余额',
   freezingScoreBalance bigint(20) not null comment '冻结积分余额',
   orderNum             varchar(64) not null comment '单据编号',
   channelCode          varchar(32) not null comment '渠道编号',
   businessCode         varchar(32) not null comment '业务编号',
   flowType             varchar(32) not null comment '变更类型(income:收入，expend:支出,freeze:冻结)',
   exchangeCurrency     varchar(32) default NULL comment '兑换外币',
   state                tinyint(1) not null default 0 comment '流水状态，0：正常状态，1：被冲正',
   operationTime        timestamp not null comment '操作时间',
   expirationTime       timestamp comment '该笔变更积分过期时间',
   createTime           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=985 DEFAULT CHARSET=utf8 COMMENT='积分变更表';

/*==============================================================*/
/* Table: score_change_detail                                   */
/*==============================================================*/
create table score_change_detail
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   userId               varchar(64) not null comment '唯一用户标示',
   orderNum             varchar(64) not null comment '单据编号',
   scoreId              bigint(20) not null comment '积分账户id',
   scoreChildId         bigint(20) not null comment '积分子账户id',
   score                bigint(20) not null comment '变更数量',
   scoreBalance         bigint(20) not null comment '积分余额',
   freezingScoreBalance bigint(20) not null comment '冻结积分余额',
   expirationTime       timestamp not null comment '该笔变更积分过期时间',
   flowType             varchar(32) not null comment '变更类型(income:收入，expenditure:支出,freeze:冻结)',
   createTime           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=985 DEFAULT CHARSET=utf8 COMMENT='积分变更明细';

/*==============================================================*/
/* Table: score_child                                           */
/*==============================================================*/
create table score_child
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   scoreId              bigint(20) not null comment '积分账户标示',
   userId               varchar(64) not null comment '唯一用户标示',
   score                bigint(20) not null comment '积分',
   freezingScore        bigint(20) not null comment '冻结积分',
   version              bigint(20) not null comment '版本号，并发乐观锁，初始版本1，更新+1',
   expirationTime       timestamp not null default '2017-01-01 00:00:00' comment '过期时间',
   isDeleted            tinyint(1) not null comment '删除标示',
   createTime           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='积分子表，含有效期处理';

/*==============================================================*/
/* Table: score_converter_flow                                  */
/*==============================================================*/
create table score_converter_flow
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   converterId          bigint(20) not null comment '规则id',
   amount               int(11) not null comment '兑换金额',
   score                int(11) not null comment '积分',
   direction            varchar(32) not null comment '方向:只进不出；只出不进；可进可出(entranceOnly;exitOnly;bothway)',
   personEverydayInLimit bigint(20) default NULL comment '每人每天可兑入限额(可兑换的外币数量)',
   personEverydayOutLimit bigint(20) default NULL comment '每人每天可兑出限额(可兑换的外币数量)',
   channelEverydayInLimit bigint(20) default NULL comment '渠道每天可兑入限额(可兑换的外币数量)',
   channelEverydayOutLimit bigint(20) default NULL comment '渠道每天可兑出限额(可兑换的外币数量)',
   operatedBy           varchar(32) not null comment '操作人',
   operatedTime         timestamp not null default '2017-01-01 00:00:00' comment '操作时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='积分转换规则设置流水';

/*==============================================================*/
/* Table: score_exchange_flow                                   */
/*==============================================================*/
create table score_exchange_flow
(
   id                   bigint(20) not null auto_increment comment '主键',
   orderNum             varchar(32) comment '订单号',
   amount               bigint(11) not null comment '兑换金额',
   score                bigint(11) not null comment '积分',
   direction            varchar(10) not null comment '方向:进；出；(IN;OUT)',
   operatorUserId       varchar(64) not null comment '操作人ID',
   state                varchar(32),
   message              varchar(512),
   createTime           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='积分兑入兑出流水';

/*==============================================================*/
/* Table: score_settlement                                      */
/*==============================================================*/
create table score_settlement
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   scoreId              bigint(20) not null comment '积分账户id',
   dailyBalance         bigint(20) not null comment '日结余额',
   accountDay           varchar(12) not null comment '记账日',
   createTime           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=388 DEFAULT CHARSET=utf8 COMMENT='商家账户积分日结信息表';

/*==============================================================*/
/* Table: score_user                                            */
/*==============================================================*/
create table score_user
(
   id                   bigint(20) not null comment '主键',
   userId               varchar(64) comment '用户Id',
   phone                varchar(16) comment '用户手机号',
   name                 varchar(32) comment '用户姓名',
   isValid              tinyint(1) comment '是否有效:0-无效;1-有效',
   createTime           timestamp default CURRENT_TIMESTAMP comment '创建时间',
   updateTime           timestamp,
   primary key (id)
);

alter table score_user comment '用户表';

/*==============================================================*/
/* Table: settlement                                            */
/*==============================================================*/
create table settlement
(
   id                   bigint(20) not null auto_increment comment '主键',
   shopId               bigint(20) not null comment '业务方ID',
   balance              bigint(20) default NULL comment '余额',
   previousBalance      bigint(20) default NULL comment '前一日余额',
   accountDay           varchar(12) not null comment '会计日',
   billNum              varchar(64) default NULL comment '账单单据号',
   shopName             varchar(64) default NULL comment '所属店铺',
   quantity             int(11) not null comment '订单数量',
   totalAmount          bigint(20) not null comment '商品款',
   totalFreight         bigint(20) default NULL comment '总运费',
   startTime            timestamp not null default '2017-01-01 00:00:00' comment '起始时间',
   endTime              timestamp not null default '2017-01-01 00:00:00' comment '结束时间',
   settlementTime       timestamp default NULL comment '结算时间',
   settlementState      int(11) not null comment '结算状态：0、未结算；1、已结算',
   createTime           timestamp not null default '2017-01-01 00:00:00' comment '创建时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=305 DEFAULT CHARSET=utf8 COMMENT='结算信息表';

/*==============================================================*/
/* Table: shop                                                  */
/*==============================================================*/
create table shop
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   phone                varchar(32) default NULL comment '联系人',
   warnPhone            varchar(32) comment '预警手机号',
   userId               varchar(64) default NULL comment '店铺所有者',
   shopName             varchar(16) not null comment '店铺名称',
   logo                 varchar(255) default NULL comment '店铺logo',
   channelCode          varchar(32) not null comment '渠道',
   servicePhone         varchar(16) default NULL comment '客服电话',
   description          varchar(128) default NULL,
   isDeleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   createTime           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='店铺';

/*==============================================================*/
/* Table: shopwindow                                            */
/*==============================================================*/
create table shopwindow
(
   id                   bigint(20) not null auto_increment comment '主键标示',
   shopId               bigint(20) not null comment '所属店铺',
   imgUrl               varchar(255) not null comment '图片地址',
   linkUrl              varchar(255) default NULL comment '链接地址',
   sort                 int(1) default NULL comment '排序',
   createTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '创建时间',
   updateTime           timestamp default NULL,
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='橱窗表';

/*==============================================================*/
/* Table: user_role_relation                                    */
/*==============================================================*/
create table user_role_relation
(
   id                   bigint(20) unsigned not null auto_increment comment '主键id',
   scoreUserId          varchar(64) comment '积分用户Id',
   userId               varchar(64) comment '用户Id',
   roleId               bigint(20) not null comment '角色id',
   create_time          timestamp not null default CURRENT_TIMESTAMP comment '创建时间,格式yyyy-mm-dd hh:mi:ss',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户角色关系表';

/*==============================================================*/
/* Table: winning_record                                        */
/*==============================================================*/
create table winning_record
(
   id                   bigint(20) unsigned not null auto_increment comment '主键',
   shopId               bigint(20) not null comment '店铺id',
   userId               varchar(64) not null comment '用户id',
   luckyDrawId          bigint(20) not null comment '抽奖活动id',
   activityPrizeId      bigint(20) not null comment '奖品id',
   activityName         varchar(64) not null comment '活动名称',
   platform             varchar(16) not null comment '平台:PC|APP',
   drawData             varchar(16) not null comment '抽奖日期,格式:YYYY-MM-DD',
   drawTime             timestamp default NULL comment '抽奖时间',
   lotteryPhone         varchar(16) not null comment '抽奖手机号',
   whetherFree          tinyint(4) not null comment '是否免费抽奖:0-非免费 1-免费',
   expenditure          int(11) not null comment '积分消费',
   requestNo            varchar(32) not null comment '请求编号',
   prizeName            varchar(64) default NULL comment '奖品名称',
   goodsType            varchar(32) not null comment '1-虚拟;2-实物',
   numberOfPrizes       int(11) not null comment '单次中奖奖品数量',
   prizeType            varchar(32) not null comment '奖品类型 SCORE|TCOIN|GOODS|TKY_FOR_PARTICIPATING',
   goodsId              bigint(20) default NULL comment '商品奖品id',
   goodsNo              varchar(32) default NULL comment '商品货号',
   orderNum             varchar(32) default NULL comment '订单编号',
   winningPhone         varchar(16) not null comment '中奖手机号',
   state                tinyint(4) not null comment '奖品状态:0-未发放1-已发放2-发放失败',
   version              int(11) not null comment '版本号',
   updateTime           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '更新时间',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=504 DEFAULT CHARSET=utf8 COMMENT='中奖记录信息表';

