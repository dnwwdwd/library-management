package fun.cyhgraph.mapper;

import com.github.pagehelper.Page;
import fun.cyhgraph.dto.UserPageDTO;
import fun.cyhgraph.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface UserMapper {

    int deleteByPrimaryKey(Long id);

    int insert(User record);

    int insertSelective(User record);

    User getUserById(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    User getUserByName(String name);

    Page<User> pageReader(UserPageDTO userPageDTO);

    @Select("select count(id) from user where category_id = #{id}")
    Integer sumByCategoryId(Integer id);

    void sealUser(int userId);

    void unsealUser(int userId);

    String isSealed(Integer id);

    void deleteByIds(List<Integer> ids);

    void sealUsers(List<Integer> ids);

    void unsealUsers(List<Integer> ids);
}
