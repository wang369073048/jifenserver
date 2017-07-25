package org.trc.validate;

import org.apache.commons.lang.StringUtils;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

/**
 * Created by htt on 2015/12/7.
 */
public class VerifyIdCardNoValidator implements ConstraintValidator<VerifyIdCardNo, String> {
    @Override
    public void initialize(VerifyIdCardNo verifyIdCardNo) {

    }

    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        if (StringUtils.isBlank(s)) {
            return false;
        }
        return SyntaxCheck.idCardNo(s);
    }
}
