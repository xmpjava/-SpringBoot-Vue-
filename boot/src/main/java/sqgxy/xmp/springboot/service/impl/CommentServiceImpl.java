package sqgxy.xmp.springboot.service.impl;

import sqgxy.xmp.springboot.entity.Comment;
import sqgxy.xmp.springboot.mapper.CommentMapper;
import sqgxy.xmp.springboot.service.ICommentService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author xmp
 * @date 2022/5/12
 */
@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements ICommentService {

    @Resource
    private CommentMapper commentMapper;

    @Override
    public List<Comment> findCommentDetail(Integer articleId) {

        return commentMapper.findCommentDetail(articleId);
    }
}
