package com.yx.codeutil;

import java.io.IOException;
import java.io.OutputStream;

public interface IVerifyCodeGen {

    /**
     * 生成验证码并返回code，将图片写到os中
     *
     * @param width
     * @param height
     * @param os
     * @return
     * @throws IOException
     */
    String generate(int width, int height, OutputStream os) throws IOException;

    /**
     * 生成验证码对象
     *
     * @param width
     * @param height
     * @return
     * @throws IOException
     */
    VerifyCode generate(int width, int height) throws IOException;
}
