package com.wb.hb.common;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import com.wb.hb.bible.dao.BibleDAO;
import com.wb.hb.bible.model.Bible;

public class SessionFactory {
/*
	public void session() {
		String resource = "src/main/resource/mybatis-config.xml";
		SqlSession  session = null;
		
		try {
			InputStream inputStream = Resources.getResourceAsStream(resource);
			SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
			
			session = sqlSessionFactory.openSession(false);
			
		}catch(IOException e) {
			e.printStackTrace();
			return;
		}
		
		HashMap<String,String> input = new HashMap<String, String>();
		input.put("version", "새번역");
		input.put("type", "AD");
		List<HashMap<String,String>> outputs = session.selectList("sqlBibleMapper.selectGospel",input);
		
		System.out.println(outputs.get(1));
		
		session.commit();
		session.close();
	}
*/
}
