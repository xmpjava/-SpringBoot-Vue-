package sqgxy.xmp.springboot.service;

import sqgxy.xmp.springboot.entity.Comment;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * @author xmp
 * @date 2022/5/12
 */
public interface ICommentService extends IService<Comment> {

    List<Comment> findCommentDetail(Integer articleId);
}
