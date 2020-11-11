package com.codebaobao.shiro.realm;

import com.codebaobao.model.SysUser;
import com.codebaobao.shiro.factory.IShiro;
import com.codebaobao.shiro.factory.ShiroFactroy;
import com.codebaobao.shiro.model.ShiroUser;
import com.codebaobao.shiro.token.AdminToken;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Slf4j
public class AdminRealm extends AuthorizingRealm {

    /**
     * 认证配置类
     *
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken){
        log.info("---------------- 执行 Shiro 凭证认证 ----------------------");
        //获取shiro user 处理工厂类
        IShiro shiroFactory = ShiroFactroy.me();
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
        //获取用户信息
        SysUser user = shiroFactory.user(token.getPrincipal().toString());
        //转换为ShiroUser
        ShiroUser shiroUser = shiroFactory.shiroUser(user);
        log.info("---------------- Shiro 凭证认证成功 ----------------------");
        //包装 SimpleAuthenticationInfo 信息
        return shiroFactory.info(shiroUser, user, super.getName());

    }



    /**
     * 权限配置类
     *
     * @param principals
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        log.info("---------------- 执行 Shiro 权限获取 ---------------------");
        IShiro shiroFactory = ShiroFactroy.me();
        ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();
        List<Integer> roleList = shiroUser.getRoleList();

        Set<String> apiPermissionSet = new HashSet<>();
        Set<String> menuPermissionSet = new HashSet<>();


        roleList.stream().forEach(item->{
            apiPermissionSet.addAll(shiroFactory.findApiPermissionsByRoleId(item));
            menuPermissionSet.addAll(shiroFactory.findMenuPermissionsByRoleId(item));
        });

        // 添加所有权限信息
        apiPermissionSet.addAll(menuPermissionSet);
        // 组装 SimpleAuthorizationInfo 对象
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.addStringPermissions(apiPermissionSet);
        info.addRoles(shiroUser.getRoleNames());

        log.info("---------------- 获取到以下权限 ----------------");
        log.info(info.getStringPermissions().toString());
        log.info("---------------- Shiro 权限获取成功 ----------------------");

        return info;
    }

    @Override
    public boolean supports(AuthenticationToken authenticationToken) {
        //设置此Realm支持的Token
        return authenticationToken != null && (authenticationToken instanceof AdminToken);
    }

    @Override
    public String getName() {
        return "AdminRealm";
    }




}

