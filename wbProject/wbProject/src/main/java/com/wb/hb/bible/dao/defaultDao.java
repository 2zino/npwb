package com.wb.hb.bible.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class defaultDao {
	@Autowired
	@Qualifier("sqlSession") //root-context.xml의 org.mybatis.spring.SqlSessionTemplate의 bean id와 해당 객체를 autowired시켜주기위함
	SqlSession sqlSession;
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String,String>> getType(HashMap<String,String> input) {
		return sqlSession.selectList("sqlBibleMapper.selectType",input);	
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String,String>> getVersion(HashMap<String,String> input) {
		return sqlSession.selectList("sqlBibleMapper.selectVersion",input);	
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String,String>> getContents(HashMap<String,String> input) {
		return sqlSession.selectList("sqlBibleMapper.selectContents",input);	
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String,String>> getChapter(HashMap<String,String> input) {
		return sqlSession.selectList("sqlBibleMapper.selectChapters",input);	
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String,String>> getTotalData(HashMap<String,String> input) {
		return sqlSession.selectList("sqlBibleMapper.selectTotal",input);	
	}
	
}
