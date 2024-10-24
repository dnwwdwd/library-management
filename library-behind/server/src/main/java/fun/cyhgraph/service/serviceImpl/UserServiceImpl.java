package fun.cyhgraph.service.serviceImpl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import fun.cyhgraph.constant.UserConstant;
import fun.cyhgraph.context.BaseContext;
import fun.cyhgraph.dto.UserDTO;
import fun.cyhgraph.dto.UserLoginDTO;
import fun.cyhgraph.dto.UserPageDTO;
import fun.cyhgraph.entity.User;
import fun.cyhgraph.exception.BaseException;
import fun.cyhgraph.exception.PasswordErrorException;
import fun.cyhgraph.exception.UserNotFoundException;
import fun.cyhgraph.mapper.UserMapper;
import fun.cyhgraph.result.PageResult;
import fun.cyhgraph.service.UserService;
import fun.cyhgraph.vo.UserVO;
import jakarta.annotation.Resource;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;

    /**
     * 根据id获取用户信息
     *
     * @return
     */
    public User getUserById(Integer id) {
        User user = userMapper.getUserById(id);
        return user;
    }

    /**
     * 用户登录
     *
     * @param userLoginDTO
     * @return
     */
    public User login(UserLoginDTO userLoginDTO) {
        String name = userLoginDTO.getName();
        String password = userLoginDTO.getPassword();
        // 先查数据库，看是否存在该账号
        User user = userMapper.getUserByName(name);
        if (user == null) {
            throw new UserNotFoundException(UserConstant.USER_NOT_FOUND);
        }
        // 再将前端传过来的密码进行MD5加密
        password = DigestUtils.md5DigestAsHex(password.getBytes());
        // 和之前存进数据库的加密的密码进行比对，看看是否一样，不一样要抛异常
        if (!password.equals(user.getPassword())) {
            throw new PasswordErrorException(UserConstant.PASSWORD_ERROR);
        }
        return user;
    }

    /**
     * 注册/新增用户
     */
    public void register(UserLoginDTO userLoginDTO) {
        if (StringUtils.isEmpty(userLoginDTO.getName())) {
            throw new BaseException("账号未填写");
        }
        // 先对用户的密码进行MD5加密，再存到数据库中
        String password = userLoginDTO.getPassword();
        password = DigestUtils.md5DigestAsHex(password.getBytes());
        userLoginDTO.setPassword(password);
        User user = new User();
        // 将userLoginDTO的属性拷贝到user中
        BeanUtils.copyProperties(userLoginDTO, user);
        user.setRole("USER");
        userMapper.insert(user);
    }

    /**
     * 修改管理员信息
     *
     * @param userDTO
     */
    public void update(UserDTO userDTO) {
        // 根据id查询当前账号信息
        Integer id = BaseContext.getCurrentId();
        User user = userMapper.getUserById(id);
        BeanUtils.copyProperties(userDTO, user);
        if (!StringUtils.isEmpty(userDTO.getOldPwd()) && !StringUtils.isEmpty(userDTO.getNewPwd())) {
            String oldPwd = userDTO.getOldPwd();
            // 将前端传过来的旧密码进行MD5加密
            oldPwd = DigestUtils.md5DigestAsHex(oldPwd.getBytes());
            // 和之前存进数据库的加密的密码进行比对，看看是否一样，不一样要抛异常
            if (!oldPwd.equals(user.getPassword())) {
                throw new PasswordErrorException(UserConstant.PASSWORD_ERROR);
            }
            // 旧密码正确，将用户名修改，新密码加密后，进行更新
            user.setName(userDTO.getName());
            String newPwd = userDTO.getNewPwd();
            String password = DigestUtils.md5DigestAsHex(newPwd.getBytes());
            user.setPassword(password);
        }
        userMapper.updateByPrimaryKey(user);
    }

    @Override
    public void updateUser(UserDTO userDTO) {
        Integer loginUserId = BaseContext.getCurrentId();
        if (!isAdmin(loginUserId)) {
            throw new BaseException("您不是管理员，无法修改用户信息");
        }
        User user = new User();
        BeanUtils.copyProperties(userDTO, user);
        userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public PageResult page(UserPageDTO userPageDTO) {
        PageHelper.startPage(userPageDTO.getPage(), userPageDTO.getPageSize());
        Page<User> userPage = userMapper.pageReader(userPageDTO);
        List<UserVO> userVOList = new ArrayList<>();
        userPage.getResult().forEach(user -> {
            UserVO userVO = new UserVO();  // 创建 UserVO 对象
            BeanUtils.copyProperties(user, userVO);
            boolean isSealed = isSealed(user.getId());
            userVO.setSealed(isSealed);
            // 将 UserVO 添加到列表
            userVOList.add(userVO);
        });
        return new PageResult(userPage.getTotal(), userVOList);
    }

    @Override
    public boolean isAdmin(Integer id) {
        User user = getUserById(id);
        return "ADMIN".equals(user.getRole());
    }

    @Override
    public void sealUser(int userId) {
        Integer loginUserId = BaseContext.getCurrentId();
        if (!isAdmin(loginUserId)) {
            throw new BaseException("您不是管理员，无法封禁用户");
        }
        userMapper.sealUser(userId);
    }

    @Override
    public void unsealUser(int userId) {
        Integer loginUserId = BaseContext.getCurrentId();
        if (!isAdmin(loginUserId)) {
            throw new BaseException("您不是管理员，无法封禁用户");
        }
        userMapper.unsealUser(userId);
    }

    @Override
    public boolean isSealed(Integer id) {
        return "BAN".equals(userMapper.isSealed(id));
    }

    @Override
    public void deleteUsers(List<Integer> ids) {
        userMapper.deleteByIds(ids);
    }

    @Override
    public void sealUsers(List<Integer> idList) {
        userMapper.sealUsers(idList);
    }

    @Override
    public void unsealUsers(List<Integer> idList) {
        userMapper.unsealUsers(idList);
    }

    @Override
    public void addReader(User user) {
        String password = user.getPassword();
        password = DigestUtils.md5DigestAsHex(password.getBytes());
        user.setPassword(password);
        userMapper.insert(user);
    }
}
