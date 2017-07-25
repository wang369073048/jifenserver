package org.trc.validate;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Created by Administrator on 2017/2/16.
 */
@Target({ElementType.METHOD, ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(
        validatedBy = {VerifyPhoneMatchValidator.class}
)
public @interface VerifyPhoneMatch {
    String message() default "手机号码非法";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
