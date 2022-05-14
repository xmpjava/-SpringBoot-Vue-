package sqgxy.xmp.springboot.service;

import sqgxy.xmp.springboot.entity.Menu;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * @author xmp
 * @date 2022/5/12
 */
public interface IMenuService extends IService<Menu> {

    List<Menu> findMenus(String name);
}
