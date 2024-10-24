package generator.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * 用户表
 * @TableName user
 */
@Data
public class User implements Serializable {
    /**
     * id
     */
    private Integer id;

    /**
     * 账号
     */
    private String username;

    /**
     * 密码
     */
    private String password;

    /**
     * 角色
     */
    private String role;

    private static final long serialVersionUID = 1L;
}