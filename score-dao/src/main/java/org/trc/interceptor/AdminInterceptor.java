package org.trc.interceptor;


import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.naming.AuthenticationException;

/**
 * Created by huyan on 2016/8/2
 */
//@BindAnnotation(bind = Admin.class)
//@TxAop
public class AdminInterceptor implements MethodInterceptor {

    private Logger logger = LoggerFactory.getLogger(AdminInterceptor.class);

    public AdminInterceptor() {
        logger.info("AdminInterceptor init...");
    }

    @Override
    public Object invoke(MethodInvocation methodInvocation) throws Throwable {
        try {
            System.out.println("666666");

            if(methodInvocation.getMethod().isAnnotationPresent(Admin.class)){
                System.out.println("----------this method is added @LoginRequired-------------------------");
            }

        } catch (RuntimeException e) {
            e.printStackTrace();
            throw new AuthenticationException("未登录或者令牌已失效");
        }
        return methodInvocation.proceed();
    }
}
