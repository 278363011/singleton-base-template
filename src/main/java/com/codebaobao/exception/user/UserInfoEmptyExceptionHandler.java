package com.codebaobao.exception.user;


import com.codebaobao.result.CodeMsg;
import com.codebaobao.result.Result;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.AuthorizationException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class UserInfoEmptyExceptionHandler{



    @ExceptionHandler(UserAccountException.class)
    public Result<String> userInfoEmptyExceptionHandler(UserAccountException ex){
        return Result.success(ex.getMessage());
    }

    /**
     * shiro 用户名不存在异常
     * @param ex
     * @return
     */
    @ExceptionHandler(UnknownAccountException.class)
    public Result<String> unknownAccountExceptionHandler(UnknownAccountException ex){
        return Result.error(CodeMsg.create(100404, "用户名不存在！"));
    }

    /**
     * shiro 认证异常
     * @param ex
     * @return
     */
    @ExceptionHandler(AuthenticationException.class)
    public Result<String> authenticationExceptionHandler(AuthenticationException ex){
        return Result.error(CodeMsg.create(100500, "账号或密码错误！"));
    }

    /**
     * shiro没有权限异常
     * @param ex
     * @return
     */
    @ExceptionHandler(AuthorizationException.class)
    public Result<String> authorizationExceptionHandler(AuthorizationException ex){
        return Result.error(CodeMsg.create(100403,"没有认证权限！"));
    }
}
