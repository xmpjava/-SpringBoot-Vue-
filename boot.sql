/*
 Navicat Premium Data Transfer

 Source Server         : yun-itxmp
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : 180.76.56.118:3306
 Source Schema         : boot

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 14/05/2022 18:16:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '内容',
  `user` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布人',
  `time` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (1, '张强好帅', '张强好帅', 'admin', '2022-05-12 19:22:58');
INSERT INTO `article` VALUES (2, '李卓好帅', '张强好帅', 'admin', '2022-05-12 19:22:58');
INSERT INTO `article` VALUES (3, 'BUG', '::: hljs-center\n\n## **未攻克Bug**\n\n:::\n浏览器缓存问题，可能会出现404', 'xmp', '2022-05-14 11:42:57');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课程名称',
  `score` int(11) NULL DEFAULT NULL COMMENT '学分',
  `times` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '上课时间',
  `state` tinyint(1) NULL DEFAULT NULL COMMENT '是否开课',
  `teacher_id` int(11) NULL DEFAULT NULL COMMENT '授课老师id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, '计算机网络', 5, '48', 0, 17);
INSERT INTO `course` VALUES (2, '高等数学', 10, '45', NULL, 16);
INSERT INTO `course` VALUES (3, '大学英语', 10, '30', NULL, 16);

-- ----------------------------
-- Table structure for student_course
-- ----------------------------
DROP TABLE IF EXISTS `student_course`;
CREATE TABLE `student_course`  (
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  PRIMARY KEY (`student_id`, `course_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of student_course
-- ----------------------------
INSERT INTO `student_course` VALUES (1, 1);
INSERT INTO `student_course` VALUES (28, 1);
INSERT INTO `student_course` VALUES (28, 2);

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('user', 'el-icon-user', 'icon');
INSERT INTO `sys_dict` VALUES ('house', 'el-icon-house', 'icon');
INSERT INTO `sys_dict` VALUES ('menu', 'el-icon-menu', 'icon');
INSERT INTO `sys_dict` VALUES ('s-custom', 'el-icon-s-custom', 'icon');
INSERT INTO `sys_dict` VALUES ('s-grid', 'el-icon-s-grid', 'icon');
INSERT INTO `sys_dict` VALUES ('document', 'el-icon-document', 'icon');
INSERT INTO `sys_dict` VALUES ('coffee', 'el-icon-coffee\r\n', 'icon');
INSERT INTO `sys_dict` VALUES ('s-marketing', 'el-icon-s-marketing', 'icon');

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件名称',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件类型',
  `size` bigint(20) NULL DEFAULT NULL COMMENT '文件大小(kb)',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '下载链接',
  `md5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件md5',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  `enable` tinyint(1) NULL DEFAULT 1 COMMENT '是否禁用链接',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO `sys_file` VALUES (1, '1.JPG', 'JPG', 8, 'http://180.76.56.118:9090/file/a646d12589d04decb6f9bf849a87e5d4.JPG', '51ff82ade164c3f4ebc92766cfc849de', 0, 1);
INSERT INTO `sys_file` VALUES (2, '1.JPG', 'JPG', 8, 'http://180.76.56.118:9090/file/a646d12589d04decb6f9bf849a87e5d4.JPG', '51ff82ade164c3f4ebc92766cfc849de', 0, 1);
INSERT INTO `sys_file` VALUES (3, '1.png', 'png', 28, 'http://180.76.56.118:9090/file/aa569e42fd0843e288efe4edfb224531.png', 'c0b74e35a213ca38b0f5c8d3e78e374c', 0, 1);
INSERT INTO `sys_file` VALUES (4, '2.JPG', 'JPG', 9, 'http://180.76.56.118:9090/file/2205692ea6b544478476ea72a5352487.JPG', 'c5852bfcb61e68e43b07fe3d68daecda', 0, 1);
INSERT INTO `sys_file` VALUES (5, '4.JPG', 'JPG', 4, 'http://180.76.56.118:9090/file/3b8ee8941f334cd797aa2d8f66b8ba74.JPG', 'fe06ed4ed8ae2049c19b74974376a8eb', 0, 1);
INSERT INTO `sys_file` VALUES (6, '4.JPG', 'JPG', 4, 'http://180.76.56.118:9090/file/3b8ee8941f334cd797aa2d8f66b8ba74.JPG', 'fe06ed4ed8ae2049c19b74974376a8eb', 0, 1);
INSERT INTO `sys_file` VALUES (7, '9b6e9baaddfdf802376b401cc05de965.mp4', 'mp4', 1351, 'http://180.76.56.118:9090/file/a7447bdbbc4d4b8eb65cea14ec2ba00d.mp4', 'bb34c35f2704f1a38640d0f40bc37b9c', 0, 1);
INSERT INTO `sys_file` VALUES (8, 'b443d427eb2899dbdde9ddb8f6f4b200.mp4', 'mp4', 52, 'http://180.76.56.118:9090/file/3f6d9ce00b184b709e704f75d1cb4f23.mp4', 'c2de03128916f3c49e39751457e8d5c2', 0, 1);
INSERT INTO `sys_file` VALUES (9, 'd8e37d15ecfe1c2245e92bebfe5cf930.mp4', 'mp4', 2264, 'http://180.76.56.118:9090/file/fd4f0d6082294c85b0349c1118776358.mp4', '83a2151ee07306ef2de8027641b80401', 0, 1);
INSERT INTO `sys_file` VALUES (10, 'f98856c1dd6b39894b0498d8d0b1c24f.mp4', 'mp4', 916, 'http://180.76.56.118:9090/file/533fe944056842438e0afde28a556b9b.mp4', '45b80aaa77434baed62603786377b927', 0, 1);
INSERT INTO `sys_file` VALUES (11, '????_20220514152155.jpg', 'jpg', 129, 'http://180.76.56.118:9090/file/9ffa38a3eaee420293fbf8df9e8fc399.jpg', 'abbe0af9d97c431eac315ac5e4964e5f', 0, 1);
INSERT INTO `sys_file` VALUES (12, '????_202205141521551.jpg', 'jpg', 823, 'http://180.76.56.118:9090/file/86c50fce662a42c6b3baedf69dab33c3.jpg', 'c02112c76e8e09bdf7fc9abf7f2162ff', 0, 1);
INSERT INTO `sys_file` VALUES (13, '????_202205141521552.jpg', 'jpg', 550, 'http://180.76.56.118:9090/file/3099f89e22e04970a5e158895db33f88.jpg', '146f004e56460e8bc42fc1ded0c8ec17', 0, 1);
INSERT INTO `sys_file` VALUES (14, '????_202205141521553.jpg', 'jpg', 783, 'http://180.76.56.118:9090/file/1c38abfc231c45b2b9e146b77db7aaf5.jpg', 'f2f3980878778a9aec0865910884bd80', 0, 1);
INSERT INTO `sys_file` VALUES (15, '????_202205141521554.jpg', 'jpg', 493, 'http://180.76.56.118:9090/file/baef2211115342b3b688134ea134d142.jpg', '0397ce6f107f015e04ad38f3e1b1b5af', 0, 1);
INSERT INTO `sys_file` VALUES (16, '????_202205141521555.jpg', 'jpg', 81, 'http://180.76.56.118:9090/file/ce4247045d8647deb47a5f88cbcdc69c.jpg', '856a238084a7ce4b4a63193ddc54efa3', 0, 1);
INSERT INTO `sys_file` VALUES (17, '????_202205141521556.jpg', 'jpg', 1134, 'http://180.76.56.118:9090/file/e01fca159d1349139cc3a8b7eac43f2c.jpg', 'ffc1a3822885c8bfdef92a96e3618f89', 0, 1);
INSERT INTO `sys_file` VALUES (18, '4.JPG', 'JPG', 4, 'http://180.76.56.118:9090/file/3b8ee8941f334cd797aa2d8f66b8ba74.JPG', 'fe06ed4ed8ae2049c19b74974376a8eb', 0, 1);
INSERT INTO `sys_file` VALUES (19, '1.png', 'png', 28, 'http://180.76.56.118:9090/file/aa569e42fd0843e288efe4edfb224531.png', 'c0b74e35a213ca38b0f5c8d3e78e374c', 0, 1);
INSERT INTO `sys_file` VALUES (20, '96759763.jfif', 'jfif', 28, 'http://180.76.56.118:9090/file/aa569e42fd0843e288efe4edfb224531.png', 'c0b74e35a213ca38b0f5c8d3e78e374c', 0, 1);
INSERT INTO `sys_file` VALUES (21, '????_20220329105731.jpg', 'jpg', 338, 'http://180.76.56.118:9090/file/41c2ed93e5954288b45c58a1b4cc57b9.jpg', 'dc8ef9bb12269d47a035a74cd6c1abc7', 0, 1);
INSERT INTO `sys_file` VALUES (22, '????_20220329105723.jpg', 'jpg', 314, 'http://180.76.56.118:9090/file/edac7172a3fa45ebb269efb49005debf.jpg', '7ee92e23597ac7daef8af417222366cc', 0, 1);
INSERT INTO `sys_file` VALUES (23, '1.png', 'png', 28, 'http://180.76.56.118:9090/file/aa569e42fd0843e288efe4edfb224531.png', 'c0b74e35a213ca38b0f5c8d3e78e374c', 0, 1);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '路径',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图标',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `pid` int(11) NULL DEFAULT NULL COMMENT '父级id',
  `page_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '页面路径',
  `sort_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (2, '数据报表', '/dashbord', 'el-icon-s-marketing', '11', NULL, 'Dashbord', 100);
INSERT INTO `sys_menu` VALUES (4, '系统管理', NULL, 'el-icon-s-grid', NULL, NULL, NULL, 300);
INSERT INTO `sys_menu` VALUES (5, '用户管理', '/user', 'el-icon-user', NULL, 4, 'User', 301);
INSERT INTO `sys_menu` VALUES (6, '角色管理', '/role', 'el-icon-s-custom', NULL, 4, 'Role', 302);
INSERT INTO `sys_menu` VALUES (7, '菜单管理', '/menu', 'el-icon-menu', NULL, 4, 'Menu', 303);
INSERT INTO `sys_menu` VALUES (8, '文件管理', '/file', 'el-icon-document', NULL, 4, 'File', 304);
INSERT INTO `sys_menu` VALUES (9, '请作者喝杯奶茶', '/donate', 'el-icon-coffee\r\n', NULL, NULL, 'Donate', 200);
INSERT INTO `sys_menu` VALUES (10, '主页', '/home', 'el-icon-house', NULL, NULL, 'Home', 0);
INSERT INTO `sys_menu` VALUES (39, '课程管理', '/course', 'el-icon-menu', NULL, NULL, 'Course', 201);
INSERT INTO `sys_menu` VALUES (40, '高德地图', '/map', 'el-icon-house', NULL, NULL, 'Map', 999);
INSERT INTO `sys_menu` VALUES (41, '文章管理', '/article', 'el-icon-menu', NULL, NULL, 'Article', 999);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `flag` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '唯一标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '管理员', '管理员', 'ROLE_ADMIN');
INSERT INTO `sys_role` VALUES (2, '学生', '学生', 'ROLE_STUDENT');
INSERT INTO `sys_role` VALUES (3, '老师', '老师', 'ROLE_TEACHER');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `menu_id` int(11) NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色菜单关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 2);
INSERT INTO `sys_role_menu` VALUES (1, 4);
INSERT INTO `sys_role_menu` VALUES (1, 5);
INSERT INTO `sys_role_menu` VALUES (1, 6);
INSERT INTO `sys_role_menu` VALUES (1, 7);
INSERT INTO `sys_role_menu` VALUES (1, 8);
INSERT INTO `sys_role_menu` VALUES (1, 9);
INSERT INTO `sys_role_menu` VALUES (1, 10);
INSERT INTO `sys_role_menu` VALUES (1, 39);
INSERT INTO `sys_role_menu` VALUES (1, 40);
INSERT INTO `sys_role_menu` VALUES (1, 41);
INSERT INTO `sys_role_menu` VALUES (3, 2);
INSERT INTO `sys_role_menu` VALUES (3, 10);
INSERT INTO `sys_role_menu` VALUES (3, 39);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '昵称',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', 'admin', 'xmp', 'admin@qq.com', '10086', '666', '2022-01-22 21:10:27', 'http://180.76.56.118:9090/file/aa569e42fd0843e288efe4edfb224531.png', 'ROLE_ADMIN');
INSERT INTO `sys_user` VALUES (33, '111', '111', '111', '111', '111', '111', '2022-05-13 23:26:28', '', 'ROLE_TEACHER');
INSERT INTO `sys_user` VALUES (34, '222', '222', '222', '222', '222', '222', '2022-05-13 23:26:50', 'http://180.76.56.118:9090/file/41c2ed93e5954288b45c58a1b4cc57b9.jpg', 'ROLE_STUDENT');
INSERT INTO `sys_user` VALUES (35, '333', '333', '333', '333', '333', '333', '2022-05-13 23:27:23', NULL, 'ROLE_USER');
INSERT INTO `sys_user` VALUES (36, '8888', '8888', '8888', NULL, NULL, '河南', '2022-05-14 16:07:58', 'http://180.76.56.118:9090/file/aa569e42fd0843e288efe4edfb224531.png', 'ROLE_ADMIN');
INSERT INTO `sys_user` VALUES (37, '9999', '9999', '9999', NULL, NULL, NULL, '2022-11-24 16:11:08', NULL, 'ROLE_STUDENT');
INSERT INTO `sys_user` VALUES (38, '777', '777', '777', NULL, NULL, NULL, '2022-09-14 16:11:48', NULL, 'ROLE_STUDENT');

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '评论人id',
  `time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论时间',
  `pid` int(11) NULL DEFAULT NULL COMMENT '父id',
  `origin_id` int(11) NULL DEFAULT NULL COMMENT '最上级评论id',
  `article_id` int(11) NULL DEFAULT NULL COMMENT '关联文章的id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES (22, '我也觉得！', 34, '2022-05-13 23:30:24', NULL, NULL, 2);
INSERT INTO `t_comment` VALUES (23, '???????', 34, '2022-05-14 15:32:17', NULL, NULL, 3);
INSERT INTO `t_comment` VALUES (24, '666', 36, '2022-05-14 16:09:43', NULL, NULL, 3);

SET FOREIGN_KEY_CHECKS = 1;
