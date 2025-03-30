package com.xxl.job.admin.controller.api;

import com.xxl.job.admin.controller.annotation.PermissionLimit;
import com.xxl.job.admin.controller.bean.LoginParameter;
import com.xxl.job.admin.service.LoginService;
import com.xxl.job.core.biz.model.ReturnT;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequiredArgsConstructor
class LoginController {

    private final LoginService loginService;

    @PostMapping(value = "/api/login")
    @PermissionLimit(limit = false)
    ReturnT<String> login(HttpServletRequest request, HttpServletResponse response, @RequestBody LoginParameter loginParameter) {
        return loginService.login(request, response, loginParameter.getUserName(), loginParameter.getPassword(), loginParameter.remember());
    }
}
