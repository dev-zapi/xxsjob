package com.xxl.job.admin.core.util;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

/**
 * Jackson util
 * <p>
 * 1、obj need private and set/get；
 * 2、do not support inner class；
 *
 * @author xuxueli 2015-9-25 18:02:56
 */
public class JacksonUtil {
    private static final Logger logger = LoggerFactory.getLogger(JacksonUtil.class);

    private final static ObjectMapper objectMapper = new ObjectMapper();

    /**
     * 获取 ObjectMapper 实例
     *
     * @return ObjectMapper 实例
     */
    public static ObjectMapper getInstance() {
        return objectMapper;
    }

    /**
     * 将对象转换为 JSON 字符串
     *
     * @param obj 需要转换的对象
     * @return JSON 字符串，如果转换失败则返回 null
     */
    public static String writeValueAsString(Object obj) {
        try {
            return getInstance().writeValueAsString(obj);
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 将 JSON 字符串转换为指定类型的对象
     *
     * @param jsonStr JSON 字符串
     * @param clazz 目标对象的类型
     * @param <T> 目标对象的泛型类型
     * @return 转换后的对象，如果转换失败则返回 null
     */
    public static <T> T readValue(String jsonStr, Class<T> clazz) {
        try {
            return getInstance().readValue(jsonStr, clazz);
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 将 JSON 字符串转换为指定类型的泛型对象（如 List<Bean>）
     *
     * @param jsonStr          JSON 字符串
     * @param parametrized     目标对象的泛型类型
     * @param parameterClasses 泛型参数的类型
     * @param <T>              目标对象的泛型类型
     * @return 转换后的对象，如果转换失败则返回 null
     */
    public static <T> T readValue(String jsonStr, Class<?> parametrized, Class<?>... parameterClasses) {
        try {
            JavaType javaType = getInstance().getTypeFactory().constructParametricType(parametrized, parameterClasses);
            return getInstance().readValue(jsonStr, javaType);
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        }
        return null;
    }
}
