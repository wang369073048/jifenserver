package org.trc.validate;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Created by Administrator on 2016/6/29.
 */

@Target({ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = VerifyPayPasswordValidator.class)
public @interface VerifyPayPassword {
    String message() default "The payPassword is illegal";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
