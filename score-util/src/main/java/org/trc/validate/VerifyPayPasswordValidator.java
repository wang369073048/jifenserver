package org.trc.validate;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

/**
 * Created by Administrator on 2016/6/29.
 */
public class VerifyPayPasswordValidator implements ConstraintValidator<VerifyPayPassword, String> {
    @Override
    public void initialize(VerifyPayPassword constraintAnnotation) {

    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        if (value == null) {
            return true;
        } else if (value.length() < 6) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("{user.reset.newPassword.Min}").addConstraintViolation();
            return false;
        } else if (value.length() > 20) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("{user.reset.newPassword.Max}").addConstraintViolation();
            return false;
        }
        return true;
    }
}
