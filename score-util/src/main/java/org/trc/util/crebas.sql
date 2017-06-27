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

drop index unq_user_id_account_day on membership_score_daily_details;

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
   activity_prizes_id                   bigint(20) unsigned not null auto_increment comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   shop_id               bigint(20) not null comment '店铺id',
   lucky_draw_id          bigint(20) not null comment '抽奖活动id',
   goods_id              bigint(20) default NULL comment '奖品id',
   prize_type            varchar(32) not null comment '奖品类型 SCORE|TCOIN|GOODS',
   goods_type            varchar(32) not null comment '1-虚拟;2-实物;3-谢谢参与',
   prize_url             varchar(255) not null comment '奖品图片',
   name                 varchar(64) not null comment '奖品名称',
   number_of_prizes       int(11) default NULL comment '单次中奖奖品数量',
   winning_limit         int(11) default NULL comment '用户中奖次数限制',
   winning_times         int(11) default NULL comment '中奖次数限制',
   winning_type          varchar(32) default NULL comment '中奖次数限制类型:PER_DAY每天,THE_WHOLE_ACTIVITY全程',
   winning_probability   int(11) not null comment '中奖几率:单位/万分之一',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (activity_prizes_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='活动奖品信息表';

/*==============================================================*/
/* Table: address                                               */
/*==============================================================*/
create table address
(
   address_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   user_id               varchar(64) not null comment '用户ID',
   province_code         varchar(32) not null comment '省行政编码',
   city_code             varchar(32) not null comment '城市行政编码',
   district_code         varchar(32) default NULL comment '地区行政编码',
   address              varchar(255) not null comment '具体地址',
   receiver_name         varchar(16) not null comment '收货人姓名',
   phone                varchar(16) not null comment '联系人手机号',
   postcode             varchar(12) default NULL comment '邮编',
   is_default            tinyint(1) not null comment '0 非默认 ;1 默认',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (address_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='地址表';

/*==============================================================*/
/* Table: area                                                  */
/*==============================================================*/
create table area
(
   area_id                   bigint(20) not null auto_increment comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   code                 varchar(40) not null,
   province             varchar(40) not null,
   city                 varchar(40) not null,
   district             varchar(40) not null,
   parent               bigint(20) not null,
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (area_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='省市区表';

/*==============================================================*/
/* Table: banner                                                */
/*==============================================================*/
create table banner
(
   banner_id                   bigint(20) not null auto_increment comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   shop_id               bigint(20) not null comment '业务方ID',
   name                 varchar(64) not null comment '名称',
   type                 varchar(32) not null comment '类型: PC|APP',
   content_id            bigint(20) default NULL comment 'Banner内容ID',
   is_up                 tinyint(1) default NULL comment '是否上架,0上架,1下架',
   auto_enable_time       timestamp comment '自动生效时间',
   auto_disabled_time     timestamp comment '自动失效时间',
   sort                 int(11) default NULL comment '排序',
   description          varchar(128) default NULL,
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (banner_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='banner表';

/*==============================================================*/
/* Table: banner_content                                        */
/*==============================================================*/
create table banner_content
(
   banner_content_id                   bigint(20) not null auto_increment comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   shop_id               bigint(20) not null comment '业务方ID',
   title                varchar(64) not null comment '标题',
   type                 varchar(32) not null comment '类型: PC|APP',
   picture_url           varchar(128) not null comment '图片url',
   target_url            varchar(128) not null comment '跳转url',
   description          varchar(128) not null comment '备注',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (banner_content_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='banner内容页';

/*==============================================================*/
/* Table: barrage                                               */
/*==============================================================*/
create table barrage
(
   barrage_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   shop_id               bigint(20) not null comment '商品所属店铺',
   order_id              bigint(20) not null comment '商品名称',
   user_id               varchar(64) not null,
   avatar               varchar(128) default NULL comment '头像',
   phone                varchar(32) default NULL comment '联系人手机号(带*的)',
   original_phone        varchar(32) default NULL comment '原手机号(不带*的)',
   goods_name            varchar(64) default NULL comment '商品名称',
   content              text comment '内容',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (barrage_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='弹幕表';

/*==============================================================*/
/* Table: card_coupons                                          */
/*==============================================================*/
create table card_coupons
(
   card_coupons_id                   bigint(20) not null auto_increment comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   shop_id               bigint(20) not null comment '店铺id',
   coupon_name           varchar(64) not null comment '卡券名称',
   remark               varchar(256) default NULL comment '备注',
   batch_number          varchar(32) not null comment '批次号',
   stock                int(11) not null comment '库存',
   version              bigint(20) not null comment '版本号，并发乐观锁，初始版本1，更新+1',
   valid_start_time       timestamp default NULL comment '有效开始日期',
   valid_end_time         timestamp default NULL comment '有效结束日期',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (card_coupons_id),
   unique key unq_batch_number (batch_number)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='卡券信息表';

/*==============================================================*/
/* Table: card_item                                             */
/*==============================================================*/
create table card_item
(
   card_item_id                   bigint(20) unsigned not null auto_increment comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   shop_id               bigint(20) not null comment '店铺id',
   batch_number          varchar(32) not null comment '批次号',
   code                 varchar(32) not null comment '券码',
   state                int(11) not null comment '状态(0:未发放，1:已发放)',
   user_id               varchar(64) default NULL comment '用户id',
   order_num             varchar(64) default NULL,
   release_time          timestamp default NULL comment '发放时间',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (card_item_id),
   unique key unq_code (code)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='卡券明细表';

/*==============================================================*/
/* Table: card_item_abandoned                                   */
/*==============================================================*/
create table card_item_abandoned
(
   card_item_abandoned_id                   bigint(20) unsigned not null auto_increment comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   shop_id               bigint(20) not null comment '店铺id',
   batch_number          varchar(32) not null comment '批次号',
   code                 varchar(32) not null comment '券码',
   state                int(11) not null comment '状态(0:未发放，1:已发放)',
   abandoned_time        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '废弃时间',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (card_item_abandoned_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='废弃卡券明细表';

alter table card_item_abandoned comment '废弃卡券明细表';

/*==============================================================*/
/* Table: category                                              */
/*==============================================================*/
create table category
(
   category_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   pid                  bigint(20) default NULL,
   code                 varchar(32) default NULL comment '编码',
   category_name         varchar(16) not null comment '类目名称',
   is_virtual            tinyint(4) not null comment '1虚拟类目;2实物类目',
   allow_updates         tinyint(1) not null comment '0 不允许 ;1 允许',
   picture_url           varchar(255) not null comment 'LOGO地址',
   sort                 int(11) default NULL comment '排序',
   description          varchar(255) default NULL comment '备注',
   operator_user_id       varchar(64) not null comment '操作人ID',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (category_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='类目表';

/*==============================================================*/
/* Table: consumption_summary                                   */
/*==============================================================*/
create table consumption_summary
(
   consumption_summary_id                   bigint(20) not null auto_increment comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   user_id               varchar(64) not null comment '唯一用户标示',
   account_day           varchar(12) not null comment '记账日',
   shop_id               bigint(20) default NULL comment '店铺id',
   phone                varchar(16) not null comment '会员手机号',
   exchange_in_num        bigint(20) not null comment '兑入积分数量',
   consume_num           bigint(20) not null comment '消费积分数量',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (consumption_summary_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='消费汇总';

/*==============================================================*/
/* Index: unq_user_id_account_day_shop_id                       */
/*==============================================================*/
create unique index unq_user_id_account_day_shop_id on consumption_summary
(
   user_id,
   account_day,
   shop_id
);

/*==============================================================*/
/* Table: exchange_rate                                         */
/*==============================================================*/
create table exchange_rate
(
   exchange_rate_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   currency             varchar(32) comment '兑换币种',
   shop_id               bigint(20) default NULL comment '店铺id',
   channel_code          varchar(32) not null comment '渠道编码',
   amount               int(11) not null comment '兑换金额',
   score                int(11) not null comment '积分',
   direction            varchar(32) not null comment '方向:只进不出；只出不进；可进可出(entranceOnly;exitOnly;bothway)',
   person_everyday_in_limit bigint(20) default NULL comment '每人每天可兑入限额（可兑换的外币数量）',
   person_everyday_out_limit bigint(20) default NULL comment '每人每天可兑出限额（可兑换的外币数量）',
   channel_everyday_in_limit bigint(20) default NULL comment '渠道每天可兑入限额（可兑换的外币数量）',
   channel_everyday_out_limit bigint(20) default NULL comment '渠道每天可兑出限额（可兑换的外币数量）',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (exchange_rate_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='积分转换';

/*==============================================================*/
/* Table: exchange_rate_history                                 */
/*==============================================================*/
create table exchange_rate_history
(
   exchange_rate_history_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   currency             varchar(32) comment '兑换币种',
   shop_id               bigint(20) default NULL comment '店铺id',
   channel_code          varchar(32) not null comment '渠道编码',
   amount               int(11) not null comment '兑换金额',
   score                int(11) not null comment '积分',
   direction            varchar(32) not null comment '方向:只进不出；只出不进；可进可出(entranceOnly;exitOnly;bothway)',
   person_everyday_in_limit bigint(20) default NULL comment '每人每天可兑入限额（可兑换的外币数量）',
   person_everyday_out_limit bigint(20) default NULL comment '每人每天可兑出限额（可兑换的外币数量）',
   channel_everyday_in_limit bigint(20) default NULL comment '渠道每天可兑入限额（可兑换的外币数量）',
   channel_everyday_out_limit bigint(20) default NULL comment '渠道每天可兑出限额（可兑换的外币数量）',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (exchange_rate_history_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='积分转换';

/*==============================================================*/
/* Table: goods                                                 */
/*==============================================================*/
create table goods
(
   goods_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   shop_id               bigint(20) not null comment '商品所属店铺',
   category             bigint(20) not null comment '所属类目',
   brand_name            varchar(16) default NULL comment '品牌名称',
   goods_name            varchar(64) not null comment '商品名称',
   barcode              varchar(32) not null comment '商品条码',
   goods_no              varchar(32) default NULL comment '商品货号',
   batch_number          varchar(32) default NULL comment '虚拟商品批次号',
   goods_sn              varchar(32) not null comment '商品编号',
   main_img              varchar(128) not null comment '商品主图',
   medium_img            varchar(1024) default NULL comment '附属图片(json格式)',
   price_market          int(11) default NULL comment '市场价',
   price_score           int(11) not null default 0 comment '积分兑换价格',
   target_url            varchar(255) default NULL comment '商品链接',
   stock                int(11) not null default 0 comment '库存',
   stock_warn            int(11) default NULL comment '警报库存',
   exchange_quantity     int(11) not null default 0 comment '兑换数量',
   virtual_exchange_quantity int(11) not null default 0 comment '虚拟兑换量',
   is_up                 tinyint(1) default NULL comment '是否上架.1上架,0下架',
   content              mediumtext comment '商品详情介绍',
   version              int(11) not null default 1,
   whether_prizes        tinyint(4) not null default 0 comment '0-非奖品;1-奖品',
   valid_start_time       timestamp default NULL comment '有效开始日期',
   valid_end_time         timestamp default NULL comment '有效结束日期',
   auto_up_time           timestamp default NULL comment '自动上架日期',
   auto_down_time         timestamp default NULL comment '自动下架日期',
   up_time               timestamp default NULL comment '上架时间',
   snapshot_time         timestamp not null default '2017-01-01 00:00:00' comment '快照时间',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (goods_id),
   unique key unq_goods_sn (goods_sn),
   unique key unq_shop_id_barcode (shop_id, barcode)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='商品表';

/*==============================================================*/
/* Table: goods_recommend                                       */
/*==============================================================*/
create table goods_recommend
(
   goods_recommend_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   shop_id               bigint(20) not null comment '店铺ID',
   goods_id              bigint(20) not null comment '商品ID',
   sort                 int(11) default NULL comment '排序',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (goods_recommend_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='商品推荐表';

/*==============================================================*/
/* Table: goods_snapshot                                        */
/*==============================================================*/
create table goods_snapshot
(
   goods_snapshot_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   goods_id              bigint(20) not null comment '商品id',
   shop_id               bigint(20) not null comment '商品所属店铺',
   bar_code              varchar(32),
   category             bigint(20) not null comment '所属类目',
   brand_name            varchar(16) default NULL comment '品牌名称',
   goods_name            varchar(64) not null comment '商品名称',
   batch_number          varchar(32) default NULL comment '虚拟商品批次号',
   goods_no              varchar(32) comment '商品货号',
   goods_sn              varchar(32) not null comment '商品编号',
   main_img              varchar(128) not null comment '商品主图',
   medium_img            varchar(1024) default NULL comment '附属图片(json格式)',
   price_market          int(11) default NULL comment '市场价',
   price_score           int(11) not null default 0 comment '积分兑换价格',
   target_url            varchar(255) default NULL comment '商品链接',
   is_up                 tinyint(1) comment '上下架:0,下架1,上架',
   content              mediumtext comment '商品详情介绍',
   version              int(11) not null comment '商品版本 ',
   whether_prizes        tinyint(1) comment '是否是奖品,0:不是,1:是',
   valid_start_time       timestamp default NULL comment '有效开始日期',
   valid_end_time         timestamp default NULL comment '有效结束日期',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (goods_snapshot_id),
   unique key unq_goods_id_version (goods_id, version)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Table: log_information                                       */
/*==============================================================*/
create table log_information
(
   log_information_id                   bigint(20) not null auto_increment comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   entity_type           varchar(16) not null,
   entity_id             varchar(64) not null,
   operation            varchar(32) not null comment '操作类型',
   operator_userid       varchar(64) not null comment '操作人userId',
   operator             varchar(64) comment '操作人',
   params               varchar(2048) comment '内容',
   remark               varchar(512) comment '备注',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (log_information_id)
   unique key unq_uuid (uuid)
);

alter table log_information comment '日志信息表';

/*==============================================================*/
/* Table: logistic_code                                         */
/*==============================================================*/
create table logistic_code
(
   logistic_code_id                   bigint(20) not null auto_increment comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   company_code          varchar(16) not null,
   company_name          varchar(32) not null,
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (logistic_code_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Table: logistics                                             */
/*==============================================================*/
create table logistics
(
   logistics_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   order_id              bigint(20) not null,
   company_name          varchar(64) default NULL comment '物流公司名称',
   shipper_code          varchar(64) not null comment '物流公司编码',
   logistics_num         varchar(64) not null comment '物流单号',
   freight              int(11) default NULL comment '运费',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (logistics_id),
   unique key unq_order_id (order_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='物流信息表';

/*==============================================================*/
/* Table: lucky_draw                                            */
/*==============================================================*/
create table lucky_draw
(
   lucky_draw_id                   bigint(20) unsigned not null auto_increment comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   shop_id               bigint(20) not null comment '店铺id',
   platform             varchar(16) not null comment '平台:PC|APP',
   activity_name         varchar(64) not null comment '活动名称',
   start_time            timestamp comment '起始时间',
   end_time              timestamp comment '结束时间',
   free_lottery_times     int(11) not null default 0 comment '免费抽奖次数',
   free_draw_type         varchar(32) not null comment '免费抽奖类型:PER_DAY每天,THE_WHOLE_ACTIVITY全程',
   expenditure          int(11) not null comment '积分消费',
   daily_draw_limit       int(11) not null comment '每日抽奖次数限制',
   app_background        varchar(255) default NULL comment '客户端背景图片',
   web_background        varchar(255) default NULL comment 'pc端背景图片',
   activity_rules        varchar(1024) default NULL comment '活动规则',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (lucky_draw_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='抽奖活动信息表';

/*==============================================================*/
/* Table: manager                                               */
/*==============================================================*/
create table manager
(
   manager_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   shop_id               bigint(20) default NULL comment '店铺id',
   user_id               varchar(64) default NULL comment '用户id',
   phone                varchar(32) default NULL comment '联系人',
   role_type             varchar(32) default NULL comment '角色',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (manager_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='管理员表';

/*==============================================================*/
/* Table: membership_score_daily_details                        */
/*==============================================================*/
create table membership_score_daily_details
(
   membership_score_daily_details_id                   bigint(20) not null auto_increment comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   user_id               varchar(64) not null comment '唯一用户标示',
   account_day           varchar(12) not null comment '记账日',
   exchange_in_num        bigint(20) not null comment '兑入积分数量',
   consume_num           bigint(20) not null comment '消费积分数量',
   balance              bigint(20) not null comment '积分结余',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (membership_score_daily_details_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员积分日结明细';

/*==============================================================*/
/* Index: unq_user_id_account_day                               */
/*==============================================================*/
create unique index unq_user_id_account_day on membership_score_daily_details
(
   user_id,
   account_day
);

/*==============================================================*/
/* Table: notice                                                */
/*==============================================================*/
create table notice
(
   notice_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   title                varchar(128) not null comment '标题',
   type                 varchar(16) not null comment '类型',
   content              text not null comment '内容',
   operator_user_id       varchar(64) not null comment '操作人ID',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (notice_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公告表';

/*==============================================================*/
/* Table: order_address                                         */
/*==============================================================*/
create table order_address
(
   order_address_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   order_id              bigint(20) not null,
   province_code         varchar(32) not null comment '省行政编码',
   city_code             varchar(32) not null comment '城市行政编码',
   area_code             varchar(32) default NULL comment '地区行政编码',
   address              varchar(255) not null comment '具体地址',
   receiver_name         varchar(16) not null comment '收货人姓名',
   phone                varchar(16) not null comment '联系人手机号',
   postcode             varchar(12) default NULL comment '邮编',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (order_address_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='订单地址表';

/*==============================================================*/
/* Table: order_locus                                           */
/*==============================================================*/
create table order_locus
(
   order_locus_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   order_id              bigint(20) not null,
   before_status         tinyint(4) not null comment '变更前状态',
   after_status          tinyint(4) not null comment '变更后状态',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (order_locus_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='订单轨迹表\r\n';

/*==============================================================*/
/* Table: orders                                                */
/*==============================================================*/
create table orders
(
   orders_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   shop_id               bigint(20) not null comment '店铺id',
   user_id               varchar(64) not null,
   username             varchar(64) default NULL,
   order_num             varchar(64) not null comment '订单编号',
   goods_id              bigint(64) not null comment '商品Id',
   goods_version         varchar(16) comment '商品版本',
   barcode              varchar(32) not null comment '商品条码',
   goods_no              varchar(32) default NULL comment '商品货号',
   goods_name            varchar(64) not null comment '商品名称',
   goods_count           tinyint(4) not null,
   min_img               varchar(128) default NULL,
   order_state           tinyint(4) not null comment '1未发货(已兑换);2已发货;3已完成(已收货);4系统确认收货;5退货',
   order_type            tinyint(4) not null default 1 comment '1实物订单;2虚拟订单',
   source               tinyint(4) not null default 1 comment '1-积分兑换;2-积分抽奖',
   price                int(11) not null comment '单价',
   payment              int(11) not null comment '实际付款价格',
   freight              int(11) default NULL comment '运费',
   version              int(11) not null default 1,
   delivery_time         timestamp default NULL comment '发货时间',
   confirm_time          timestamp default NULL comment '确认收货时间',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (orders_id),
   unique key unq_order_num (order_num)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='订单表';

/*==============================================================*/
/* Table: orders_extend                                         */
/*==============================================================*/
create table orders_extend
(
   order_id              bigint(20) not null comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   order_num             varchar(64) not null comment '订单编号',
   coupon_code           varchar(64) default NULL comment '券码',
   remark               varchar(512) default NULL comment '备注',
   return_time           timestamp default NULL comment '退货时间',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (order_id),
   unique key unq_order_num (order_num)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单扩展表';

/*==============================================================*/
/* Table: participation_record                                  */
/*==============================================================*/
create table participation_record
(
   participation_record_id                   bigint(20) unsigned not null auto_increment comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   shop_id               bigint(20) not null comment '店铺id',
   user_id               varchar(64) not null comment '用户id',
   lucky_draw_id          bigint(20) not null comment '抽奖活动id',
   activity_name         varchar(64) not null comment '活动名称',
   platform             varchar(16) not null comment '平台:PC|APP',
   draw_data             varchar(16) not null comment '抽奖日期,格式:YYYY-MM-DD',
   draw_time             timestamp default CURRENT_TIMESTAMP comment '抽奖时间',
   lottery_phone         varchar(16) not null comment '抽奖手机号',
   whether_free          tinyint(4) not null comment '是否免费抽奖:0-非免费 1-免费',
   expenditure          int(11) not null comment '积分消费',
   request_no            varchar(32) not null comment '请求编号',
   whether_winning       tinyint(4) not null comment '是否中奖:0-未中奖 1-中奖',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (participation_record_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='参与记录信息表';

/*==============================================================*/
/* Table: request_flow                                          */
/*==============================================================*/
create table request_flow
(
   request_flow_id                   bigint(20) unsigned not null auto_increment comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   requester            varchar(64) not null comment '请求发起方',
   responder            varchar(64) not null comment '请求响应方',
   type                 varchar(16) not null comment '类型',
   request_num           varchar(64) not null comment '请求流水号',
   status               varchar(32) not null comment '状态',
   request_param         varchar(2048) not null comment '请求参数',
   response_result       varchar(2048) not null comment '应答',
   request_time          timestamp not null comment '请求时间',
   remark               varchar(512) comment '备注',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (request_flow_id)
   unique key unq_uuid (uuid)
);

alter table request_flow comment '请求流水表';

/*==============================================================*/
/* Table: resource                                              */
/*==============================================================*/
create table resource
(
   resource_id                   bigint(20) unsigned not null auto_increment comment '主键ID',
   uuid                  varchar(64) not null comment 'uuid',
   code                 bigint(20) default NULL comment '权限编码',
   name                 varchar(32),
   url                  varchar(128),
   method               varchar(16),
   parent_id             bigint(20) default NULL comment '父节点ID',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (resource_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='权限表';

/*==============================================================*/
/* Table: role                                                  */
/*==============================================================*/
create table role
(
   role_id                   bigint(20) unsigned not null auto_increment comment '主键ID',
   uuid                  varchar(64) not null comment 'uuid',
   name                 varchar(32) comment '名称',
   role_type             varchar(32) comment '角色类型',
   is_valid              varchar(2) comment '是否有效:0-否,1-是',
   remark               varchar(1024) comment '备注',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (role_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色表';

/*==============================================================*/
/* Table: role_resource_relation                                */
/*==============================================================*/
create table role_resource_relation
(
   role_resource_relation_id                   bigint(20) unsigned not null auto_increment comment '主键ID',
   uuid                  varchar(64) not null comment 'uuid',
   role_id               bigint(20) not null comment '角色id',
   resource_id           bigint(20) not null comment '权限id',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (role_resource_relation_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色权限关系表';

/*==============================================================*/
/* Table: score                                                 */
/*==============================================================*/
create table score
(
   score_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   user_id               varchar(64) not null comment '唯一用户标示',
   type                 varchar(16) not null comment '账户类型',
   source               varchar(32) not null comment '来源系统',
   previous_score        bigint(20) default NULL comment '前一日积分余额',
   score                bigint(20) not null comment '积分',
   previous_freezing_score bigint(20) default NULL comment '前一日积分冻结余额',
   freezing_score        bigint(20) not null comment '冻结积分',
   version              bigint(20) not null comment '版本号，并发乐观锁，初始版本1，更新+1',
   accumulative_score    bigint(20) not null comment '累计积分获取',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (score_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='积分账户表';

/*==============================================================*/
/* Table: score_auth                                            */
/*==============================================================*/
create table score_auth
(
   score_auth_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   channel_code          varchar(32) not null comment '渠道编码',
   exchange_currency     varchar(32) default NULL comment '外币',
   shop_id               bigint(20) default NULL comment '店铺id',
   user_id               varchar(64) default NULL comment '用户id',
   phone                varchar(32) default NULL comment '联系人',
   contacts_user         varchar(32) default NULL,
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (score_auth_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='积分权限表';

/*==============================================================*/
/* Table: score_change                                          */
/*==============================================================*/
create table score_change
(
   score_change_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   user_id               varchar(64) not null comment '唯一用户标示',
   shop_id               bigint(20) default NULL comment '店铺id',
   user_name             varchar(16) not null comment '用户名',
   the_other_side_user_id   varchar(64) default NULL comment '对方用户标示',
   the_other_side_user_name varchar(16) default NULL comment '对方用户名',
   score_id              bigint(20) not null comment '积分账户id',
   currency_amount       bigint(20) default NULL comment '外币数量',
   score                bigint(20) not null comment '变更数量',
   score_balance         bigint(20) not null comment '积分余额',
   freezing_score_balance bigint(20) not null comment '冻结积分余额',
   order_num             varchar(64) not null comment '单据编号',
   channel_code          varchar(32) not null comment '渠道编号',
   business_code         varchar(32) not null comment '业务编号',
   flow_type             varchar(32) not null comment '变更类型(income:收入，expend:支出,freeze:冻结)',
   exchange_currency     varchar(32) default NULL comment '兑换外币',
   state                tinyint(1) not null default 0 comment '流水状态，0：正常状态，1：被冲正',
   operation_time        timestamp not null comment '操作时间',
   expiration_time       timestamp comment '该笔变更积分过期时间',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (score_change_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='积分变更表';

/*==============================================================*/
/* Table: score_change_detail                                   */
/*==============================================================*/
create table score_change_detail
(
   score_change_detail_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   user_id               varchar(64) not null comment '唯一用户标示',
   order_num             varchar(64) not null comment '单据编号',
   score_id              bigint(20) not null comment '积分账户id',
   score_child_id         bigint(20) not null comment '积分子账户id',
   score                bigint(20) not null comment '变更数量',
   score_balance         bigint(20) not null comment '积分余额',
   freezing_score_balance bigint(20) not null comment '冻结积分余额',
   expiration_time       timestamp not null comment '该笔变更积分过期时间',
   flow_type             varchar(32) not null comment '变更类型(income:收入，expenditure:支出,freeze:冻结)',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (score_change_detail_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='积分变更明细';

/*==============================================================*/
/* Table: score_child                                           */
/*==============================================================*/
create table score_child
(
   score_child_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   score_id              bigint(20) not null comment '积分账户标示',
   user_id               varchar(64) not null comment '唯一用户标示',
   score                bigint(20) not null comment '积分',
   freezing_score        bigint(20) not null comment '冻结积分',
   version              bigint(20) not null comment '版本号，并发乐观锁，初始版本1，更新+1',
   expiration_time       timestamp not null default '2017-01-01 00:00:00' comment '过期时间',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (score_child_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='积分子表，含有效期处理';

/*==============================================================*/
/* Table: score_converter_flow                                  */
/*==============================================================*/
create table score_converter_flow
(
   score_converter_flow_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   converter_id          bigint(20) not null comment '规则id',
   amount               int(11) not null comment '兑换金额',
   score                int(11) not null comment '积分',
   direction            varchar(32) not null comment '方向:只进不出；只出不进；可进可出(entranceOnly;exitOnly;bothway)',
   person_everyday_in_limit bigint(20) default NULL comment '每人每天可兑入限额(可兑换的外币数量)',
   person_everyday_out_limit bigint(20) default NULL comment '每人每天可兑出限额(可兑换的外币数量)',
   channel_everyday_in_limit bigint(20) default NULL comment '渠道每天可兑入限额(可兑换的外币数量)',
   channel_everyday_out_limit bigint(20) default NULL comment '渠道每天可兑出限额(可兑换的外币数量)',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (score_converter_flow_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='积分转换规则设置流水';

/*==============================================================*/
/* Table: score_exchange_flow                                   */
/*==============================================================*/
create table score_exchange_flow
(
   score_exchange_flow_id                   bigint(20) not null auto_increment comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   order_num             varchar(32) comment '订单号',
   amount               bigint(11) not null comment '兑换金额',
   score                bigint(11) not null comment '积分',
   direction            varchar(10) not null comment '方向:进；出；(IN;OUT)',
   operator_user_id       varchar(64) not null comment '操作人ID',
   state                varchar(32),
   message              varchar(512),
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (score_exchange_flow_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='积分兑入兑出流水';

/*==============================================================*/
/* Table: score_settlement                                      */
/*==============================================================*/
create table score_settlement
(
   score_settlement_id                   bigint(20) not null auto_increment comment '主键标示',
   uuid                  varchar(64) not null comment 'uuid',
   score_id              bigint(20) not null comment '积分账户id',
   daily_balance         bigint(20) not null comment '日结余额',
   account_day           varchar(12) not null comment '记账日',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (score_settlement_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='商家账户积分日结信息表';

/*==============================================================*/
/* Table: score_user                                            */
/*==============================================================*/
create table score_user
(
   score_user_id                   bigint(20) not null auto_increment comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   user_id               varchar(64) comment '用户Id',
   phone                varchar(16) comment '用户手机号',
   name                 varchar(32) comment '用户姓名',
   is_valid              tinyint(1) comment '是否有效:0-无效;1-有效',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (score_user_id)
   unique key unq_uuid (uuid)
);

alter table score_user comment '用户表';

/*==============================================================*/
/* Table: settlement                                            */
/*==============================================================*/
create table settlement
(
   settlement_id                   bigint(20) not null auto_increment comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   shop_id               bigint(20) not null comment '业务方ID',
   balance              bigint(20) default NULL comment '余额',
   previous_balance      bigint(20) default NULL comment '前一日余额',
   account_day           varchar(12) not null comment '会计日',
   bill_num              varchar(64) default NULL comment '账单单据号',
   shop_name             varchar(64) default NULL comment '所属店铺',
   quantity             int(11) not null comment '订单数量',
   total_amount          bigint(20) not null comment '商品款',
   total_freight         bigint(20) default NULL comment '总运费',
   start_time            timestamp not null default '2017-01-01 00:00:00' comment '起始时间',
   end_time              timestamp not null default '2017-01-01 00:00:00' comment '结束时间',
   settlement_time       timestamp default NULL comment '结算时间',
   settlement_state      int(11) not null comment '结算状态：0、未结算；1、已结算',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (settlement_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='结算信息表';

/*==============================================================*/
/* Table: shop                                                  */
/*==============================================================*/
create table shop
(
   shop_id                   bigint(20) unsigned not null auto_increment comment '主键id',
   uuid                  varchar(64) not null comment 'uuid',
   phone                varchar(32) default NULL comment '联系人',
   warn_phone            varchar(32) comment '预警手机号',
   user_id               varchar(64) default NULL comment '店铺所有者',
   shop_name             varchar(16) not null comment '店铺名称',
   logo                 varchar(255) default NULL comment '店铺logo',
   channel_code          varchar(32) not null comment '渠道',
   service_phone         varchar(16) default NULL comment '客服电话',
   description          varchar(128) default NULL,
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (shop_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='店铺';

/*==============================================================*/
/* Table: shopwindow                                            */
/*==============================================================*/
create table shopwindow
(
   shopwindow_id                   bigint(20) unsigned not null auto_increment comment '主键id',
   uuid                  varchar(64) not null comment 'uuid',
   shop_id               bigint(20) not null comment '所属店铺',
   img_url               varchar(255) not null comment '图片地址',
   link_url              varchar(255) default NULL comment '链接地址',
   sort                 int(1) default NULL comment '排序',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (shopwindow_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='橱窗表';

/*==============================================================*/
/* Table: user_role_relation                                    */
/*==============================================================*/
create table user_role_relation
(
   user_role_relation_id                   bigint(20) unsigned not null auto_increment comment '主键id',
   uuid                  varchar(64) not null comment 'uuid',
   score_user_id          varchar(64) comment '积分用户Id',
   user_id               varchar(64) comment '用户Id',
   role_id               bigint(20) not null comment '角色id',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (user_role_relation_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户角色关系表';

/*==============================================================*/
/* Table: winning_record                                        */
/*==============================================================*/
create table winning_record
(
   winning_record_id                   bigint(20) unsigned not null auto_increment comment '主键',
   uuid                  varchar(64) not null comment 'uuid',
   shop_id               bigint(20) not null comment '店铺id',
   user_id               varchar(64) not null comment '用户id',
   lucky_draw_id          bigint(20) not null comment '抽奖活动id',
   activity_prize_id      bigint(20) not null comment '奖品id',
   activity_name         varchar(64) not null comment '活动名称',
   platform             varchar(16) not null comment '平台:PC|APP',
   draw_data             varchar(16) not null comment '抽奖日期,格式:YYYY-MM-DD',
   draw_time             timestamp default NULL comment '抽奖时间',
   lottery_phone         varchar(16) not null comment '抽奖手机号',
   whether_free          tinyint(4) not null comment '是否免费抽奖:0-非免费 1-免费',
   expenditure          int(11) not null comment '积分消费',
   request_no            varchar(32) not null comment '请求编号',
   prize_name            varchar(64) default NULL comment '奖品名称',
   goods_type            varchar(32) not null comment '1-虚拟;2-实物',
   number_of_prizes       int(11) not null comment '单次中奖奖品数量',
   prize_type            varchar(32) not null comment '奖品类型 SCORE|TCOIN|GOODS|TKY_FOR_PARTICIPATING',
   goods_id              bigint(20) default NULL comment '商品奖品id',
   goods_no              varchar(32) default NULL comment '商品货号',
   order_num             varchar(32) default NULL comment '订单编号',
   winning_phone         varchar(16) not null comment '中奖手机号',
   state                tinyint(4) not null comment '奖品状态:0-未发放1-已发放2-发放失败',
   version              int(11) not null comment '版本号',
   is_deleted            tinyint(1) not null comment '0 正常 ;1 已删除',
   create_time           timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
   create_by             varchar(64) default NULL comment '创建人',
   update_time           timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   update_by             varchar(64) default NULL comment '修改人',
   primary key (winning_record_id)
   unique key unq_uuid (uuid)
)
ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='中奖记录信息表';

