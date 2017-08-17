package org.trc.resource.beanvalidation;

/**
 * author: hzwzhen
 * JDK-version:  JDK1.8
 * comments:
 * since Date： 2017/8/17
 */
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;

public class Test {
    public static void main(String[] args) throws Exception {
        ValidatorFactory vf = Validation.buildDefaultValidatorFactory();
        Validator validator = vf.getValidator();
        Order order = new Order();
        order.setPlatformOrderID("111111111111111"); // 不合法的订单长度

        Receiver receiver = new Receiver();
        receiver.setEmail("dddd"); // 不合法的邮箱
        order.setReceiver(receiver);

        List<Product> products = new ArrayList<Product>();
        Product product = new Product();
        product.setQuantity("1.0"); // 不合法的数量
        product.setDeclareValue("-1"); // 不合法的申报价值
        products.add(product);
        order.setProductList(products);

        Set<ConstraintViolation<Order>> validate = validator.validate(order);
        for (ConstraintViolation<Order> cv : validate) {
            System.out.println(cv.getMessage() + "(" + cv.getPropertyPath() + ")"
                    + "-->" + cv.getInvalidValue());
        }
    }
}
