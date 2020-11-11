package com.codebaobao.dto;

import lombok.Builder;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Builder
@Accessors
public class RoleByUserIdVo {
    private Integer rid;
    private String rName;
}
