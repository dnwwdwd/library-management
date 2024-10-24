import request from '@/utils/request' // 引入自定义的axios函数

/**
 * 登录接口（这是JSDoc注释）
 * @param {*} param0 {username: 用户名, password: 密码}
 * @returns Promise对象
 */
export const loginAPI = (params: any) => {
  return request({
    url: '/user/login',
    method: 'post',
    data: { ...params }
  })
}

/**
 * 注册接口
 * @param params 
 * @returns 
 */
export const registerAPI = (params: any) => {
  console.log(params)
  console.log({ ...params })
  return request({
    url: '/user/register',
    method: 'post',
    data: { ...params }
  })
}

/**
 * 更新读者信息
 * @param params
 * @returns
 */
export const updateReaderAPI = (params: any) => {
  console.log(params)
  console.log({ ...params })
  return request({
    url: '/user/update',
    method: 'post',
    data: { ...params }
  })
}

/**
 * 修改个人信息接口
 * @returns
 */
export const updateAPI = (params: any) => {
  console.log('修改密码')
  return request({
    url: '/user/update/my',
    method: 'post',
    data: { ...params }
  })
}

/**
 * 分页获取所有读者数据
 * @param params 分页查询的条件
 * @returns
 */
export const getReaderPageAPI = (params: any) => {
  console.log(params)
  return request({
    url: '/user/page',
    method: 'get',
    params
  })
}

/**
 * 新增读者
 * @param params
 * @returns
 */
export const addReaderAPI = (params: any) => {
  console.log(params)
  return request({
    url: '/user/add',
    method: 'post',
    data: params
  })
}

/**
 * 根据id获取读者信息
 * @param id
 * @returns
 */
export const getUserByIdAPI = (id: number) => {
  return request({
    url: `/user/${id}`,
    method: 'get',
  })
}

/**
 * 根据ids批量删除读者信息
 * @param ids
 * @returns
 */
export const deleteReadersAPI = (ids: string) => {
  return request({
    url: '/user/delete',
    method: 'post',
    params: { ids }
  })
}

export const sealReadersAPI = (ids: string) => {
  return request({
    url: '/user/seal',
    method: 'post',
    params: { ids }
  })
}

export const unsealReadersAPI = (ids: string) => {
  return request({
    url: '/user/unseal',
    method: 'post',
    params: { ids }
  })
}

export const getCurrentUser = () => {
  return request({
    url: '/user/current',
    method: 'get',
  })
}

/**
 * 根据id获取读者信息
 * @param id
 * @returns
 */
export const getReaderByIdAPI = (id: number) => {
  return request({
    url: `/user/${id}`,
    method: 'get',
  })
}
