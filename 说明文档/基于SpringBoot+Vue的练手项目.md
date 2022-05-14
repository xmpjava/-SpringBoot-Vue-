## 1、项目介绍

这是一款基于SpringBoot+Vue的前后端分离的项目，麻雀虽小，五脏俱全，值得拥有！

**全部源码放到文章最后**

页面展示：

- 用户主页

![前台主页](E:\xmp\2022\总结\imgs\前台主页.png)

- 管理员后台界面

![后台主页](E:\xmp\2022\总结\imgs\后台主页.png)

## 技术选型

- 后端
               SpringBoot
    			Hutool工具类库（*超好用）
    			Redis缓存 （缓解多次刷新数据库压力）
    			Lombok（减少写get、set等方法）
    			Mysql5.7+
    			Mybatis 、Mybatis-Plus

前端

- ​			Vue2

- ​			Vue-Router

- ​			VueX

- ​			ElementUI 

- ​			Apache ECharts (可视化图标插件)

- ​			Axios

- ​			高德地图Api

## 数据库设计

Mysql5.7+  、Nvaicat（MySQL可视化工具）



<img src="E:\xmp\2022\总结\imgs\数据库表.png" alt="数据库表" style="zoom: 67%;" />

```
字符集
utf8mb4
排序规则
utf8mb4_unicode_ci

```

## SpringBoot

目录结构

<img src="E:\xmp\2022\总结\imgs\Springboot.png" alt="Springboot" style="zoom:67%;" />

### 配置类

改成自己配置即可

```
server:
  ip: localhost
  port: 9090

spring:
  datasource:
    driver-class-name: com.mysql.jdbc.Driver
    url: jdbc:mysql://localhost:3306/boot?serverTimezone=GMT%2b8&useUnicode=true&characterEncoding=utf-8&useSSL=false
    username: root
    password: 
  redis:
    host: localhost
    port: 6379
    password: 
  servlet:
    multipart:
      max-file-size: 100MB
      max-request-size: 100MB
mybatis:
  mapper-locations: classpath:mapper/*.xml  #扫描所有mybatis的xml文件
#  configuration:
#    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
mybatis-plus:
  configuration:
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl

files:
  upload:
    path: /usr/xmp/files/
```

### 坐标导入

```
<dependencies>

    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>

    <dependency>
        <groupId>org.mybatis.spring.boot</groupId>
        <artifactId>mybatis-spring-boot-starter</artifactId>
        <version>2.2.1</version>
    </dependency>

    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <scope>runtime</scope>
        <version>5.1.47</version>
    </dependency>

    <dependency>
        <groupId>org.projectlombok</groupId>
        <artifactId>lombok</artifactId>
        <optional>true</optional>
    </dependency>

    <!-- mybatis-plus -->
    <dependency>
        <groupId>com.baomidou</groupId>
        <artifactId>mybatis-plus-boot-starter</artifactId>
        <version>3.5.1</version>
    </dependency>

    <!-- 代码生成器 -->
    <dependency>
        <groupId>com.baomidou</groupId>
        <artifactId>mybatis-plus-generator</artifactId>
        <version>3.5.1</version>
    </dependency>

    <dependency>
        <groupId>org.apache.velocity</groupId>
        <artifactId>velocity</artifactId>
        <version>1.7</version>
    </dependency>

    <!--swagger-->
    <dependency>
        <groupId>io.springfox</groupId>
        <artifactId>springfox-boot-starter</artifactId>
        <version>3.0.0</version>
    </dependency>

    <!-- hutool  -->
    <dependency>
        <groupId>cn.hutool</groupId>
        <artifactId>hutool-all</artifactId>
        <version>5.7.20</version>
    </dependency>

    <dependency>
        <groupId>org.apache.poi</groupId>
        <artifactId>poi-ooxml</artifactId>
        <version>4.1.2</version>
    </dependency>

    <!-- JWT -->
    <dependency>
        <groupId>com.auth0</groupId>
        <artifactId>java-jwt</artifactId>
        <version>3.10.3</version>
    </dependency>

    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-cache</artifactId>
    </dependency>

    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-redis</artifactId>
    </dependency>

    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
    </dependency>
</dependencies>
```

### Jwt、Token验证

```
package sqgxy.xmp.springboot.config.interceptor;

import cn.hutool.core.util.StrUtil;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import sqgxy.xmp.springboot.common.Constants;
import sqgxy.xmp.springboot.config.AuthAccess;
import sqgxy.xmp.springboot.entity.User;
import sqgxy.xmp.springboot.exception.ServiceException;
import sqgxy.xmp.springboot.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author xmp
 * @date 2022/5/9
 * @description JwtInterceptor
 * jwt拦截器
 */


public class JwtInterceptor implements HandlerInterceptor {

    @Autowired
    private IUserService userService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        String token = request.getHeader("token");

        // 如果不是映射到方法直接通过
        if(!(handler instanceof HandlerMethod)){
            return true;
        } else {
            HandlerMethod h = (HandlerMethod) handler;
            AuthAccess authAccess = h.getMethodAnnotation(AuthAccess.class);
            if (authAccess != null) {
                return true;
            }
        }
        // 执行认证
        if (StrUtil.isBlank(token)) {
            throw new ServiceException(Constants.CODE_401, "无token，请重新登录");
        }
        // 获取 token 中的 user id
        String userId;
        try {
            userId = JWT.decode(token).getAudience().get(0);
        } catch (JWTDecodeException j) {
            throw new ServiceException(Constants.CODE_401, "token验证失败，请重新登录");
        }
        // 根据token中的userid查询数据库
        User user = userService.getById(userId);
        if (user == null) {
            throw new ServiceException(Constants.CODE_401, "用户不存在，请重新登录");
        }
        // 用户密码加签验证 token
        JWTVerifier jwtVerifier = JWT.require(Algorithm.HMAC256(user.getPassword())).build();
        try {
            jwtVerifier.verify(token); // 验证token
        } catch (JWTVerificationException e) {
            throw new ServiceException(Constants.CODE_401, "token验证失败，请重新登录");
        }
        return true;
    }
}
```

### 自定义注解

```
package sqgxy.xmp.springboot.config;

import java.lang.annotation.*;


/**
 * @author xmp
 * date 2022/5/13
 * @description 自定义注解
 */

@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface AuthAccess {

}
```

### 跨域问题

```
package sqgxy.xmp.springboot.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

/**
 * @author xmp
 * @date 2022/5/9
 * @description 跨域问题
 */

@Configuration
public class CorsConfig {

    // 当前跨域请求最大有效时长。这里默认1天
    private static final long MAX_AGE = 24 * 60 * 60;

    @Bean
    public CorsFilter corsFilter() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration corsConfiguration = new CorsConfiguration();
        corsConfiguration.addAllowedOrigin("*"); // 1 设置访问源地址
        corsConfiguration.addAllowedHeader("*"); // 2 设置访问源请求头
        corsConfiguration.addAllowedMethod("*"); // 3 设置访问源请求方法
        corsConfiguration.setMaxAge(MAX_AGE);
        source.registerCorsConfiguration("/**", corsConfiguration); // 4 对接口配置跨域设置
        return new CorsFilter(source);
    }
}
```

### 接口统一返回包装类

```
package sqgxy.xmp.springboot.common;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author xmp
 * @date 2022/5/10
 * 接口统一返回包装类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Result {

    private String code;
    private String msg;
    private Object data;

    public static Result success() {
        return new Result(Constants.CODE_200, "", null);
    }

    public static Result success(Object data) {
        return new Result(Constants.CODE_200, "", data);
    }

    public static Result error(String code, String msg) {
        return new Result(code, msg, null);
    }

    public static Result error() {
        return new Result(Constants.CODE_500, "系统错误", null);
    }

}
```

### 自定义Code

```
package sqgxy.xmp.springboot.common;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author xmp
 * @date 2022/5/10
 * 接口统一返回包装类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Result {

    private String code;
    private String msg;
    private Object data;

    public static Result success() {
        return new Result(Constants.CODE_200, "", null);
    }

    public static Result success(Object data) {
        return new Result(Constants.CODE_200, "", data);
    }

    public static Result error(String code, String msg) {
        return new Result(code, msg, null);
    }

    public static Result error() {
        return new Result(Constants.CODE_500, "系统错误", null);
    }

}
```

### Mybatis-Plus分页插件

```
package sqgxy.xmp.springboot.config;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author xmp
 * @date 2022/5/9
 * @description MybatisPlusConfig mybatis-plus配置
 */

@Configuration
@MapperScan("sqgxy.xmp.springboot.mapper")
public class MybatisPlusConfig {

    // 最新版
    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor() {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        interceptor.addInnerInterceptor(new PaginationInnerInterceptor(DbType.MYSQL));
        return interceptor;
    }

}
```

### 开发模式

以User为例

#### Entity

Entity实体层与数据库属性一一对应，lombok注解简化封装方法

```
package sqgxy.xmp.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@TableName("sys_user")
@ApiModel(value = "User对象", description = "")
@ToString
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("id")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("用户名")
    private String username;

    @ApiModelProperty("密码")
    private String password;

    @ApiModelProperty("昵称")
    private String nickname;

    @ApiModelProperty("邮箱")
    private String email;

    @ApiModelProperty("电话")
    private String phone;

    @ApiModelProperty("地址")
    private String address;

    @ApiModelProperty("创建时间")
    private Date createTime;

    @ApiModelProperty("头像")
    private String avatarUrl;

    @ApiModelProperty("角色")
    private String role;

    @TableField(exist = false)
    private List<Course> courses;

    @TableField(exist = false)
    private List<Course> stuCourses;

}
```

#### mapper

mapper层对数据库进行数据持久化操作

```
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
```

UserMapper.xml

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="sqgxy.xmp.springboot.mapper.UserMapper">

    <resultMap id="pageUser" type="sqgxy.xmp.springboot.entity.User">
        <result column="id" property="id" />
        <result column="username" property="username" />
        <result column="nickname" property="nickname" />
        <result column="email" property="email" />
        <result column="phone" property="phone" />
        <result column="address" property="address" />
        <result column="create_time" property="createTime" />
        <result column="avatar_url" property="avatarUrl" />
        <result column="role" property="role" />
        <collection property="courses" javaType="java.util.ArrayList" ofType="sqgxy.xmp.springboot.entity.Course">
            <result column="teacherCourseName" property="name" />
            <result column="teacherScore" property="score" />
        </collection>
        <collection property="stuCourses" javaType="java.util.ArrayList" ofType="sqgxy.xmp.springboot.entity.Course">
            <result column="stuCourseName" property="name" />
            <result column="stuScore" property="score" />
        </collection>
    </resultMap>

    <select id="findPage" resultMap="pageUser">
        select sys_user.*, sc.name as stuCourseName, tc.name as teacherCourseName, tc.score as teacherScore,
        sc.score as stuScore from sys_user
        left join student_course
        on sys_user.id = student_course.student_id
        left join course sc
        on student_course.course_id = sc.id
        left join course tc
        on sys_user.id = tc.teacher_id
        <where>
            <if test="username != null and username != ''">
                and sys_user.username like concat('%', #{username} ,'%')
            </if>
            <if test="email != null and email != ''">
                and sys_user.email like concat('%', #{email} ,'%')
            </if>
            <if test="address != null and address != ''">
                and sys_user.address like concat('%', #{address} ,'%')
            </if>
        </where>
    </select>

</mapper>
```

#### service层

即为业务逻辑层，可以理解为对一个或者多个dao进行得再次封装，主要是针对具体的问题的操作，把一些数据层的操作进行组合，间接与数据库打交道(提供操作数据库的方法)。要做这一层的话，要先设计接口，再实现类

```
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
```

```
package sqgxy.xmp.springboot.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.log.Log;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import sqgxy.xmp.springboot.common.Constants;
import sqgxy.xmp.springboot.common.RoleEnum;
import sqgxy.xmp.springboot.controller.dto.UserDTO;
import sqgxy.xmp.springboot.controller.dto.UserPasswordDTO;
import sqgxy.xmp.springboot.entity.Menu;
import sqgxy.xmp.springboot.entity.User;
import sqgxy.xmp.springboot.exception.ServiceException;
import sqgxy.xmp.springboot.mapper.RoleMapper;
import sqgxy.xmp.springboot.mapper.RoleMenuMapper;
import sqgxy.xmp.springboot.mapper.UserMapper;
import sqgxy.xmp.springboot.service.IMenuService;
import sqgxy.xmp.springboot.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import sqgxy.xmp.springboot.utils.TokenUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * @author xmp
 * @date 2022/5/12
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    private static final Log LOG = Log.get();

    @Resource
    private UserMapper userMapper;

    @Resource
    private RoleMapper roleMapper;

    @Resource
    private RoleMenuMapper roleMenuMapper;

    @Resource
    private IMenuService menuService;

    @Override
    public UserDTO login(UserDTO userDTO) {
        User one = getUserInfo(userDTO);
        if (one != null) {
            BeanUtil.copyProperties(one, userDTO, true);
            // 设置token
            String token = TokenUtils.genToken(one.getId().toString(), one.getPassword());
            userDTO.setToken(token);

            String role = one.getRole(); // ROLE_ADMIN
            // 设置用户的菜单列表
            List<Menu> roleMenus = getRoleMenus(role);
            userDTO.setMenus(roleMenus);
            return userDTO;
        } else {
            throw new ServiceException(Constants.CODE_600, "用户名或密码错误");
        }
    }

    @Override
    public User register(UserDTO userDTO) {
        User one = getUserInfo(userDTO);
        if (one == null) {
            one = new User();
            BeanUtil.copyProperties(userDTO, one, true);
            // 默认一个普通用户的角色
            one.setRole(RoleEnum.ROLE_ADMIN.toString());
            save(one);  // 把 copy完之后的用户对象存储到数据库
        } else {
            throw new ServiceException(Constants.CODE_600, "用户已存在");
        }
        return one;
    }

    @Override
    public void updatePassword(UserPasswordDTO userPasswordDTO) {
        int update = userMapper.updatePassword(userPasswordDTO);
        if (update < 1) {
            throw new ServiceException(Constants.CODE_600, "密码错误");
        }
    }

    @Override
    public Page<User> findPage(Page<User> page, String username, String email, String address) {
        return userMapper.findPage(page, username, email, address);
    }

    private User getUserInfo(UserDTO userDTO) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", userDTO.getUsername());
        queryWrapper.eq("password", userDTO.getPassword());
        User one;
        try {
            one = getOne(queryWrapper); // 从数据库查询用户信息
        } catch (Exception e) {
            LOG.error(e);
            throw new ServiceException(Constants.CODE_500, "系统错误");
        }
        return one;
    }

    /**
     * 获取当前角色的菜单列表
     * @param roleFlag
     * @return
     */
    private List<Menu> getRoleMenus(String roleFlag) {
        Integer roleId = roleMapper.selectByFlag(roleFlag);
        // 当前角色的所有菜单id集合
        List<Integer> menuIds = roleMenuMapper.selectByRoleId(roleId);

        // 查出系统所有的菜单(树形)
        List<Menu> menus = menuService.findMenus("");
        // new一个最后筛选完成之后的list
        List<Menu> roleMenus = new ArrayList<>();
        // 筛选当前用户角色的菜单
        for (Menu menu : menus) {
            if (menuIds.contains(menu.getId())) {
                roleMenus.add(menu);
            }
            List<Menu> children = menu.getChildren();
            // removeIf()  移除 children 里面不在 menuIds集合中的 元素
            children.removeIf(child -> !menuIds.contains(child.getId()));
        }
        return roleMenus;
    }

}
```

####  controller层

负责请求转发，接收页面过来的参数，传给service处理，接到返回值，并再次传给页面。

```
package sqgxy.xmp.springboot.controller;


import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.poi.excel.ExcelReader;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import sqgxy.xmp.springboot.common.Constants;
import sqgxy.xmp.springboot.common.Result;
import sqgxy.xmp.springboot.controller.dto.UserDTO;
import sqgxy.xmp.springboot.controller.dto.UserPasswordDTO;
import sqgxy.xmp.springboot.entity.User;
import sqgxy.xmp.springboot.service.IUserService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.List;

/**
 * @author xmp
 * @since 2022-01-26
 */
@RestController
@RequestMapping("/user")
public class UserController {

    @Value("${files.upload.path}")
    private String filesUploadPath;

    @Resource
    private IUserService userService;

    @PostMapping("/login")
    public Result login(@RequestBody UserDTO userDTO) {
        String username = userDTO.getUsername();
        String password = userDTO.getPassword();
        if (StrUtil.isBlank(username) || StrUtil.isBlank(password)) {
            return Result.error(Constants.CODE_400, "参数错误");
        }
        UserDTO dto = userService.login(userDTO);
        return Result.success(dto);
    }

    @PostMapping("/register")
    public Result register(@RequestBody UserDTO userDTO) {
        String username = userDTO.getUsername();
        String password = userDTO.getPassword();
        if (StrUtil.isBlank(username) || StrUtil.isBlank(password)) {
            return Result.error(Constants.CODE_400, "参数错误");
        }
        return Result.success(userService.register(userDTO));
    }

    // 新增或者更新
    @PostMapping
    public Result save(@RequestBody User user) {
        if (user.getId() == null && user.getPassword() == null) {  // 新增用户默认密码
            user.setPassword("123");
        }
        return Result.success(userService.saveOrUpdate(user));
    }

    /**
     * 修改密码
     * @param userPasswordDTO
     * @return
     */
    @PostMapping("/password")
    public Result password(@RequestBody UserPasswordDTO userPasswordDTO) {
        userService.updatePassword(userPasswordDTO);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        return Result.success(userService.removeById(id));
    }

    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success(userService.removeByIds(ids));
    }

    @GetMapping
    public Result findAll() {
        return Result.success(userService.list());
    }

    @GetMapping("/role/{role}")
    public Result findUsersByRole(@PathVariable String role) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("role", role);
        List<User> list = userService.list(queryWrapper);
        return Result.success(list);
    }

    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(userService.getById(id));
    }

    @GetMapping("/username/{username}")
    public Result findByUsername(@PathVariable String username) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        return Result.success(userService.getOne(queryWrapper));
    }

    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                               @RequestParam Integer pageSize,
                               @RequestParam(defaultValue = "") String username,
                               @RequestParam(defaultValue = "") String email,
                               @RequestParam(defaultValue = "") String address)
    {
        return Result.success(userService.findPage(new Page<>(pageNum, pageSize), username, email, address));
    }

    /**
     * 导出接口
     */
    @GetMapping("/export")
    public void export(HttpServletResponse response) throws Exception {
        // 从数据库查询出所有的数据
        List<User> list = userService.list();
        // 通过工具类创建writer 写出到磁盘路径
//        ExcelWriter writer = ExcelUtil.getWriter(filesUploadPath + "/用户信息.xlsx");
        // 在内存操作，写出到浏览器
        ExcelWriter writer = ExcelUtil.getWriter(true);
        //自定义标题别名
        writer.addHeaderAlias("username", "用户名");
        writer.addHeaderAlias("password", "密码");
        writer.addHeaderAlias("nickname", "昵称");
        writer.addHeaderAlias("email", "邮箱");
        writer.addHeaderAlias("phone", "电话");
        writer.addHeaderAlias("address", "地址");
        writer.addHeaderAlias("createTime", "创建时间");
        writer.addHeaderAlias("avatarUrl", "头像");

        // 一次性写出list内的对象到excel，使用默认样式，强制输出标题
        writer.write(list, true);

        // 设置浏览器响应的格式
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
        String fileName = URLEncoder.encode("用户信息", "UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");

        ServletOutputStream out = response.getOutputStream();
        writer.flush(out, true);
        out.close();
        writer.close();

    }

    /**
     * excel 导入
     * @param file
     * @throws Exception
     */
    @PostMapping("/import")
    public Result imp(MultipartFile file) throws Exception {
        InputStream inputStream = file.getInputStream();
        ExcelReader reader = ExcelUtil.getReader(inputStream);
        // 方式1：(推荐) 通过 javabean的方式读取Excel内的对象，但是要求表头必须是英文，跟javabean的属性要对应起来
//        List<User> list = reader.readAll(User.class);

        // 方式2：忽略表头的中文，直接读取表的内容
        List<List<Object>> list = reader.read(1);
        List<User> users = CollUtil.newArrayList();
        for (List<Object> row : list) {
            User user = new User();
            user.setUsername(row.get(0).toString());
            user.setPassword(row.get(1).toString());
            user.setNickname(row.get(2).toString());
            user.setEmail(row.get(3).toString());
            user.setPhone(row.get(4).toString());
            user.setAddress(row.get(5).toString());
            user.setAvatarUrl(row.get(6).toString());
            users.add(user);
        }

        userService.saveBatch(users);
        return Result.success(true);
    }

}
```



## Vue

目录结构

<img src="E:\xmp\2022\总结\imgs\Vue.png" alt="Vue" style="zoom:67%;" />

### 跨域问题

安装axios：  npm i axios -S

解决跨域问题，前端8080端口，请求数据后端9090端口

```
import axios from 'axios'
import router from "@/router";
import {serverIp} from "../../public/config";

const request = axios.create({
    baseURL: `http://${serverIp}:9090`,
    timeout: 30000
})

// request 拦截器
// 可以自请求发送前对请求做一些处理
// 比如统一加token，对请求参数统一加密
request.interceptors.request.use(config => {
    config.headers['Content-Type'] = 'application/json;charset=utf-8';
    let user = localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : null
    if (user) {
        config.headers['token'] = user.token;  // 设置请求头
    }

    return config
}, error => {
    return Promise.reject(error)
});

// response 拦截器
// 可以在接口响应后统一处理结果
request.interceptors.response.use(
    response => {
        let res = response.data;
        // 如果是返回的文件
        if (response.config.responseType === 'blob') {
            return res
        }
        // 兼容服务端返回的字符串数据
        if (typeof res === 'string') {
            res = res ? JSON.parse(res) : res
        }
        // 当权限验证不通过的时候给出提示
        if (res.code === '401') {
            // ElementUI.Message({
            //     message: res.msg,
            //     type: 'error'
            // });
            router.push("/login")
        }
        return res;
    },
    error => {
        console.log('err' + error) // for debug
        return Promise.reject(error)
    }
)


export default request


```

### 页面开发

看文档、B站讲解

### Element-Ui

官网地址：https://element.eleme.io/#/zh-CN/component/installation

### Apache ECharts

官网地址：https://echarts.apache.org/handbook/zh/get-started/

## 项目部署

#### 环境：

centos7、jdk8、mysql、Redis、nginx

远程连接工具Xshell、Xftp

#### Vue打包

dist文件夹：

​				npm run build  

#### SpringBoot打包

<img src="E:\xmp\2022\总结\imgs\Snipaste_2022-05-14_17-05-00.png" alt="Snipaste_2022-05-14_17-05-00" style="zoom:67%;" />

按步骤 

​			先清除，在编译，最后打包

上传之后

#### nginx 

配置一下前端页面

```
location / {
      root  /public/app/dist;      ===>自己的路径
      index index.html index.html index.htm;
  }
```

#### Boot

后台启动命令

nohup java -jar xxx &

## 效果外链

http://180.76.56.118:80/login

为了展示全部效果，注册账号时默认为管理员，登入直接到后台。

管理员访问前端页面地址：http://180.76.56.118/front/home



普通用户，账号：222，密码：222，登入可直接到前端页面。



浏览器会缓存用户信息，所以管理员和用户切换时，可以F12清理缓存，目前这个算是个小bug。

## 学习渠道

鱼皮的编程导航https://www.code-nav.cn/

B站的黑马程序员https://space.bilibili.com/37974444?spm_id_from=333.788.b_765f7570696e666f.2

B站的程序员青戈https://space.bilibili.com/402779077?spm_id_from=333.788.b_765f7570696e666f.2

## 源码分享

码云:https://gitee.com/love-code-bear/springboot-vue.git

github:https://github.com/xmpjava/-SpringBoot-Vue-.git