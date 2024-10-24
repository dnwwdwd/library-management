package fun.cyhgraph.controller;

import fun.cyhgraph.constant.JwtClaimsConstant;
import fun.cyhgraph.context.BaseContext;
import fun.cyhgraph.dto.UserDTO;
import fun.cyhgraph.dto.UserLoginDTO;
import fun.cyhgraph.dto.UserPageDTO;
import fun.cyhgraph.entity.User;
import fun.cyhgraph.properties.JwtProperties;
import fun.cyhgraph.result.PageResult;
import fun.cyhgraph.result.Result;
import fun.cyhgraph.service.UserService;
import fun.cyhgraph.utils.JwtUtil;
import fun.cyhgraph.vo.UserLoginVO;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@Slf4j
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService userService;

    @Resource
    private JwtProperties jwtProperties;

    /**
     * 根据id获取管理员信息
     *
     * @param id
     * @return
     */
    @GetMapping("/{id}")
    public Result<User> getUserById(@PathVariable Integer id) {
        User user = userService.getUserById(id);
        return Result.success(user);
    }

    /**
     * 管理员登录
     *
     * @param userLoginDTO
     * @return
     */
    @PostMapping("/login")
    public Result<UserLoginVO> login(@RequestBody UserLoginDTO userLoginDTO) {
        log.info("用户传过来的登录信息DTO:{}", userLoginDTO);
        User user = userService.login(userLoginDTO);
        // 上面的没抛异常，正常来到这里，说明登录成功
        // claims就是用户数据payload部分
        Map<String, Object> claims = new HashMap<>(); // jsonwebtoken包底层就是Map<String, Object>格式，不能修改！
        claims.put(JwtClaimsConstant.USER_ID, user.getId());
        // 需要加个token给他，再返回响应
        String token = JwtUtil.createJWT(
                jwtProperties.getUserSecretKey(),
                jwtProperties.getUserTtl(),
                claims);
        UserLoginVO userLoginVO = UserLoginVO.builder()
                .id(user.getId())
                .name(user.getName())
                .token(token)
                .role(user.getRole())
                .build();
        return Result.success(userLoginVO);
    }

    /**
     * 管理员注册（其实就是新增操作而已，和token什么的无关！）
     *
     * @param userLoginDTO
     * @return
     */
    @PostMapping("/register")
    public Result register(@RequestBody UserLoginDTO userLoginDTO) {
        log.info("用户传过来的注册信息(和登录格式一样的DTO):{}", userLoginDTO);
        userService.register(userLoginDTO);
        return Result.success();
    }

    /**
     * 修改个人信息
     *
     * @param userDTO
     * @return
     */
    @PostMapping("/update/my")
    public Result update(@RequestBody UserDTO userDTO) {
        log.info("修改后的用户信息：{}", userDTO);
        userService.update(userDTO);
        return Result.success();
    }

    @GetMapping("/page")
    public Result<PageResult> page(UserPageDTO userPageDTO) {
        log.info("用户传过来的分页查询参数：{}", userPageDTO);
        PageResult pageResult = userService.page(userPageDTO);
        return Result.success(pageResult);
    }

    @PostMapping("/update")
    public Result updateUser(@RequestBody UserDTO userDTO) {
        log.info("修改后的用户信息：{}", userDTO);
        userService.updateUser(userDTO);
        return Result.success();
    }

    @PostMapping("/seal")
    public Result sealUsers(@RequestParam String ids) {
        List<Integer> idList = Arrays.asList(ids.split(","))
                .stream()
                .map(Integer::parseInt)
                .toList();
        userService.sealUsers(idList);
        return Result.success();
    }

    @PostMapping("/unseal")
    public Result unsealUsers(@RequestParam String ids) {
        List<Integer> idList = Arrays.asList(ids.split(","))
                .stream()
                .map(Integer::parseInt)
                .toList();
        userService.unsealUsers(idList);
        return Result.success();
    }

    @PostMapping("/delete")
    public Result deleteReaders(@RequestParam String ids) {
        List<Integer> idList = Arrays.asList(ids.split(","))
                .stream()
                .map(Integer::parseInt)
                .toList();
        userService.deleteUsers(idList);
        return Result.success();
    }

    @GetMapping("/current")
    public Result<User> getCurrentUser() {
        return Result.success(userService.getUserById(BaseContext.getCurrentId()));
    }

    @PostMapping("/add")
    public Result addReader(@RequestBody User user) {
        userService.addReader(user);
        return Result.success();
    }

}
