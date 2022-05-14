package sqgxy.xmp.springboot.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import sqgxy.xmp.springboot.entity.Course;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * @author xmp
 * @date 2022/5/12
 */
public interface ICourseService extends IService<Course> {

    Page<Course> findPage(Page<Course> page, String name);

    void setStudentCourse(Integer courseId, Integer studentId);
}
