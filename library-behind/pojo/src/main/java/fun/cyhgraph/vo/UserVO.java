package fun.cyhgraph.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class UserVO {
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

    private boolean isSealed;

    public boolean isSealed() {
        return isSealed;
    }

    public void setSealed(boolean sealed) {
        isSealed = sealed;
    }

    private static final long serialVersionUID = 1L;
}
