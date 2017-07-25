package org.trc.service.mq;



import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.AmqpException;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.rabbit.support.CorrelationData;

import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


import javax.annotation.Resource;

import java.util.UUID;

/**
 * Created by hzwzhen on 2017/6/19.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/resource-context.xml" })
public  class MqTestCase {
    Logger logger = LoggerFactory.getLogger(MqTestCase.class);
    @Resource
    private RabbitTemplate amqpTemplate;

    /**
     * @Description: 消息队列
     * @Author:
     * @CreateTime:
     */
    @Test
    public void testQueue() {
        try {
            Object object ="11";
            amqpTemplate.convertAndSend("test-key", object,new CorrelationData(UUID.randomUUID().toString().replace("-","")));
        } catch (AmqpException e) {
            logger.error(e.getMessage(), e);
            throw e;
        }
    }


}
