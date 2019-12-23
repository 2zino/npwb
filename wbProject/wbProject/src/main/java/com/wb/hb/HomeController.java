package com.wb.hb;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
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
	 * @throws JsonProcessingException 
	 */
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, Model model) throws ClassNotFoundException, SQLException, JsonProcessingException {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("home");
		HashMap<String,String> input = new HashMap<String, String>();

		input.put("version", "개역개정");
		input.put("type", "BC");
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(dao.getTotalData(input));
		
		mv.addObject("totalList",jsonStr);

		return mv;
	}
	
	@RequestMapping(value = "/main2.do", method = RequestMethod.GET)
	public ModelAndView home2(Locale locale, Model model) throws ClassNotFoundException, SQLException, JsonProcessingException {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("home2");
		HashMap<String,String> input = new HashMap<String, String>();

		input.put("version", "개역개정");
		input.put("type", "BC");
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(dao.getTotalData(input));
		
		mv.addObject("totalList",jsonStr);
		
		return mv;
	}
	
	@RequestMapping(value = "/getBible.do", method = RequestMethod.GET)
	public String getBible(HttpServletRequest request) throws ClassNotFoundException, SQLException, JsonProcessingException {
		ModelAndView mv = new ModelAndView();
		
		HashMap<String,String> input = new HashMap<String, String>();

		input.put("type",request.getParameter("TYPE"));
		input.put("version", "개역개정");
		input.put("chapter", request.getParameter("CAHPTER"));
		input.put("gospel", request.getParameter("GOSPEL"));

		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(dao.getContents(input));
		
		return jsonStr;
	}
	
}
