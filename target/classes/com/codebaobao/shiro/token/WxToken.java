package com.codebaobao.shiro.token;

import com.codebaobao.model.SysWxuser;
import com.codebaobao.shiro.utils.Const;
import org.apache.shiro.authc.UsernamePasswordToken;

import java.io.Serializable;

public class WxToken extends UsernamePasswordToken implements Serializable {
    private static final long serialVersionUID = 4812793519945855483L;

    private SysWxuser sysWxuser;

    @Override
    public Object getPrincipal() {
        return getOpenId();
    }

    @Override
    public Object getCredentials() {
        return Const.WX_DEFAULT_PWD;
    }
    public WxToken(SysWxuser sysWxuser){
        this.sysWxuser=sysWxuser;
    }

    public String getOpenId() {
        return sysWxuser.getOpenid();
    }

    public SysWxuser getUser() {
        return sysWxuser;
    }
}
