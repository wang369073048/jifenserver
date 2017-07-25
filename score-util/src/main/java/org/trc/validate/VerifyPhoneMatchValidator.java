package org.trc.validate;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

/**
 * Created by Administrator on 2017/2/16.
 */
public class VerifyPhoneMatchValidator implements ConstraintValidator<VerifyPhoneMatch,String> {
    @Override
    public void initialize(VerifyPhoneMatch verifyPhoneMatch) {

    }

    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        if(s == null) {
           return true;
        } else if(SyntaxCheck.phone(s)) {
            return true;
        } else {
           return false;
        }
    }
}
