/*
 * TourFriendController.java
 * 
 * Copyright (C) 2017 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the
 * TDG Licence, a copy of which you may download from
 * http://www.tdg-seville.info/License.html
 */

package controllers;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import com.paypal.svcs.services.AdaptivePaymentsService;
import com.paypal.svcs.types.ap.PayRequest;
import com.paypal.svcs.types.ap.PayResponse;
import com.paypal.svcs.types.ap.Receiver;
import com.paypal.svcs.types.ap.ReceiverList;
import com.paypal.svcs.types.common.RequestEnvelope;
import domain.Route;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import domain.CommentTourFriend;
import domain.Event;
import domain.TourFriend;
import forms.TourFriendRegisterForm;
import security.Credentials;
import services.*;

@Controller
@RequestMapping("/tourFriend")
public class TourFriendController extends AbstractController {

	// Service

	@Autowired
	private TourFriendService tourFriendService;
	@Autowired
	private EventService eventService;
	@Autowired
	private CommentTourFriendService commentTourFriendService;
	@Autowired
	private RouteService routeService;

	// Constructors -----------------------------------------------------------

	public TourFriendController() {
		super();
	}

	// Creation ---------------------------------------------------------------

	@RequestMapping(value = "/signUp", method = RequestMethod.GET)
	public ModelAndView create() {
		ModelAndView result;
		TourFriendRegisterForm tourFriendRegisterForm;


		tourFriendRegisterForm = new TourFriendRegisterForm();
		Assert.notNull(tourFriendRegisterForm);

		result = this.createEditFormModelAndView(tourFriendRegisterForm);

		return result;
	}

	@RequestMapping(value = "/display", method = RequestMethod.GET)
	public ModelAndView display(@RequestParam(required = true) int usserAccountId) {
		ModelAndView result;
		TourFriend tf;
		Collection<Event> events;
		Collection<CommentTourFriend> comments;
		TourFriend tfPrincipal = tourFriendService.findByPrincipal();

		tf = tourFriendService.findOneByUserAccount(usserAccountId);
		events = eventService.findByTourFriend(tf.getId());
		comments = commentTourFriendService.findByTourFriend(tf.getId());

		result = new ModelAndView("tourFriend/display");
		result.addObject("tf", tf);
		result.addObject("events", events);
		result.addObject("comments", comments);
		result.addObject("ownProfile", tf.getId() == tfPrincipal.getId());

		return result;
	}

	@RequestMapping(value = "/signUp", method = RequestMethod.POST, params = "save")
	public ModelAndView save(HttpServletRequest request, HttpServletResponse response,
			final TourFriendRegisterForm tourFriendRegisterForm, final BindingResult binding,
			@Valid @ModelAttribute final Credentials credentials,
			@RequestParam(required = false) final boolean showError) {
		ModelAndView result;
		TourFriend tourFriend;
		String pass;
		String username;
		List<Route> highRatedRoutes;
		boolean showRoutes = true;

		String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
		boolean verify = VerifyRecaptcha.verify("6LfOJBgUAAAAAKnJ-1FGPLHo2u5ZLR7IUYKYeQ2l", gRecaptchaResponse);

		// Comprobamos de antemano que acepta los terminos y condiciones del
		// sistema y repite la calve correctamente
		// el captcha
		if (!(tourFriendRegisterForm.getPassword1().equals(tourFriendRegisterForm.getPassword2()))) {
			result = this.createEditFormModelAndView(tourFriendRegisterForm, "tourFriend.commit.error.repeatPasswords",
					credentials, showError);
		} else if (verify != true) {
			result = this.createEditFormModelAndView(tourFriendRegisterForm, "tourFriend.commit.error.completeCaptcha",
					credentials, showError);

		} else if (!tourFriendRegisterForm.isTermsAndConditions()) {
			result = this.createEditFormModelAndView(tourFriendRegisterForm,
					"tourFriend.commit.error.termsAndConditions", credentials, showError);
		} else {

			pass = tourFriendRegisterForm.getPassword1();
			username = tourFriendRegisterForm.getUsername();
			tourFriend = this.tourFriendService.reconstruct(tourFriendRegisterForm, binding);

			if (binding.hasErrors())
				result = this.createEditFormModelAndViewError(tourFriendRegisterForm);
			else
				try {
					this.tourFriendService.save(tourFriend);
					tourFriendService.authenticateUserAndSetSession(username, pass, request);
					result = new ModelAndView("redirect:/welcome/index.do");
				} catch (final Throwable oops) {
					result = this.createEditFormModelAndView(tourFriendRegisterForm, "tourFriend.commit.error",
							credentials, showError);
				}
		}

		highRatedRoutes = routeService.routesHighRatedWithoutAvg();

		if (highRatedRoutes.isEmpty()) {
			showRoutes = false;
		}

		result.addObject("highRatedRoutes", highRatedRoutes);
		result.addObject("showRoutes", showRoutes);

		return result;
	}

	@RequestMapping(value = "/withdraw.do", method = RequestMethod.GET)
	public ModelAndView withdraw() {

		ModelAndView result = new ModelAndView("tourFriend/withdraw");
		TourFriend tf = tourFriendService.findByPrincipal();

		DecimalFormat df = new DecimalFormat("#0.0");
		df.setRoundingMode(RoundingMode.DOWN);

		result.addObject("tf", tf);
		result.addObject("availableBalance", df.format(tf.getAvailableBalance()).replace(',', '.'));
		result.addObject("email", tf.getEmail());

		return result;
	}

	@RequestMapping(value = "/withdrawBalance.do", method = RequestMethod.GET)
	public ModelAndView withdrawBalance(@RequestParam(required = false) String amount,
			@RequestParam(required = false) String email) {

		TourFriend tf = tourFriendService.findByPrincipal();

		Double moneySelected = 0.;
		Double money;
		String s;

		try {
			moneySelected = (double) Math.round((Double.parseDouble(amount)) * 100) / 100;
			Assert.isTrue(moneySelected <= tf.getAvailableBalance());
			money = (double) Math.round((moneySelected - (moneySelected * 0.08)) * 100) / 100;
		} catch (Exception e) {
			e.printStackTrace();
			money = 0.;
		}

		s = withdrawAvailableBalance(money, email);

		if (s == "SUCCESS") {

			tf.setAvailableBalance((double) Math.round((tf.getAvailableBalance() - moneySelected) * 100) / 100);

			tourFriendService.update(tf);
		}

		ModelAndView result = display(tf.getUserAccount().getId());

		result.addObject("resp", s);

		return result;
	}

	private ModelAndView createEditFormModelAndView(final TourFriendRegisterForm tourFriendRegisterForm) {
		ModelAndView result;

		result = this.createEditFormModelAndView(tourFriendRegisterForm, null, null, false);

		return result;
	}

	private ModelAndView createEditFormModelAndView(final TourFriendRegisterForm tourFriendRegisterForm,
			final String message, Credentials credentials, boolean showError) {
		ModelAndView result;

		result = new ModelAndView("welcome/index");

		result.addObject("credentials", credentials);

		result.addObject("showError", showError);
		result.addObject("tourFriendRegisterForm", tourFriendRegisterForm);
		result.addObject("message", message);
		if (message != null) {
			result.addObject("showError", true);
		}

		return result;
	}
	
	private ModelAndView createEditFormModelAndViewError(final TourFriendRegisterForm tourFriendRegisterForm) {
		ModelAndView result;

		result = this.createEditFormModelAndViewError(tourFriendRegisterForm, null);

		return result;
	}
	
	private ModelAndView createEditFormModelAndViewError(final TourFriendRegisterForm tourFriendRegisterForm,final String message) {
		ModelAndView result;

		result = new ModelAndView("welcome/index");
		
		result.addObject("tourFriendRegisterForm", tourFriendRegisterForm);
		result.addObject("message", message);
		if (message != null) {
			result.addObject("showError", true);
		}

		return result;
	}

	private String withdrawAvailableBalance(Double amount, String email) {

		// foehn377-merchant_api1.gmail.com
		// 52CP54JP4YFB3L8L
		// AFcWxV21C7fd0v3bYYYRCpSSRl31ApNfg6sb7DJrIK.-.bl6SsyLF.gx

		String res = "FAILURE";

		Map<String, String> sdkConfig = new HashMap<String, String>();

		sdkConfig.put("acct1.UserName", "foehn377-merchant_api1.gmail.com");
		sdkConfig.put("acct1.Password", "52CP54JP4YFB3L8L");
		sdkConfig.put("acct1.Signature", "AFcWxV21C7fd0v3bYYYRCpSSRl31ApNfg6sb7DJrIK.-.bl6SsyLF.gx");
		sdkConfig.put("acct1.AppId", "APP-80W284485P519543T");

		sdkConfig.put("mode", "sandbox");
		sdkConfig.put("http.ConnectionTimeOut", "20000");
		sdkConfig.put("http.Retry", "10");
		sdkConfig.put("http.ReadTimeOut", "30000");
		sdkConfig.put("http.MaxConnection", "200");

		PayRequest req = new PayRequest();
		RequestEnvelope requestEnvelope = new RequestEnvelope("es_ES");
		req.setRequestEnvelope(requestEnvelope);

		List<Receiver> receiver = new ArrayList<Receiver>();
		Receiver rec = new Receiver();
		rec.setAmount(amount);
		rec.setEmail(email);
		receiver.add(rec);

		req.setActionType("PAY");
		req.setSenderEmail("foehn377-merchant@gmail.com");

		req.setReturnUrl("https://www.google.com");
		req.setCancelUrl("https://www.google.com");

		req.setReceiverList(new ReceiverList(receiver));

		req.setCurrencyCode("EUR");

		AdaptivePaymentsService service = new AdaptivePaymentsService(sdkConfig);

		try {
			PayResponse resp = service.pay(req);
			res = resp.getResponseEnvelope().getAck().toString();

			System.out.println("LA RESPUESTA HA SIDO: " + resp.getResponseEnvelope().getAck().toString());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

	@RequestMapping(value = "/setPassword.do", method = RequestMethod.GET)
	public ModelAndView showPasswordForm() {

		ModelAndView result = new ModelAndView("tourFriend/newPasswordForm");

		result.addObject("fail", false);

		return result;
	}

	@RequestMapping(value = "/receivePassword.do", method = RequestMethod.POST)
	public ModelAndView receivePassword(@RequestParam(required = true) String old_password,
			@RequestParam(required = true) String new_password_1,
			@RequestParam(required = true) String new_password_2) {
		
		ModelAndView result;

		try{
			
			TourFriend principal = tourFriendService.findByPrincipal();
			
			tourFriendService.setPassword(principal, old_password, new_password_1, new_password_2);
			
			result = new ModelAndView("tourFriend/passwordConfirmation");
			

		}
		catch(Exception e){

			result = new ModelAndView("tourFriend/newPasswordForm");

			result.addObject("fail", true);
			
		}

		return result;
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView list() {

		ModelAndView result = new ModelAndView("tourFriend/list");

		Collection<TourFriend> tourfriends = tourFriendService.findAll();

		Assert.notNull(tourfriends);

		result.addObject("tourfriends", tourfriends);
		result.addObject("requestURI", "tourFriend/list.do");
		return result;
	}

	// Ban --------------------------------------------------------------------

	@RequestMapping(value = "/ban", method = RequestMethod.GET)
	public ModelAndView ban(@RequestParam int tourfriendId) {
		ModelAndView result;
		result = new ModelAndView("forward:/tourFriend/list.do");
		try {
			tourFriendService.ban(tourfriendId);
		} catch (Exception e) {
			result.addObject("showError", true);
			result.addObject("message", "imposibleToBan");
		}

		return result;
	}

	// UnBan
	// --------------------------------------------------------------------

	@RequestMapping(value = "/unban", method = RequestMethod.GET)
	public ModelAndView unban(@RequestParam int tourfriendId) {
		ModelAndView result;

		tourFriendService.unBan(tourfriendId);
		result = new ModelAndView("redirect:/tourFriend/list.do");

		return result;
	}

}
