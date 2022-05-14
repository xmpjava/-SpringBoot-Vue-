package sqgxy.xmp.springboot.controller.dto;

import sqgxy.xmp.springboot.entity.Menu;
import lombok.Data;

import java.util.List;

/**
 * author: xmp
 * date: 2022/5/11
 * 接受前端登录请求的参数
 */
@Data
public class UserDTO {
    private Integer id;
    private String username;
    private String password;
    private String nickname;
    private String avatarUrl;
    private String token;
    private String role;
    private List<Menu> menus;
}
