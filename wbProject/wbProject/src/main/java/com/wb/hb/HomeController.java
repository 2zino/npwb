package com.wb.hb;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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
	public ModelAndView main(Locale locale, Model model) throws ClassNotFoundException, SQLException, JsonProcessingException {
		ModelAndView mv = new ModelAndView();
		
		//mv.setViewName("home");
		mv.setViewName("main");
		HashMap<String,String> input = new HashMap<String, String>();

		input.put("version", "개역개정");
		input.put("type", "BC");
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(dao.getTotalData(input));
		
		mv.addObject("totalList",jsonStr);

		return mv;
	}
	
	@RequestMapping(value = "/home.do", method = RequestMethod.POST)
	public ModelAndView home(HttpServletRequest request, Model model) throws ClassNotFoundException, SQLException, JsonProcessingException, UnsupportedEncodingException {
		ModelAndView mv = new ModelAndView();
		request.setCharacterEncoding("UTF-8");
		String type = request.getParameter("type");
		String gospel = request.getParameter("gospel");
		String chapter = request.getParameter("chapter");
		//String totalSting = request.getParameter("totalList");
		//String totalSting = "";
		String jsonStr = "";
		
		ObjectMapper mapper = new ObjectMapper();
		
		mv.setViewName("/home");
		HashMap<String,String> input = new HashMap<String, String>();
		HashMap<String,String> input1 = new HashMap<String, String>();

		input.put("type",type);
		input.put("version", "개역개정");
		input.put("chapter", chapter);
		input.put("gospel", gospel);
		
		input1.put("version", "개역개정");
		input1.put("type", "BC");
		
		try {
			jsonStr = mapper.writeValueAsString(dao.getContents(input));
			String totalSting = mapper.writeValueAsString(dao.getTotalData(input));
			
			mv.addObject("totalList",totalSting);
			mv.addObject("contents",jsonStr);
			
		} catch (JsonProcessingException e) {
		   e.printStackTrace();
		  }
		
		mv.addObject("type",type);
		mv.addObject("gospel",gospel);
		mv.addObject("chapter",chapter);
		
		return mv;
	}
	
	@RequestMapping(value = "/getBible.do", produces="application/json; charset=UTF8", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> getBible(HttpServletRequest request) throws ClassNotFoundException, SQLException, JsonProcessingException {
		
		HashMap<String,String> input = new HashMap<String, String>();

		input.put("type",request.getParameter("TYPE"));
		input.put("version", "개역개정");
		input.put("chapter", request.getParameter("CHAPTER"));
		input.put("gospel", request.getParameter("GOSPEL"));

		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = "";
		try {
				jsonStr = mapper.writeValueAsString(dao.getContents(input));
			} catch (JsonProcessingException e) {
			   e.printStackTrace();
			  }
	
		logger.debug(jsonStr);
		
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "application/json; charset=utf-8");
		    
		return new ResponseEntity<String>(jsonStr, responseHeaders, HttpStatus.CREATED);  
		//return jsonStr;
	}
	
}
