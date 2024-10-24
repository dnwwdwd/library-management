package fun.cyhgraph.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDTO implements Serializable {

    private Integer id;

    private String name;

    private String oldPwd;

    private String newPwd;

    private String password;

    private String role;

    private Integer sex;

    private String address;

    private String phone;

    private String email;

    private String notes;

    private Integer categoryId;
}
