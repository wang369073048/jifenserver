package org.trc.interceptor;

import java.lang.annotation.*;

/**
 * Created by hzwzhen on 2017/6/8.
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE})
@Documented
@Inherited
public @interface BindAnnotation {
    Class<? extends Annotation>[] bind();
}
