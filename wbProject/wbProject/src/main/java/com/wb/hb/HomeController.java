package com.wb.hb;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.wb.hb.bible.dao.defaultDao;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@Autowired //Autowired해줘서 자동으로 스프링이 sqlSession를 매치시켜줌
	private defaultDao dao;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		HashMap<String,String> input = new HashMap<String, String>();
		input.put("version", "개역개정");
		input.put("type", "BC");
		
		List<HashMap<String,String>> sqlTest = dao.getGospel(input);
		logger.debug(sqlTest.toString());
		return "home";
	}
	
	@RequestMapping(value = "/main2.do", method = RequestMethod.GET)
	public String home2(Locale locale, Model model) throws ClassNotFoundException, SQLException {
		return "home";
	}
	
}
