package com.kh.youcamp.hard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HardController {
	
	@GetMapping("precaution.ha")
	public ModelAndView toPrecaution(ModelAndView mv)
	{
		mv.setViewName("hard/precaution");
		return mv;
	}

	
	@GetMapping("emergency.ha")
	public ModelAndView toEmergency(ModelAndView mv)
	{
		mv.setViewName("hard/emergency");
		return mv;
	}
}
