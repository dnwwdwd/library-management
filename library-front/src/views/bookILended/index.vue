<script setup lang="ts">
import {reactive, ref} from 'vue'
import {getBorrowPageAPI, getMyBorrowPageAPI} from '@/api/lendReturn'
import {ElMessage, ElTable} from 'element-plus'
import {useRouter} from 'vue-router'
import {useUserStore} from "@/store";

const store = useUserStore();

const isAdmin = store.userInfo?.role === 'ADMIN';

// ------ .d.ts 属性类型接口 ------
// 接收到不在接口中定义的属性的数据，ts会报错，但是类型推断错误不会妨碍接收，控制台还是能打印的
interface LendReturn {
  id: number
  rId: number
  bId: number
  lendDate: string
  returnDate: string
  status: number
  notes: string
}

// ------ 数据 ------
// 当前页的借还书记录列表
const borrowList = ref<LendReturn[]>([])
// 分页参数
const pageData = reactive({
  rId: '',
  bId: '',
  notes: '',
  page: 1,
  pageSize: 6,
})
// const isValidForm = ref()
const total = ref(0)
const multiTableRef = ref<InstanceType<typeof ElTable>>()
const multiSelection = ref<LendReturn[]>([])

const statusList = [
  { id: 0, name: '出借中' },
  { id: 1, name: '正常归还' },
  { id: 2, name: '逾期归还' },
  { id: 3, name: '丢失无法归还' },
  { id: 4, name: '损坏归还' },
  { id: 5, name: '其他(备注说明)' },
]

// 初始化时分页查询借还书记录
const init = async () => {
  const { data: resultBorrow } = await getMyBorrowPageAPI(pageData)
  console.log(resultBorrow)
  borrowList.value = resultBorrow.data.records
  total.value = resultBorrow.data.total
  console.log(borrowList)
}
// 初始化
init()

const handleCurrentChange = (val: any) => {
  console.log(`当前页: ${val}`);
  init()
}
const handleSizeChange = (val: any) => {
  console.log(`每页 ${val} 条`);
  init()
}
const handleSelectionChange = (val: LendReturn[]) => {
  multiSelection.value = val
  console.log('value', val)
  console.log('multiSelection.value', multiSelection.value)
}

// 根据状态值返回对应的颜色
const getStatusColor = (status: number) => {
  // 0：出借中  1：正常归还  2：逾期归还  3：丢失无法归还  4：损坏归还  5：其他(见备注)
  switch (status) {
    case 0:
      return '#888888'
    case 1:
      return '#66cc88'
    case 2:
      return '#bbbb00'
    case 3:
      return '#ff0000'
    case 4:
      return '#ee8800'
    case 5:
      return '#0088ff'
    default:
      return 'black'
  }
}
// 模糊查询借还书记录列表
const search_btn = async () => {
  console.log('查询借还书记录的条件')
  console.log(pageData)
  const { data: res } = await getBorrowPageAPI(pageData)
  // 删除后刷新页面，更新数据
  console.log(res)
  borrowList.value = res.data.records
  total.value = res.data.total
  init()
}

// 修改借阅人(路径传参，到update页面后，根据id查询借阅人信息，回显到表单中)
const router = useRouter()
const update_btn = (row: any) => {
  console.log('要修改的行数据')
  console.log(row)
  router.push({
    name: 'lendReturnIUpdate',
    query: {
      id: row.id
    }
  })
}

</script>

<template>
  <el-card class="my-card">
    <div class="horizontal">
      <el-input style="width: 140px; margin: 20px" v-model="pageData.bId" class="input" placeholder="请输入书籍编号" />
      <el-input style="width: 200px; margin: 20px" v-model="pageData.notes" class="input" placeholder="请输入相关备注信息" />
      <el-button style="margin: 20px 30px; width:140px" round type="success" @click="search_btn()">查询借还书记录</el-button>
    </div>

    <el-table ref="multiTableRef" :data="borrowList" stripe border @selection-change="handleSelectionChange"
      style="width: 100%">
      <el-table-column prop="id" label="编号" width="60px" />
      <el-table-column prop="rId" label="借书人编号" width="100px" />
      <el-table-column prop="bId" label="书编号" width="90px" />
      <el-table-column prop="lendDate" label="借书日期" width="150px" />
      <el-table-column prop="returnDate" label="归还日期" width="150px" />
      <el-table-column prop="status" label="状态">
        <template #default="scope">
          <!-- 遍历categoryList，找到categoryId对应的name，  !.表示必然存在 -->
          <!-- {{ statusList.find(item => item.id === scope.row.status)!.name }} -->
          <span :style="{ color: getStatusColor(scope.row.status) }">
            {{ statusList.find(item => item.id === scope.row.status)?.name || '未归还'}}
          </span>
        </template>
      </el-table-column>
      <el-table-column prop="notes" label="备注" />
      <el-table-column label="操作" width="200px">
        <template #default="scope">
          <el-button @click="update_btn(scope.row)" type="primary" v-if="scope.row.status === 0">还书</el-button>
          <el-button @click="ElMessage({type: 'success', message: '您已归还该书籍！'})" type="warning" v-if="scope.row.status !== 0">已归还</el-button>
        </template>
      </el-table-column>
      <template #empty>
        <el-empty description=" 没有数据" />
      </template>
    </el-table>

    <el-pagination class="pagination" background layout="total, sizes, prev, pager, next, jumper" :total="total"
      :page-sizes="[2, 4, 6, 8]" v-model:current-page="pageData.page" v-model:page-size="pageData.pageSize"
      @current-change="handleCurrentChange" @size-change="handleSizeChange" />
  </el-card>
</template>

<style scoped></style>
