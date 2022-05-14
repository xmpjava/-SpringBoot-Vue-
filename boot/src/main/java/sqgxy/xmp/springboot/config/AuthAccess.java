package sqgxy.xmp.springboot.config;

import java.lang.annotation.*;


/**
 * @author smp
 * date 2022/5/13
 * @description 自定义注解
 */

@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface AuthAccess {

}
