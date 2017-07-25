package org.trc.validate;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Created by xujy on 2015/11/18.
 */
@Target({ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = VerifyBankCardNoValidator.class)
public @interface VerifyBankCardNo {
    String message() default "The cardNo is illegal";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
