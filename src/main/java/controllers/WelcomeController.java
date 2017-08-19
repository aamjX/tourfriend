/*
 * WelcomeController.java
 * 
 * Copyright (C) 2017 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the
 * TDG Licence, a copy of which you may download from
 * http://www.tdg-seville.info/License.html
 */

package controllers;

import javax.validation.Valid;

import domain.Message;
import domain.Poi;
import domain.Route;
import domain.TourFriend;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import forms.TourFriendRegisterForm;
import security.Credentials;
import services.ActorService;
import services.EmailService;
import services.MessageService;
import services.RouteService;

import java.util.List;

@Controller
@RequestMapping("/welcome")
public class WelcomeController extends AbstractController {

	// Services --------------------------------------------------------------

	@Autowired
	private MessageService messageService;
	@Autowired
	private ActorService actorService;
	@Autowired
	private RouteService routeService;

	// Constructors -----------------------------------------------------------

	public WelcomeController() {
		super();
	}

	// Index ------------------------------------------------------------------

	@RequestMapping(value = "/index")
	public ModelAndView index(@Valid @ModelAttribute final Credentials credentials, final BindingResult bindingResult,
			@RequestParam(required = false) final boolean showError, @RequestParam(required = false) String city) {
		Assert.notNull(credentials);
		Assert.notNull(bindingResult);
		ModelAndView result;
		Integer noReadMessage = 0;
		List<Route> highRatedRoutes;
		boolean showRoutes = true;

		TourFriendRegisterForm tourFriendRegisterForm;

		tourFriendRegisterForm = new TourFriendRegisterForm();
		Assert.notNull(tourFriendRegisterForm);

		if (city == "" || city == null) {
			highRatedRoutes = routeService.routesHighRatedWithoutAvg();
		} else {
			highRatedRoutes = routeService.routesHighRatedByCity(city);
		}

		if (highRatedRoutes.isEmpty()) {
			showRoutes = false;
		}
		
		try {
			for (Route r : highRatedRoutes) {
				Hibernate.initialize(r.getPois());
				for (Poi p : r.getPois()) {
					Hibernate.initialize(p.getPhotos());
				}
			}
			noReadMessage = messageService.getNotReadMessages(actorService.findByPrincipal());
		} catch (Exception e) {
			// TODO: handle exception
		}

		result = createEditFormModelAndView(tourFriendRegisterForm, null, credentials, showError, noReadMessage);
		result.addObject("highRatedRoutes", highRatedRoutes);
		result.addObject("showRoutes", showRoutes);

		if (city != null && city != "") {
			result.addObject("citySearch", city);
		}

		return result;

	}

	@RequestMapping(value = "/sendMail", method = RequestMethod.POST)
	public ModelAndView reportEvent(@RequestParam(required = false) String msnBody,
			@RequestParam(required = false) String email) {
		ModelAndView result;

		if (msnBody != null) {

			try {
				EmailService emailService = new EmailService();
				try {
					emailService.sendEmail("soportetourfriend@gmail.com", "Sugerencia de TourFriend",
							msnBody + " el email para contactar es: " + email);
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("Fallo al enviar el email :S");
				}
			} catch (Throwable e) {
				result = new ModelAndView("redirect:allEvents.do");

			}
			result = new ModelAndView("redirect:/welcome/index.do");
		} else {
			result = new ModelAndView("redirect:/welcome/index.do");
		}

		return result;
	}

	private ModelAndView createEditFormModelAndView(final TourFriendRegisterForm tourFriendRegisterForm,
			final String message, Credentials credentials, boolean showError, Integer noReadMessage) {
		ModelAndView result;

		result = new ModelAndView("welcome/index");
		result.addObject("credentials", credentials);
		result.addObject("showError", showError);
		result.addObject("noReadMessage", noReadMessage);
		result.addObject("tourFriendRegisterForm", tourFriendRegisterForm);
		result.addObject("message", message);
		if (message != null) {
			result.addObject("showErrorLogin", true);
		} else {
			result.addObject("showErrorLogin", false);
		}

		return result;
	}

	@RequestMapping("/termsAndConditions")
	public ModelAndView termsAndConditions() {
		ModelAndView result;

		result = new ModelAndView("termsAndConditions/display");

		return result;
	}

	@RequestMapping("/cookies")
	public ModelAndView cookies() {

		ModelAndView result = new ModelAndView("cookies/display");

		return result;
	}

}
