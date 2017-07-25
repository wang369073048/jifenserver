package org.trc.mq;

import org.springframework.amqp.core.Message;
import org.springframework.amqp.core.MessageListener;

/**
 * Created by hzwzhen on 2017/7/9.
 */
public class RabbitmqService implements MessageListener {


    public void onMessage(Message message) {
        System.out.println("消息消费者 = " + message.toString());
    }
}
