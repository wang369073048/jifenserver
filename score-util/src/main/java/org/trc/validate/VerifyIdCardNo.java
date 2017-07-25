package org.trc.validate;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Created by htt on 2015/12/7.
 */
@Target({ElementType.METHOD, ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = VerifyIdCardNoValidator.class)
public @interface VerifyIdCardNo {
    String message() default "请输入正确的身份证号";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
