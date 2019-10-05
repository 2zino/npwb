package com.wb.hb.bible.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class testDao {

	@Autowired
	@Qualifier("sqlSession") //root-context.xml의 org.mybatis.spring.SqlSessionTemplate의 bean id와 해당 객체를 autowired시켜주기위함
	SqlSession sql;
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String,String>> getGospe() {
		HashMap<String,String> input = new HashMap<String, String>();
		input.put("version", "새번역");
		input.put("type", "AD");
		return sql.selectList("sqlBibleMapper.selectGospel",input);	
	}
	
}
