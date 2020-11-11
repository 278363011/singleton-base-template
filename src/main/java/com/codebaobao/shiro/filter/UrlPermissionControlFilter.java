package com.codebaobao.shiro.filter;

import com.alibaba.fastjson.JSONObject;
import com.codebaobao.model.SysApi;
import com.codebaobao.result.CodeMsg;
import com.codebaobao.result.Result;
import com.codebaobao.shiro.model.ShiroUser;
import com.codebaobao.shiro.utils.ShiroKit;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.PathMatchingFilter;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.Objects;

public class UrlPermissionControlFilter extends PathMatchingFilter {


    @Override
    protected boolean onPreHandle(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {

        //请求的url
        String requestURL = getPathWithinApplication(request);
        System.out.println("请求的url :"+requestURL);
        Subject subject = ShiroKit.getSubject();;
        if (!subject.isAuthenticated()){
            // 如果没有登录, 直接返回true 进入登录流程
            return  true;
        }
        ShiroUser shiroUser = (ShiroUser) subject.getPrincipal();

        boolean hasPermission = false;
        if(Objects.isNull(shiroUser.getApiPermissions())){
            UnauthorizedException ex = new UnauthorizedException("当前用户没有访问路径" + requestURL + "的权限");
            HttpServletResponse httpServletResponse = (HttpServletResponse) response;
            httpServletResponse.setStatus(200);
            httpServletResponse.setContentType("application/json;charset=utf-8");
            PrintWriter out = httpServletResponse.getWriter();
            out.println(JSONObject.toJSON(Result.error(CodeMsg.create(10005,ex.getMessage()))));
            out.flush();
            out.close();
            return false;
        }
        for (SysApi sysApi : shiroUser.getApiPermissions()) {

            if (sysApi.getUrl().equals(requestURL)){
                hasPermission = true;
                break;
            }
        }
        if (hasPermission){
            return true;
        }else {

            UnauthorizedException ex = new UnauthorizedException("当前用户没有访问路径" + requestURL + "的权限");
            HttpServletResponse httpServletResponse = (HttpServletResponse) response;
            httpServletResponse.setStatus(200);
            httpServletResponse.setContentType("application/json;charset=utf-8");
            PrintWriter out = httpServletResponse.getWriter();
            out.println(JSONObject.toJSON(Result.error(CodeMsg.create(10005,ex.getMessage()))));
            out.flush();
            out.close();
            return false;
        }

    }
}
