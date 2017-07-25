package org.trc.resource;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

/**
 * author: hzwzhen
 * JDK-version:  JDK1.8
 * comments:
 * since Date： 2017/7/7
 */
public class CJTest {

    public static void main(String[] args) {
        //int random = new Random().nextInt(10000);
        int random = 9999;
        System.out.println(random);
        int prizeRate = 0;// 中奖率
        List<ActivityPrizesDO> list = new ArrayList<>();
        list.add(new ActivityPrizesDO(1L, 125));
        list.add(new ActivityPrizesDO(2L, 125));
        list.add(new ActivityPrizesDO(3L, 125));
        list.add(new ActivityPrizesDO(4L, 125));
        list.add(new ActivityPrizesDO(5L, 1250));
        list.add(new ActivityPrizesDO(6L, 1250));
        list.add(new ActivityPrizesDO(7L, 1250));
        list.add(new ActivityPrizesDO(8L, 5750));
        Collections.sort(list);
        for (ActivityPrizesDO activityPrizesDO : list) {
            prizeRate += activityPrizesDO.getWinningProbability();
            if (random < prizeRate) {
                System.out.println(activityPrizesDO);
                return;
            }
        }
        System.out.println("不该执行到这段代码!");

    }
}
