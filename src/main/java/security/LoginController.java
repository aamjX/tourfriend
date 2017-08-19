/*
 * LoginController.java
 * 
 * Copyright (C) 2017 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the
 * TDG Licence, a copy of which you may download from
 * http://www.tdg-seville.info/License.html
 */

package security;

import javax.validation.Valid;

import domain.Route;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import controllers.AbstractController;
import forms.TourFriendRegisterForm;
import services.ActorService;
import services.MessageService;
import services.RouteService;

import java.util.List;

@Controller
@RequestMapping("/security")
public class LoginController extends AbstractController {

	// Supporting services ----------------------------------------------------

	@Autowired
	LoginService service;
	@Autowired
	private MessageService messageService;
	@Autowired
	private ActorService actorService;
	@Autowired
	private RouteService routeService;

	// Constructors -----------------------------------------------------------

	public LoginController() {
		super();
	}

	// Login ------------------------------------------------------------------

	@RequestMapping("/login")
	public ModelAndView login(@Valid @ModelAttribute final Credentials credentials, final BindingResult bindingResult,
			@RequestParam(required = false) final boolean showError) {
		Assert.notNull(credentials);
		Assert.notNull(bindingResult);
		ModelAndView result;
		Integer noReadMessage = 0;

		TourFriendRegisterForm tourFriendRegisterForm;

		tourFriendRegisterForm = new TourFriendRegisterForm();
		Assert.notNull(tourFriendRegisterForm);

		try {
			noReadMessage = messageService.getNotReadMessages(actorService.findByPrincipal());
		} catch (Exception e) {
			// TODO: handle exception
		}

		result = createEditFormModelAndView1(tourFriendRegisterForm, null, credentials, showError, noReadMessage);

		return result;
	}

	// LoginFailure -----------------------------------------------------------

	@RequestMapping("/loginFailure")
	public ModelAndView failure(@Valid @ModelAttribute final Credentials credentials, final BindingResult bindingResult,
			@RequestParam(required = false) final boolean showError) {
		Assert.notNull(credentials);
		Assert.notNull(bindingResult);
		ModelAndView result;
		Integer noReadMessage = 0;
		List<Route> highRatedRoutes;
		boolean showRoutes = true;

		TourFriendRegisterForm tourFriendRegisterForm;

		tourFriendRegisterForm = new TourFriendRegisterForm();
		Assert.notNull(tourFriendRegisterForm);

		try {
			noReadMessage = messageService.getNotReadMessages(actorService.findByPrincipal());
		} catch (Exception e) {
			// TODO: handle exception
		}

		result = createEditFormModelAndView(tourFriendRegisterForm, "security.login.failed", credentials, showError,
				noReadMessage);

		highRatedRoutes = routeService.routesHighRatedWithoutAvg();

		if (highRatedRoutes.isEmpty()) {
			showRoutes = false;
		}

		result.addObject("highRatedRoutes", highRatedRoutes);
		result.addObject("showRoutes", showRoutes);

		return result;
	}

	private ModelAndView createEditFormModelAndView1(final TourFriendRegisterForm tourFriendRegisterForm,
			final String message, Credentials credentials, boolean showError, Integer noReadMessage) {
		ModelAndView result;

		result = new ModelAndView("welcome/index");
		result.addObject("credentials", credentials);
		result.addObject("showError", showError);
		result.addObject("noReadMessage", noReadMessage);
		result.addObject("tourFriendRegisterForm", tourFriendRegisterForm);
		result.addObject("message", message);
		result.addObject("showErrorLogin", true);

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
			result.addObject("showMessage", true);
		} else {
			result.addObject("showErrorLogin", false);
		}

		return result;
	}

}
