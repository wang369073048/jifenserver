package org.trc.validate;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import javax.validation.constraintvalidation.SupportedValidationTarget;
import javax.validation.constraintvalidation.ValidationTarget;

/**
 * Created by xujy on 2015/11/18.
 */
@SupportedValidationTarget(ValidationTarget.PARAMETERS)
public class VerifyBankCardNoValidator implements ConstraintValidator<VerifyBankCardNo, String> {
    @Override
    public void initialize(VerifyBankCardNo verifyBankCardNo) {

    }

    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        if (s == null) {
            return true;
        }
        if (s.length() > 20) {
            constraintValidatorContext.disableDefaultConstraintViolation();
            constraintValidatorContext.buildConstraintViolationWithTemplate("{bankcard.cardNo.Max}").addConstraintViolation();
            return false;
        } else if (s.length() < 16) {
            constraintValidatorContext.disableDefaultConstraintViolation();
            constraintValidatorContext.buildConstraintViolationWithTemplate("{bankcard.cardNo.Min}").addConstraintViolation();
            return false;
        }
        return true;
    }
}
