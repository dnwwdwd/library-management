<script setup lang="ts" name="layout">
import {RouterView, useRouter, useRoute} from 'vue-router'
import {ElMessageBox, ElMessage} from 'element-plus'
import {useUserStore} from '@/store'

const userStore = useUserStore();
const router = useRouter();
const route = useRoute(); // 用于获取当前路由

// 管理员菜单
const adminMenuList = [
  {
    title: '数据统计',
    path: '/statistics',
    icon: 'pieChart',
  },
  {
    title: '图书分类',
    path: '/bookCategory',
    icon: 'memo',
  },
  {
    title: '图书列表',
    path: '/book',
    icon: 'collection',
  },
  {
    title: '读者分类',
    path: '/readerCategory',
    icon: 'postcard',
  },
  {
    title: '读者列表',
    path: '/reader',
    icon: 'user',
  },
  {
    title: '借书还书',
    path: '/lendReturn',
    icon: 'reading',
    children: [
      {
        subpath: '/lendReturn/add',
        title: '新增借书',
        icon: 'operation',
      },
      {
        subpath: '/lendReturn',
        title: '记录展示/还书',
        icon: 'tickets',
      }
    ]
  },
  {
    title: '个人设置',
    path: '/manager',
    icon: 'setting',
  },
];

// 普通用户菜单
const commonMenuList = [
  {
    title: '数据统计',
    path: '/statistics',
    icon: 'pieChart',
  },
  {
    title: '图书分类',
    path: '/bookCategory',
    icon: 'memo',
  },
  {
    title: '图书列表',
    path: '/book',
    icon: 'collection',
  },
  {
    title: '我的借阅',
    path: '/lendReturn/me',
    icon: 'user',
  },
  {
    title: '个人设置',
    path: '/manager',
    icon: 'setting',
  },
];

// 根据用户角色选择菜单
const menuList = userStore.userInfo?.role === 'ADMIN' ? adminMenuList : commonMenuList;

// 退出登录函数
const quitFn = () => {
  ElMessageBox.confirm(
      '你确定要退出登录吗？',
      {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
        type: 'warning',
      }
  )
      .then(() => {
        ElMessage({
          type: 'success',
          message: '退出成功',
        });
        userStore.userInfo = null;
        router.push('/login');
      })
      .catch(() => {
        ElMessage({
          type: 'info',
          message: '已取消退出',
        });
      });
};
</script>

<template>
  <div class="common-layout">
    <el-container>
      <el-header>
        <h1 class="h1">基于Vue+Spring Boot的图书管理系统网站设计</h1>
        <el-dropdown>
          <el-button type="primary">
            {{ userStore.userInfo ? userStore.userInfo.name : '未登录' }}
            <el-icon class="el-icon--right">
              <arrow-down/>
            </el-icon>
          </el-button>
          <template #dropdown>
            <el-dropdown-menu>
              <el-dropdown-item @click="quitFn">退出登录</el-dropdown-item>
            </el-dropdown-menu>
          </template>
        </el-dropdown>
      </el-header>
      <el-container class="sidebar">
        <!-- 侧边导航菜单区域 -->
        <el-menu
            :default-active="route.path"
            class="el-menu-vertical-demo"
            background-color="#556677"
            text-color="#fff"
            active-text-color="#ffd04b"
            unique-opened
            router>
          <!-- 遍历菜单项 -->
          <template v-for="item in menuList" :key="item.path">
            <el-menu-item v-if="!item.children" :index="item.path">
              <el-icon>
                <component :is="item.icon"/>
              </el-icon>
              <span>{{ item.title }}</span>
            </el-menu-item>
            <el-sub-menu v-else :index="item.path">
              <template #title>
                <el-icon>
                  <component :is="item.icon"/>
                </el-icon>
                <span>{{ item.title }}</span>
              </template>
              <el-menu-item v-for="obj in item.children" :index="obj.subpath" :key="obj.subpath">
                <el-icon>
                  <component :is="obj.icon"/>
                </el-icon>
                <span>{{ obj.title }}</span>
              </el-menu-item>
            </el-sub-menu>
          </template>
        </el-menu>
        <!-- 右侧内容和底部栏 -->
        <el-container class="mycontainer">
          <el-main>
            <router-view></router-view>
          </el-main>
          <el-footer>desgined by 赵伟杰</el-footer>
        </el-container>
      </el-container>
    </el-container>
  </div>
</template>

<style lang="less" scoped>
.common-layout {
  height: 100%;
  background-color: #eee;
}

.el-header {
  position: relative;
  background-color: #334455;
  color: #eeeeee;
  text-align: center;
  line-height: 60px;
  height: 8vh;
}

.h1 {
  display: inline-block;
  margin: 0;
  text-align: center;
  font-size: 24px;
}

.sidebar {
  display: flex;
  height: 92vh;
}

.el-dropdown {
  position: absolute;
  right: 0;

  .el-button {
    margin: 14px 40px;
    background-color: #22aaff;
    border-color: #22aaff;
    color: #fff;
  }
}

.el-menu {
  width: 200px;
  background-color: #445566;
}

.mycontainer {
  display: flex;
  flex: 6;
  flex-direction: column;
}

.el-main {
  flex: 1;
  padding: 0;
  background-color: #eeeeee;
  color: #333;
  text-align: center;
  line-height: 80px;
}

a {
  display: block;
  height: 5rem;
  color: rgb(0, 209, 118);
  font-size: 20px;
  font-weight: bold;
  text-decoration: none;
}

a:hover {
  background-color: rgb(87, 123, 108);
  color: #6bffce;
}

.el-footer {
  background-color: #ddd;
  font-size: 12px;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
