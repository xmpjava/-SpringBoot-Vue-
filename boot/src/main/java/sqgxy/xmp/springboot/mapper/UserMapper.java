package sqgxy.xmp.springboot.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import sqgxy.xmp.springboot.controller.dto.UserPasswordDTO;
import sqgxy.xmp.springboot.entity.User;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

/**
 * @author xmp
 * @date 2022/5/12
 */
public interface UserMapper extends BaseMapper<User> {

    @Update("update sys_user set password = #{newPassword} where username = #{username} and password = #{password}")
    int updatePassword(UserPasswordDTO userPasswordDTO);

    Page<User> findPage(Page<User> page, @Param("username") String username, @Param("email") String email, @Param("address") String address);
}
