package org.trc.mq;

import com.rabbitmq.client.Channel;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.core.ChannelAwareMessageListener;
import org.springframework.stereotype.Service;



/**
 * Created by hzlbo on 2016/7/14.
 */
@Service(value = "queueListenter")
public class QueueListenter implements ChannelAwareMessageListener {

    public Logger logger = LoggerFactory.getLogger(this.getClass());
    /**
     * @param message the received AMQP message (never <code>null</code>)
     * @param channel the underlying Rabbit Channel (never <code>null</code>)
     * @throws Exception
     */

//    @Resource
//    private BusinessSNService businessSNService;

    @Override
    public void onMessage(Message message, Channel channel) throws Exception {
        System.out.println("11111111");

//        try {
//            SerializerMessageConverter serializerMessageConverter = new SerializerMessageConverter();
//            BusinessSNDO businessSNDO = (BusinessSNDO) serializerMessageConverter.fromMessage(message);
//            if (businessSNDO != null) {
//                boolean result = businessSNService.addSN(businessSNDO);
//                if (!result) {
//                    logger.error("消息消费失败 业务号码={}",businessSNDO.getId());
//                } else {
//                    logger.info("消息消费成功  业务号码={}",businessSNDO.getId());
//                }
//            }
//            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);//手动消息应答
//        } catch (IOException e) {
//
//            channel.basicReject(message.getMessageProperties().getDeliveryTag(), true);//true 重新放入队列
//            //channel.basicNack(message.getMessageProperties().getDeliveryTag(), false, true);//对于处理不了的异常消息
//            logger.error(e.getMessage(), e);
//            throw e;
//        }
    }
}
