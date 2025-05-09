package com.xxl.job.admin.controller.resolver;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xxl.job.admin.core.exception.XxlJobException;
import com.xxl.job.core.biz.model.ReturnT;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;

/**
 * common exception resolver
 *
 * @author xuxueli 2016-1-6 19:22:18
 */
@Component
@Slf4j
class WebExceptionResolver implements HandlerExceptionResolver {

	public static final MappingJackson2JsonView VIEW;

	static {
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSXXX"));
		VIEW = new MappingJackson2JsonView();
		VIEW.setExtractValueFromSingleKeyModel(true);
		VIEW.setObjectMapper(objectMapper);
	}

	@Override
	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {

		if (!(ex instanceof XxlJobException)) {
			log.error("Handler thrown exception, handler={}", handler, ex);
		}

		// if JSON
		boolean isJson = false;
		if (handler instanceof HandlerMethod) {
			HandlerMethod method = (HandlerMethod)handler;
			if (method.getMethodAnnotation(ResponseBody.class) != null) {
				isJson = true;
			} else {
				Class<?> beanType = method.getBeanType();
				if (beanType.isAnnotationPresent(ResponseBody.class) || beanType.isAnnotationPresent(RestController.class)) {
					isJson = true;
				}
			}
		}

		// error result
		ReturnT<String> errorResult = new ReturnT<>(ReturnT.FAIL_CODE, ex.toString().replaceAll("\n", "<br/>"));

		// response
		ModelAndView mv = new ModelAndView();
		if (isJson) {
			mv.setView(VIEW);
			mv.addObject("result", errorResult);
		} else {
			mv.addObject("exceptionMsg", errorResult.getMsg());
			mv.setViewName("/common/common.exception");
		}
		return mv;
	}

}
