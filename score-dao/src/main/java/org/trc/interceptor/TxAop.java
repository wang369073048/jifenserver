package org.trc.interceptor;

import java.lang.annotation.*;

/**
 * Created by hzwzhen on 2017/6/8.
 */
@Documented
@Target({ElementType.TYPE, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface TxAop {
}