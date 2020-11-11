package com.codebaobao.mapper;

import com.codebaobao.dto.RoleByUserIdVo;
import com.codebaobao.model.SysRole;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author codebaobao
 * @since 2020-10-29
 */
@Mapper
public interface SysRoleMapper extends BaseMapper<SysRole> {

    public List<RoleByUserIdVo> findRoleInfoByUserId(Integer uid);

}
