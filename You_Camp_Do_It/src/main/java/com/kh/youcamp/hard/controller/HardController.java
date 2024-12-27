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
	
	@GetMapping("forest.ha")
	public ModelAndView toForest(ModelAndView mv)
	{
		mv.setViewName("hard/forest");
		return mv;
	}
	
	@GetMapping("belly.ha")
	public ModelAndView toBelly(ModelAndView mv)
	{
		mv.setViewName("hard/belly");
		return mv;
	}
	
	@GetMapping("sky.ha")
	public ModelAndView toSky(ModelAndView mv)
	{
		mv.setViewName("hard/sky");
		return mv;
	}
	
	@GetMapping("stone.ha")
	public ModelAndView toStone(ModelAndView mv)
	{
		mv.setViewName("hard/stone");
		return mv;
	}
	
	@GetMapping("etc.ha")
	public ModelAndView toEtc(ModelAndView mv)
	{
		mv.setViewName("hard/etc");
		return mv;
	}
	
	@GetMapping("location.ha")
	public ModelAndView location(ModelAndView mv)
	{
		mv.setViewName("hard/location");
		return mv;
	}
	
	@GetMapping("rentalInfo.ha")
	public ModelAndView rentalInfo(ModelAndView mv)
	{
		mv.setViewName("hard/rental_Info");
		return mv;
	}
	
	
	
	
}
