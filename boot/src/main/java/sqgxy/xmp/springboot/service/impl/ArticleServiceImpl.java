package sqgxy.xmp.springboot.service.impl;

import sqgxy.xmp.springboot.entity.Article;
import sqgxy.xmp.springboot.mapper.ArticleMapper;
import sqgxy.xmp.springboot.service.IArticleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * @author xmp
 * @date 2022/5/12
 */
@Service
public class ArticleServiceImpl extends ServiceImpl<ArticleMapper, Article> implements IArticleService {

}
