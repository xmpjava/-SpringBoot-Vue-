package sqgxy.xmp.springboot.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import sqgxy.xmp.springboot.controller.dto.UserDTO;
import sqgxy.xmp.springboot.controller.dto.UserPasswordDTO;
import sqgxy.xmp.springboot.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * @author xmp
 * @date 2022/5/12
 */
public interface IUserService extends IService<User> {

    UserDTO login(UserDTO userDTO);

    User register(UserDTO userDTO);

    void updatePassword(UserPasswordDTO userPasswordDTO);

    Page<User> findPage(Page<User> objectPage, String username, String email, String address);
}
