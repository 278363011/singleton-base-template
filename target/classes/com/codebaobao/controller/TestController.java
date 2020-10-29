package com.codebaobao.controller;


import com.codebaobao.service.SysMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {


    @Autowired
    SysMenuService sysMenuService;

    @RequestMapping("/test1")
    public  void test1(){
        sysMenuService.removeById(5);
    }

}
