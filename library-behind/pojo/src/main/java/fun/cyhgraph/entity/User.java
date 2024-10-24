package fun.cyhgraph.entity;

import java.io.Serializable;
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonProperty;
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
    private String name;

    /**
     * 密码
     */
    private String password;

    /**
     * 角色
     */
    private String role;

    private Integer sex;

    private String address;

    private String phone;

    private String email;

    private LocalDateTime createTime;

    private String notes;

    private Integer categoryId;

    private static final long serialVersionUID = 1L;
}