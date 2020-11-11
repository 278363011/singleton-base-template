package com.codebaobao.shiro.realm;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.codebaobao.mapper.SysWxuserMapper;
import com.codebaobao.model.SysWxuser;
import com.codebaobao.shiro.token.WxToken;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.realm.AuthenticatingRealm;
import org.springframework.beans.factory.annotation.Autowired;
import java.time.LocalDateTime;

public class WxRealm extends AuthenticatingRealm {

    @Autowired
    private SysWxuserMapper sysWxuserMapper;

    /**
     * 鉴权   openid 判断是否用户是否已经绑定微信
     * @param token
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {

        WxToken wxToken = (WxToken) token;
        String openId = wxToken.getOpenId();
        //sysUserDao.getbyWxaOpenId 根据openid查询是否有已绑定的userid,有就时已绑定

        SysWxuser sysWxuser =  sysWxuserMapper.selectOne(new QueryWrapper<SysWxuser>().eq("openid", openId));
        //已经注册.只更新下登录时间
        if (sysWxuser != null) {
            sysWxuser.setLastLogin(LocalDateTime.now());
            sysWxuserMapper.updateById(sysWxuser);
        }
        //没有注册的情况下，注册wxuser
        else {
            sysWxuser = wxToken.getUser();
            sysWxuserMapper.insert(sysWxuser);
        }
        return new SimpleAuthenticationInfo(sysWxuser, "ok", this.getClass().getSimpleName());
    }

    @Override
    public boolean supports(AuthenticationToken authenticationToken) {
        //设置此Realm支持的Token
        return authenticationToken != null && (authenticationToken instanceof WxToken);
    }

    @Override
    public String getName() {
        return "WxRealm";
    }

}
