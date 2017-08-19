/*
 * ProfileController.java
 * 
 * Copyright (C) 2017 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the
 * TDG Licence, a copy of which you may download from
 * http://www.tdg-seville.info/License.html
 */

package controllers;

import java.util.ArrayList;
import java.util.Base64;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import domain.Language;
import domain.TourFriend;
import services.LanguageService;
import services.TourFriendService;

@Controller
@RequestMapping("/profile")
public class ProfileTourfriendController extends AbstractController {

	// Service

	@Autowired
	private TourFriendService tourFriendService;
	
	@Autowired
	private LanguageService languageService;

	// Constructors -----------------------------------------------------------

	public ProfileTourfriendController() {
		super();
	}

	// edit---------------------------------------------------------

	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public ModelAndView edit(@RequestParam String tourFriendId) {

		ModelAndView m;
		TourFriend object;

		object = tourFriendService.findOne(new Integer(tourFriendId));
		Assert.notNull(object);
		m = createEditModelAndView(object);

		return m;
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST, params = "save")
	public ModelAndView save(TourFriend tourFriend, BindingResult binding) {

		ModelAndView m;

		tourFriend = this.tourFriendService.reconstructProfile(tourFriend, binding);

		if (binding.hasErrors()) {
			m = createEditModelAndView(tourFriend);
		} else {
			try {
				tourFriendService.save(tourFriend);
				m = new ModelAndView(
						"redirect:/tourFriend/display.do?usserAccountId=" + tourFriend.getUserAccount().getId());
			} catch (Throwable e) {

				m = createEditModelAndView(tourFriend, "tourFriend.commit.error");
			}
		}

		return m;
	}
	
	
	@RequestMapping(value = "/changeImage", method = RequestMethod.POST)
	public ModelAndView addPhoto(@RequestParam("file") MultipartFile file,HttpServletRequest request) {

		ModelAndView m=null;
		TourFriend tourFriend = tourFriendService.findByPrincipal();


		
		if(!file.isEmpty()){
			try {
					byte[] barr = file.getBytes();
					String base64Encoded = Base64.getEncoder().encodeToString(barr);
					tourFriend.setImage(base64Encoded);
					tourFriendService.save(tourFriend);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
  
		m = new ModelAndView("redirect:/tourFriend/display.do?usserAccountId=" + tourFriend.getUserAccount().getId());
		return m;
	}
	
	@RequestMapping(value = "/changeLanguage", method = RequestMethod.GET)
	public ModelAndView changeLanguageCreate() {

		ModelAndView m;
		TourFriend tourFriend = tourFriendService.findByPrincipal();
		m = new ModelAndView("forward:/tourFriend/display.do?usserAccountId=" + tourFriend.getUserAccount().getId());
		m.addObject("editLanguage", true);
		ArrayList<Language> allLanguages = (ArrayList<Language>) languageService.findAll();
		ArrayList<Language> languagesTourFriend = new ArrayList<Language>(tourFriend.getLanguages());
		
		for(Language lan : allLanguages ){
			if(languagesTourFriend.contains(lan)){
				allLanguages.remove(lan);
			}
		}

					
		m = new ModelAndView("forward:/tourFriend/display.do?usserAccountId=" + tourFriend.getUserAccount().getId());
		m.addObject("editLanguage", true);
		m.addObject("languageCheked", tourFriend.getLanguages());
		m.addObject("languageUnCheked", allLanguages);
		return m;
	}
	
	@RequestMapping(value = "/changeLanguage", method = RequestMethod.GET,params = "save")
	public ModelAndView changeLanguage() {

		ModelAndView m=null;
		


		return m;
	}

	
	

	protected ModelAndView createEditModelAndView(TourFriend tourFriend) {

		ModelAndView m;

		m = createEditModelAndView(tourFriend, null);

		return m;
	}

	protected ModelAndView createEditModelAndView(TourFriend tourFriend, String message) {

		ModelAndView m;

		m = new ModelAndView("tourFriend/edit");
		m.addObject("tourFriend", tourFriend);
		m.addObject("message", message);
		return m;
	}

}
