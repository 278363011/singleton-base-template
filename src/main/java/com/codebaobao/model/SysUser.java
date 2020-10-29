package com.codebaobao.model;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;
import java.util.Set;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 
 * </p>
 *
 * @author codebaobao
 * @since 2020-10-29
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SysUser extends Model<SysUser> {

    private static final long serialVersionUID = 1L;

    /**
     * 主键自增ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 账号
     */
    private String account;

    /**
     * 密码
     */
    private String password;

    /**
     * 密码盐
     */
    private String salt;

    /**
     * 用户名字
     */
    private String name;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 手机号
     */
    private String phone;

    /**
     * 头像地址
     */
    private String avatar;

    /**
     * 性别 1男 2女
     */
    private String sex;

    /**
     * 创建者
     */
    @TableField("createUserId")
    private Integer createUserId;

    /**
     * 租户ID
     */
    private Integer tenantId;

    /**
     * 实名制信息ID
     */
    private Integer realNameId;

    /**
     * 0-非实名制，1-实名制
     */
    private String realNameFlag;

    /**
     * 备注
     */
    private String remark;

    /**
     * 0-待审核 ，1-正常，2-锁定
     */
    private String lockFlag;

    /**
     * 0-正常，1-逻辑删除
     */
    private Integer delFlag;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 修改时间
     */
    private LocalDateTime updateTime;

    /**
     * 用户对应的角色集合
     */
    private Set<SysRole> roles;


    @Override
    protected Serializable pkVal() {
        return this.id;
    }

}
