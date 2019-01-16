package junit.test;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.freemarker.bean.Attr;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;

public class FreemarkerTest {

	public static void main(String[] args) throws IOException, TemplateException {
		// 创建Freemarker对象的配置对象
		Configuration cfg = new Configuration();
		// 设定默认的位置（路径）
		cfg.setDirectoryForTemplateLoading(new File("D:\\ftl")); 
		cfg.setDefaultEncoding("UTF-8");
		cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);

		// 数据 - 数据模型
		Map paramMap = new HashMap();

		String className = "User";

		paramMap.put("packageName", "com.atguigu.crowdfunding");
		paramMap.put("className", className);
		
		
		List<Attr> attrList = new ArrayList<Attr>();
		
		Attr attr1 = new Attr();
		attr1.setName("username");
		attr1.setType("java.lang.String");
		
		Attr attr2 = new Attr();
		attr2.setName("password");
		attr2.setType("java.lang.String");
		
		attrList.add(attr1);
		attrList.add(attr2);
		
		paramMap.put("attrs", attrList);

		

		Template t = cfg.getTemplate("bean.ftl");

		// 组合生成
		Writer out = new OutputStreamWriter(new FileOutputStream(new File("D:\\User.java")), "UTF-8");
		// 执行
		t.process(paramMap, out);

	}

}
