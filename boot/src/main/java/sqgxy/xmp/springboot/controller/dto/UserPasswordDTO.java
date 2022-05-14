package sqgxy.xmp.springboot.controller.dto;

import lombok.Data;

/**
 * @author xmp
 * @date 2022/5/12
 * 修改密码用
 */

@Data
public class UserPasswordDTO {
    private String username;
    private String password;
    private String newPassword;
}
