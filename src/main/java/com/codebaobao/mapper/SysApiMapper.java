package com.codebaobao.mapper;

import com.codebaobao.model.SysApi;
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
public interface SysApiMapper extends BaseMapper<SysApi> {


    public List<String> findApiPermissionsByRoleId(Integer roleId);

}
