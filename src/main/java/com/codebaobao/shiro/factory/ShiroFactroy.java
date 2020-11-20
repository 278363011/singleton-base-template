package com.codebaobao.shiro.factory;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.codebaobao.dto.RoleByUserIdVo;
import com.codebaobao.exception.user.UserAccountException;
import com.codebaobao.mapper.SysApiMapper;
import com.codebaobao.mapper.SysMenuMapper;
import com.codebaobao.mapper.SysRoleMapper;
import com.codebaobao.mapper.SysUserMapper;
import com.codebaobao.model.SysUser;
import com.codebaobao.shiro.model.ShiroUser;
import com.codebaobao.shiro.utils.ShiroKit;
import com.codebaobao.shiro.utils.UserDelStatus;
import com.codebaobao.shiro.utils.UserStatus;
import com.codebaobao.utils.SpringContextHolder;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.Authenticator;
import org.apache.shiro.authc.CredentialsException;
import org.apache.shiro.authc.LogoutAware;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.session.Session;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.apache.shiro.util.ByteSource;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.crazycake.shiro.RedisCacheManager;
import org.crazycake.shiro.RedisSessionDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.DependsOn;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
@DependsOn("springContextHolder")
@Transactional(readOnly = true)
public class ShiroFactroy implements IShiro {

    /**
     * 用户服务
     */
    @Autowired
    SysUserMapper sysUserMapper;

    /**
     * 用户角色服务
     */
    @Autowired
    SysRoleMapper sysRoleMapper;

    /**
     * API服务
     */
    @Autowired
    SysApiMapper sysApiMapper;

    /**
     * 菜单服务
     */
    @Autowired
    SysMenuMapper sysMenuMapper;


    public static IShiro me() {
        return SpringContextHolder.getBean(IShiro.class);
    }



    @Override
    public SysUser user(String account) {

        SysUser user = sysUserMapper.selectOne(new QueryWrapper<SysUser>().eq("account", account));
        // 账号不存在
        if (null == user) {
            throw new CredentialsException();
        }

        // 账号被封
        if(user.getDelFlag() == UserDelStatus.IS_DEL.getCode()){
            throw new UserAccountException(UserDelStatus.IS_DEL.getMessage());
        }

        // 账号被冻结
        if (StringUtils.equalsIgnoreCase(user.getLockFlag(), UserStatus.FREEZED.getCode())) {
            throw new UserAccountException(UserStatus.FREEZED.getMessage());
        }

        // 账号暂未通过审核
        if (StringUtils.equalsIgnoreCase(user.getLockFlag(),UserStatus.UN_APPROVAL.getCode())) {
            throw new UserAccountException(UserStatus.UN_APPROVAL.getMessage());
        }

        // 账号过期
        if (StringUtils.equalsIgnoreCase(user.getLockFlag(),UserStatus.EXPIRE.getCode())) {
            throw new UserAccountException(UserStatus.EXPIRE.getMessage());
        }

        return user;
    }

    @Override
    public ShiroUser shiroUser(SysUser user) {

        ShiroUser.ShiroUserBuilder userBuilder = ShiroUser.builder()
                .id(user.getId())// 主键ID
                .account(user.getAccount())// 账号
                .name(user.getName());// 姓名

        List<RoleByUserIdVo> roleInfoByUserId = sysRoleMapper.findRoleInfoByUserId(user.getId());
        List<Integer> roleList = roleInfoByUserId.stream().map(RoleByUserIdVo::getRid).collect(Collectors.toList());
        List<String> roleNameList = roleInfoByUserId.stream().map(RoleByUserIdVo::getRName).collect(Collectors.toList());

        userBuilder.roleList(roleList) // 角色集
                .roleNames(roleNameList);  // 角色名称集

        return userBuilder.build();
    }

    /**
     * 根据角色ID查找API 权限
     */
    @Override
    public List<String> findApiPermissionsByRoleId(Integer roleId) {
        return sysApiMapper.findApiPermissionsByRoleId(roleId);
    }
    /**
     * 根据角色ID查找菜单 权限
     */
    @Override
    public List<String> findMenuPermissionsByRoleId(Integer roleId)
    {
        return sysMenuMapper.findMenuPermissionsByRoleId(roleId);
    }
    /**
     * 根据用户ID查找所拥有的所有角色
     */
    @Override
    public List<RoleByUserIdVo> findRoleInfoByUserId(Integer uid) {
        return sysRoleMapper.findRoleInfoByUserId(uid);
    }

    /**
     * 组装认证SimpleAuthenticationInfo -》pripical
     */
    @Override
    public SimpleAuthenticationInfo info(ShiroUser shiroUser, SysUser user, String realmName) {
        // 数据库明文密码
        String credentials = user.getPassword();
        // 数据库密码盐
        String source = user.getSalt();
        //MD5方式加密
        ByteSource credentialsSalt = new Md5Hash(source);
        return new SimpleAuthenticationInfo(shiroUser, credentials, credentialsSalt, realmName);
    }
    /**
     *加载所有权限
     */
    @Override
    public Map<String, String> loadFilterChainDefinitionMap() {
        return null;
    }
    /**
     *更新权限
     */
    @Override
    public void updatePermission(ShiroFilterFactoryBean shiroFilterFactoryBean, Integer roleId, Boolean isRemoveSession) {

    }
    /**
     *通过角色ID更新权限
     */
    @Override
    public void updatePermissionByRoleId(Integer roleId, Boolean isRemoveSession) {

    }

    /**
     * 获取redisSessionDao 可自由控制
     */
    public static RedisSessionDAO getRedisSessionDAO(){
        return SpringContextHolder.getBean(RedisSessionDAO.class);
    }

    /**
     * 所有所有缓存
     */
    public static RedisCacheManager getRedisCacheManager(){
        return SpringContextHolder.getBean(RedisCacheManager.class);
    }



    /**
     * 从缓存中获取指定用户名的Session
     * @param username
     */
    private static Session getSessionByUsername(String username){
        // 获取当前已登录的用户session列表
        Collection<Session> sessions = getRedisSessionDAO().getActiveSessions();
        ShiroUser shiroUser;
        Object attribute;
        // 遍历Session,找到该用户名称对应的Session
        for(Session session : sessions){
            attribute = session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
            if (attribute == null) {
                continue;
            }
            shiroUser = (ShiroUser) ((SimplePrincipalCollection) attribute).getPrimaryPrincipal();
            if (shiroUser == null) {
                continue;
            }
            if (Objects.equals(shiroUser.getName(), username)) {
                return session;
            }
        }
        return null;
    }

    /**
     * 获取当前的所有active session
     */
    public static Collection<Session> getCurrentAllSessions(){
        // 获取当前已登录的用户session列表
        RedisSessionDAO redisSessionDAO = getRedisSessionDAO();
        Collection<Session> activeSessions = redisSessionDAO.getActiveSessions();
        return activeSessions;
    }


    /**
     * 删除用户缓存信息
     * @Param  username  用户名称
     * @Param  isRemoveSession 是否删除Session，删除后用户需重新登录
     */
    public static void deleteCache(String username, boolean isRemoveSession){
        //从缓存中获取Session
        Session session = null;
        // 获取当前已登录的用户session列表
        Collection<Session> sessions = getRedisSessionDAO().getActiveSessions();
        ShiroUser shiroUser;
        Object attribute = null;
        // 遍历Session,找到该用户名称对应的Session
        for(Session sessionInfo : sessions){
            attribute = sessionInfo.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
            if (attribute == null) {
                continue;
            }
            shiroUser = (ShiroUser) ((SimplePrincipalCollection) attribute).getPrimaryPrincipal();
            if (shiroUser == null) {
                continue;
            }
            if (Objects.equals(shiroUser.getName(), username)) {
                session=sessionInfo;
                // 清除该用户以前登录时保存的session，强制退出  -> 单用户登录处理
                if (isRemoveSession) {
                    getRedisSessionDAO().delete(session);
                }
            }
        }

        if (session == null||attribute == null) {
            return;
        }
        //删除session
        if (isRemoveSession) {
            getRedisSessionDAO().delete(session);
        }
        //删除Cache，再访问受限接口时会重新授权
        DefaultWebSecurityManager securityManager = (DefaultWebSecurityManager) SecurityUtils.getSecurityManager();
        Authenticator authc = securityManager.getAuthenticator();
        ((LogoutAware) authc).onLogout((SimplePrincipalCollection) attribute);
    }






    /**
     *
     */
    public static void main(String[] args) {

        String admin = ShiroKit.md5("admin", "8pgby");

        System.out.println(admin);
    }

}
