package org.trc.validate;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import javax.validation.constraintvalidation.SupportedValidationTarget;
import javax.validation.constraintvalidation.ValidationTarget;

/**
 * Created by xujy on 2015/11/18.
 */
@SupportedValidationTarget(ValidationTarget.PARAMETERS)
public class VerifyMoneyValidator implements ConstraintValidator<VerifyMoney, String> {
    @Override
    public void initialize(VerifyMoney verifyMoney) {

    }

    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        if (s == null) {
            constraintValidatorContext.disableDefaultConstraintViolation();
            constraintValidatorContext.buildConstraintViolationWithTemplate("{bankcard.moneyOrder.NotBlank}").addConstraintViolation();
            return false;
        }
        try {
            Double.parseDouble(s);
        } catch (Exception e) {
            constraintValidatorContext.disableDefaultConstraintViolation();
            constraintValidatorContext.buildConstraintViolationWithTemplate("{bankcard.moneyOrder.Double}").addConstraintViolation();
            return false;
        }
        return true;
    }
}
