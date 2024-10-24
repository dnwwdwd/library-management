create table librarymanagement.b_category
(
    id       int auto_increment
        primary key,
    name     varchar(32)  not null,
    keywords varchar(32)  null,
    notes    varchar(255) null,
    constraint name
        unique (name)
);

create table librarymanagement.book
(
    id           int auto_increment
        primary key,
    name         varchar(32)                        not null,
    category_id  int                                not null comment '书籍种类',
    author       varchar(32)                        not null,
    press        varchar(32)                        not null,
    publish_date date                               not null,
    price        decimal(10, 2)                     not null,
    page_number  int                                not null,
    keywords     varchar(32)                        null,
    create_time  datetime default CURRENT_TIMESTAMP not null,
    status       tinyint  default 0                 not null,
    notes        varchar(255)                       null
);

create table librarymanagement.lend_return
(
    id          int auto_increment
        primary key,
    r_id        int                      not null,
    b_id        int                      not null,
    lend_date   date default (curdate()) not null,
    return_date date                     null,
    status      int  default 0           null comment '归还状态，0: 出借中  1：正常归还  2：逾期归还  3：丢失无法归还  4：损坏归还  5：其他(备注说明)',
    notes       varchar(255)             null
);

create table librarymanagement.r_category
(
    id            int auto_increment
        primary key,
    name          varchar(32)  not null,
    amount        int          not null,
    lend_period   int          not null comment '一次借书的期限天数',
    effect_period date         not null comment '仅在毕业前借书有效',
    notes         varchar(255) null,
    constraint name
        unique (name)
);

create table librarymanagement.user
(
    id          int auto_increment comment 'id'
        primary key,
    name        varchar(256)                           null comment '账号',
    password    varchar(256)                           null comment '密码',
    role        varchar(256) default 'READER'          null comment '角色',
    category_id int                                    null comment '读者种类',
    sex         tinyint      default 1                 null,
    address     varchar(255)                           null,
    phone       varchar(11)                            null,
    email       varchar(64)                            null,
    notes       varchar(255)                           null,
    create_time datetime     default CURRENT_TIMESTAMP not null
)
    comment '用户表';


INSERT INTO librarymanagement.b_category (id, name, keywords, notes) VALUES (1, '小说', '小说, 小说类, 文学', '小说类书籍，包括文学经典、现代小说等');
INSERT INTO librarymanagement.b_category (id, name, keywords, notes) VALUES (2, '历史', '历史, 历史类, 历史书籍', '历史类书籍，包括古代历史、近现代史等');
INSERT INTO librarymanagement.b_category (id, name, keywords, notes) VALUES (3, '科学', '科学, 科学类, 科技', '科学类书籍，涵盖物理、化学、生物等各个领域');
INSERT INTO librarymanagement.b_category (id, name, keywords, notes) VALUES (4, '艺术', '艺术, 艺术类, 艺术书籍', '艺术类书籍，包括绘画、音乐、舞蹈等');
INSERT INTO librarymanagement.b_category (id, name, keywords, notes) VALUES (5, '哲学', '哲学, 哲学类, 哲学书籍', '哲学类书籍，涵盖古代哲学思想和现代哲学研究');
INSERT INTO librarymanagement.b_category (id, name, keywords, notes) VALUES (6, '政治', '政治, 政治类, 政治书籍', '政治类书籍，包括政治理论和国际关系等');
INSERT INTO librarymanagement.b_category (id, name, keywords, notes) VALUES (7, '经济', '经济, 经济类, 经济书籍', '经济类书籍，涵盖宏观经济学和微观经济学等');
INSERT INTO librarymanagement.b_category (id, name, keywords, notes) VALUES (8, '教育', '教育, 教育类, 教育书籍', '教育类书籍，包括教育心理学和教学方法等');
INSERT INTO librarymanagement.b_category (id, name, keywords, notes) VALUES (9, 'IT', 'IT，独立开发，Java', 'IT类书籍，独立开发者书籍，Java类书籍');

INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (1, '老人与海', 1, '海明威', '高等教育出版社', '2024-01-01', 19.99, 200, '老人, 坚持', '2024-10-21 19:13:56', 0, '展示老人渡海，搏斗的坚持不懈的精神');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (2, '红楼梦', 2, '曹雪芹', '人民文学出版社', '2024-02-01', 29.99, 300, '贾宝玉, 林黛玉', '2024-10-21 19:13:56', 0, '描写了贾宝玉和林黛玉的爱情故事');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (3, '水浒传', 3, '施耐庵', '上海古籍出版社', '2024-03-01', 39.99, 400, '宋江, 武松', '2024-10-21 19:13:56', 0, '讲述了宋江等英雄好汉的故事');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (4, '西游记', 4, '吴承恩', '中国友谊出版公司', '2024-04-01', 49.99, 500, '孙悟空, 唐僧', '2024-10-21 19:13:56', 1, '记录了孙悟空保护唐僧取经的经历');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (5, '三国演义', 5, '罗贯中', '华夏出版社', '2024-05-01', 59.99, 600, '刘备, 曹操', '2024-10-21 19:13:56', 0, '描述了三国时期的英雄豪杰');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (6, '论语', 6, '孔子', '商务印书馆', '2024-06-01', 69.99, 700, '仁, 礼', '2024-10-21 19:13:56', 0, '总结了孔子及其弟子的言行');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (7, '诗经', 7, '佚名', '中华书局', '2024-07-01', 79.99, 800, '离骚, 雅', '2024-10-21 19:13:56', 0, '是中国古代最早的一部诗歌总集');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (8, '道德经', 8, '老子', '人民出版社', '2024-08-01', 89.99, 900, '道, 德', '2024-10-21 19:13:56', 0, '论述了道家哲学的思想');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (9, '百年孤独', 1, '加西亚·马尔克斯', '南海出版公司', '2024-09-01', 99.99, 1000, '布恩迪亚家族, 马奎斯', '2024-10-21 19:13:56', 0, '以布恩迪亚家族七代人的故事为主线');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (10, '活着', 2, '余华', '作家出版社', '2024-10-01', 109.99, 1100, '福贵, 小福子', '2024-10-21 19:13:56', 0, '生动地描绘了一个农民的一生');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (11, '围城', 3, '钱钟书', '人民文学出版社', '2024-11-01', 119.99, 1200, '方鸿渐, 孙小姐', '2024-10-21 19:13:56', 0, '描写了知识分子的迷茫和困境');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (12, '白夜行', 1, '东野圭吾', '南海出版公司', '2024-12-01', 59.99, 600, '推理, 悬疑', '2024-10-21 19:13:56', 0, '讲述了两个孩子之间的黑暗秘密');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (13, '平凡的世界', 2, '路遥', '人民文学出版社', '2024-11-01', 49.99, 500, '农村, 人生', '2024-10-21 19:13:56', 0, '描写了农村人民的艰辛生活和奋斗');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (14, '哈利·波特与魔法石', 3, 'J.K.罗琳', '人民文学出版社', '2024-10-01', 39.99, 400, '魔法, 冒险', '2024-10-21 19:13:56', 0, '描述了哈利·波特进入魔法世界的故事');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (15, '傲慢与偏见', 4, '简·奥斯汀', '外语教学与研究出版社', '2024-09-01', 29.99, 300, '爱情, 社交', '2024-10-21 19:13:56', 0, '以伊丽莎白·班纳特和达西先生的爱情为主线');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (16, '1984', 6, '乔治·奥威尔', '中信出版社', '2024-08-01', 19.99, 200, '反乌托邦, 隐私', '2024-10-21 19:13:56', 0, '揭示了一个极权社会的恐怖面貌');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (17, '活着', 5, '余华', '作家出版社', '2024-07-01', 19.99, 200, '命运, 爱情', '2024-10-21 19:13:56', 0, '讲述了一个普通人在历经磨难后依然坚持活下去的故事');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (18, '追风筝的人', 7, '卡勒德·胡赛尼', '上海人民出版社', '2024-06-01', 29.99, 300, '友情, 救赎', '2024-10-21 19:13:56', 0, '以阿富汗少年阿米尔与哈桑之间的友情为主线');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (19, '局外人', 8, '阿尔贝·加缪', '人民文学出版社', '2024-05-01', 19.99, 200, '无情, 社会', '2024-10-21 19:13:56', 0, '描述了一个对社会和人生毫无兴趣的人的故事');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (20, '小王子', 2, '安东尼·德·圣-埃克苏佩里', '人民文学出版社', '2024-04-01', 19.99, 200, '童话, 友谊', '2024-10-21 19:13:56', 0, '以小王子的冒险经历讲述了关于友谊、爱和人性的哲理');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (21, '呼啸山庄', 1, '艾米莉·勃朗特', '人民文学出版社', '2024-03-01', 29.99, 300, '爱情, 家族', '2024-10-21 19:13:56', 0, '以希思克利夫和凯瑟琳之间的爱情为核心');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (22, '1984', 4, '乔治·奥威尔', '人民文学出版社', '2020-12-01', 29.99, 300, '思想警察, 民主', '2024-10-21 19:13:56', 0, '预言了一个极权统治的未来社会');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (23, '人间失格', 2, '太宰治', '新潮社', '2021-01-01', 19.99, 200, '人生, 失败', '2024-10-21 19:13:56', 0, '反映了日本战后社会的失落与绝望');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (24, '飘', 1, '玛格丽特·米切尔', '上海译文出版社', '2021-02-01', 39.99, 400, '斯嘉丽, 性格', '2024-10-21 19:13:56', 0, '描绘了美国南方的风情和历史');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (25, '人性的弱点', 6, '戴尔·卡耐基', '湖南人民出版社', '2021-03-01', 49.99, 500, '人际关系, 成功', '2024-10-21 19:13:56', 0, '探讨了人性中的弱点和人际关系的技巧');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (26, '失落的一代', 5, '欧内斯特·海明威', '广西师范大学出版社', '2021-04-01', 59.99, 600, '战争, 迷失', '2024-10-21 19:13:56', 0, '描绘了战后世界的迷茫和沉寂');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (27, '白鹿原', 3, '陈忠实', '人民文学出版社', '2021-05-01', 69.99, 700, '白鹿, 世代', '2024-10-21 19:13:56', 0, '讲述了中国北方一个山村的沉浮变迁');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (28, '悲惨世界', 4, '雨果', '北京十月文艺出版社', '2021-06-01', 79.99, 800, '浪漫, 励志', '2024-10-21 19:13:56', 0, '描绘了法国19世纪社会的黑暗与光明');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (29, '傲慢与偏见', 1, '简·奥斯汀', '上海译文出版社', '2021-07-01', 89.99, 900, '伊丽莎白, 礼仪', '2024-10-21 19:13:56', 0, '反映了英国乡村社会的风情和礼仪');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (30, '福尔摩斯探案集', 2, '柯南·道尔', '人民文学出版社', '2021-08-01', 99.99, 1000, '福尔摩斯, 探案', '2024-10-21 19:13:56', 0, '收录了福尔摩斯各种探案故事');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (31, '百合花开的季节', 3, '夏目漱石', '人民文学出版社', '2021-09-01', 109.99, 1100, '文学, 日本', '2024-10-21 19:13:56', 0, '描绘了日本明治时代的社会变迁');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (32, '时间的礼物', 4, '米切尔·阿尔班', '人民文学出版社', '2021-10-01', 119.99, 1200, '家庭, 爱情', '2024-10-21 19:13:56', 0, '讲述了一个家庭在时间中的坚守与成长');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (33, '格林童话', 5, '格林兄弟', '上海人民出版社', '2021-11-01', 129.99, 1300, '童话, 想象', '2024-10-21 19:13:56', 0, '收录了格林童话中的经典故事');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (34, '唐诗三百首', 6, '佚名', '北京出版社', '2021-12-01', 139.99, 1400, '诗歌, 唐代', '2024-10-21 19:13:56', 0, '是中国古代诗歌的经典之作');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (35, '呼啸山庄', 7, '艾米莉·勃朗特', '人民文学出版社', '2022-01-01', 149.99, 1500, '家族, 爱情', '2024-10-21 19:13:56', 0, '描绘了一个英国乡村家族的传奇故事');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (36, '约翰·克利斯朵夫', 8, '赫尔曼·梅尔维尔', '上海译文出版社', '2022-02-01', 159.99, 1600, '船长, 白鲸', '2024-10-21 19:13:56', 0, '反映了人性的黑暗与光明');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (37, '白夜行', 1, '东野圭吾', '南海出版公司', '2022-03-01', 169.99, 1700, '谋杀, 悬疑', '2024-10-21 19:13:56', 0, '描绘了一个谋杀案的复杂心理');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (38, '红拂夜奔', 2, '王小波', '作家出版社', '2022-04-01', 179.99, 1800, '红拂, 革命', '2024-10-21 19:13:56', 0, '讲述了一个女性的革命传奇');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (39, '罗生门', 3, '芥川龙之介', '上海译文出版社', '2022-05-01', 189.99, 1900, '罗生门, 短篇小说', '2024-10-21 19:13:56', 0, '描绘了日本战国时代的黑暗与矛盾');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (40, '明朝那些事儿', 4, '当年明月', '湖南文艺出版社', '2022-06-01', 199.99, 2000, '明朝, 历史', '2024-10-21 19:13:56', 0, '以幽默的笔触讲述了明朝历史上的种种趣事');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (41, '地下铁', 5, '达什·卡尔', '上海译文出版社', '2022-07-01', 209.99, 2100, '地下, 生存', '2024-10-21 19:13:56', 0, '描绘了地下铁隧道中的生存与抗争');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (42, '一个陌生女人的来信', 6, '斯蒂芬·茨威格', '上海译文出版社', '2022-08-01', 219.99, 2200, '爱情, 来信', '2024-10-21 19:13:56', 0, '讲述了一段不为人知的爱情故事');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (43, '边城', 7, '沈从文', '人民文学出版社', '2022-09-01', 229.99, 2300, '爱情, 乡土', '2024-10-21 19:13:56', 0, '描绘了中国南方边陲的风土人情');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (44, '追风筝的人', 8, '卡勒德·胡赛尼', '上海人民出版社', '2022-10-01', 239.99, 2400, '阿富汗, 友谊', '2024-10-21 19:13:56', 0, '讲述了一个阿富汗男孩的成长与命运');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (45, '白鹿原', 1, '陈忠实', '人民文学出版社', '2022-11-01', 249.99, 2500, '白鹿, 世代', '2024-10-21 19:13:56', 0, '讲述了中国北方一个山村的沉浮变迁');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (46, '飞鸟集', 2, '泰戈尔', '人民文学出版社', '2022-12-01', 259.99, 2600, '诗歌, 印度', '2024-10-21 19:13:56', 0, '是诺贝尔文学奖得主泰戈尔的代表作');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (47, '围城', 3, '钱钟书', '人民文学出版社', '2023-01-01', 269.99, 2700, '方鸿渐, 孙小姐', '2024-10-21 19:13:56', 0, '描写了知识分子的迷茫和困境');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (48, '福尔摩斯探案集', 4, '柯南·道尔', '人民文学出版社', '2023-02-01', 279.99, 2800, '福尔摩斯, 探案', '2024-10-21 19:13:56', 0, '收录了福尔摩斯各种探案故事');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (49, '红楼梦', 5, '曹雪芹', '人民文学出版社', '2023-03-01', 289.99, 2900, '贾宝玉, 林黛玉', '2024-10-21 19:13:56', 0, '描写了贾宝玉和林黛玉的爱情故事');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (50, '活着', 6, '余华', '作家出版社', '2023-04-01', 299.99, 3000, '福贵, 小福子', '2024-10-21 19:13:56', 0, '生动地描绘了一个农民的一生');
INSERT INTO librarymanagement.book (id, name, category_id, author, press, publish_date, price, page_number, keywords, create_time, status, notes) VALUES (51, '百年孤独', 7, '加西亚·马尔克斯', '南海出版公司', '2023-05-01', 309.99, 3100, '布恩迪亚家族, 马奎斯', '2024-10-21 19:13:56', 0, '以布恩迪亚家族七代人的故事为主线');

INSERT INTO librarymanagement.lend_return (id, r_id, b_id, lend_date, return_date, status, notes) VALUES (1, 3, 4, '2024-10-23', '2024-10-23', 1, '无');
INSERT INTO librarymanagement.lend_return (id, r_id, b_id, lend_date, return_date, status, notes) VALUES (2, 2, 1, '2024-10-23', '2024-10-24', 1, '');
INSERT INTO librarymanagement.lend_return (id, r_id, b_id, lend_date, return_date, status, notes) VALUES (3, 3, 2, '2024-10-23', '2024-10-23', 1, '无');
INSERT INTO librarymanagement.lend_return (id, r_id, b_id, lend_date, return_date, status, notes) VALUES (4, 3, 3, '2024-10-23', '2024-10-23', 1, '无');
INSERT INTO librarymanagement.lend_return (id, r_id, b_id, lend_date, return_date, status, notes) VALUES (5, 3, 2, '2024-10-23', '2024-10-23', 1, null);
INSERT INTO librarymanagement.lend_return (id, r_id, b_id, lend_date, return_date, status, notes) VALUES (6, 5, 4, '2024-10-24', null, 0, null);

INSERT INTO librarymanagement.r_category (id, name, amount, lend_period, effect_period, notes) VALUES (1, 'VIP', 10, 10, '2024-11-30', '无');

INSERT INTO librarymanagement.user (id, name, password, role, category_id, sex, address, phone, email, notes, create_time) VALUES (1, 'admin', '25d55ad283aa400af464c76d713c07ad', 'ADMIN', 1, 1, '南京', '12335563', '1765393959@qq.com', '42', '2024-10-23 15:49:04');
INSERT INTO librarymanagement.user (id, name, password, role, category_id, sex, address, phone, email, notes, create_time) VALUES (2, 'user', 'e10adc3949ba59abbe56e057f20f883e', 'USER', 1, 1, '武汉', '12348293', '2832u83@qq.com', '无', '2024-10-23 15:49:04');
INSERT INTO librarymanagement.user (id, name, password, role, category_id, sex, address, phone, email, notes, create_time) VALUES (3, 'burger', 'e10adc3949ba59abbe56e057f20f883e', 'USER', 1, 0, '武汉', '12348293', '2832u83@qq.com', '无', '2024-10-23 15:49:04');
INSERT INTO librarymanagement.user (id, name, password, role, category_id, sex, address, phone, email, notes, create_time) VALUES (4, 'xiaozhao', 'e10adc3949ba59abbe56e057f20f883e', 'USER', 1, 1, '南京', '12456633', '34412@qq.com', '无123', '2024-10-24 12:45:46');
INSERT INTO librarymanagement.user (id, name, password, role, category_id, sex, address, phone, email, notes, create_time) VALUES (5, 'xiaohe', 'e10adc3949ba59abbe56e057f20f883e', 'USER', 1, 1, '淮安', '38419194', '234349405@example.com', '无', '2024-10-24 12:51:32');

select distinct name from book;