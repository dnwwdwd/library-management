package fun.cyhgraph.service;

import fun.cyhgraph.dto.UserDTO;
import fun.cyhgraph.dto.UserLoginDTO;
import fun.cyhgraph.dto.UserPageDTO;
import fun.cyhgraph.entity.User;
import fun.cyhgraph.result.PageResult;

import java.util.List;

public interface UserService {
    User getUserById(Integer id);

    User login(UserLoginDTO  userLoginDTO);

    void register(UserLoginDTO userLoginDTO);

    void update(UserDTO userDTO);

    void updateUser(UserDTO userDTO);

    PageResult page(UserPageDTO userPageDTO);

    boolean isAdmin(Integer id);

    void sealUser(int userId);

    void unsealUser(int userId);

    boolean isSealed(Integer id);

    void deleteUsers(List<Integer> ids);

    void sealUsers(List<Integer> idList);

    void unsealUsers(List<Integer> idList);

    void addReader(User user);
}
