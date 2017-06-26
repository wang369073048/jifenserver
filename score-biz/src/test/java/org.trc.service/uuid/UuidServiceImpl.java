package org.trc.service.uuid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by shenhongxi on 2016/8/12.
 */
public class UuidServiceImpl implements UuidService {

    private static final Logger log = LoggerFactory.getLogger(UuidServiceImpl.class);

    private String  uuidDao;

    @Override
    public String nextUuid(String name) {
        // 日期 + format(nextUuid(name, cacheSize, length))
        return null;
    }

    private synchronized long nextUuid(String name, int cacheSize, int length) {
        UuidModel um = UuidContext.uuidCache.get(name);
        Long nowUuid = null;
        try {
            if (um != null) {
                synchronized (um) {
                    nowUuid = UuidContext.nowCache.get(name);
                    Config cm = UuidContext.getConfig(name);
                    // 判断是否到达预警值
                    if (UuidContext.nowCache.get(name).intValue() == cm.getWarnNum()) {
                        log.warn("警告:" + name + "号段已达到预警值.");
                    }

                    log.info("dbNum:" + UuidContext.endCache.get(name)
                            + ",nowNum:" + UuidContext.nowCache.get(name));
                    // 判断内存中号段是否用完
                    if (UuidContext.nowCache.get(name).compareTo(UuidContext.endCache.get(name)) >= 0) {
                        // 更新号段
                        UuidContext.updateUuid(um, length);

                        nowUuid = um.getStart() + 1;
                        UuidContext.endCache.put(name, um.getEnd());
                        UuidContext.nowCache.put(name, nowUuid);
                    } else {
                        nowUuid += 1;
                        // 是否需要重置 判断自增号位数是否大于length参数
                        if (String.valueOf(nowUuid).length() > length) {
                            // 更新号段，需要重置
                            nowUuid = 1l;
                            UuidContext.updateUuid(um, 0);
                            UuidContext.endCache.put(name, um.getEnd());
                            UuidContext.nowCache.put(name, nowUuid);
                            UuidContext.uuidCache.put(name, um);
                        } else {
                            // 直接修改缓存的值就可以了
                            UuidContext.nowCache.put(name, nowUuid);
                        }
                    }
                }
            } else {
                synchronized (this) {
                    um = UuidContext.uuidCache.get(name);
                    if (um != null) {
                        return nextUuid(name, cacheSize, length);
                    }
                    nowUuid = 1l;

                    // 如果缓存不存在，那么就新增到数据库
                    UuidModel um2 = new UuidModel();
                    um2.setName(name);
                    um2.setStart(0);
                    um2.setEnd(cacheSize);
                    //uuidDao.insert(um2);
                    // 还要同时在缓存的map中加入
                    UuidContext.endCache.put(name, um2.getEnd());
                    UuidContext.nowCache.put(name, nowUuid);
                    UuidContext.uuidCache.put(name, um2);
                }
            }
        } catch (Exception e) {
            log.error("生成uuid error", e);
            if (e.getMessage() != null && (e.getMessage().indexOf("UNIQUE KEY") >= 0 ||
                    e.getMessage().indexOf("PRIMARY KEY") >= 0)) {
                UuidModel _um = new UuidModel();
                _um.setName(name);
                // 更新号段
                UuidContext.updateUuid(_um, length);
                // 载入缓存
                UuidContext.loadMemory(_um);
                // 继续获取
                return nextUuid(name, cacheSize, length);
            }
            throw new RuntimeException("生成uuid error");
        }

        return nowUuid;
    }

}

