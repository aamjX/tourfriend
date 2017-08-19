package controllers.tourfriend;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.paypal.api.payments.Amount;
import com.paypal.api.payments.Payer;
import com.paypal.api.payments.PaymentExecution;
import com.paypal.api.payments.RedirectUrls;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;

import controllers.AbstractController;
import domain.Booking;
import domain.CommentEvent;
import domain.Event;
import domain.Message;
import domain.Payment;
import domain.TourFriend;
import domain.enumeration.StatusPayment;
import services.BookingService;
import services.CommentEventService;
import services.EmailService;
import services.EventService;
import services.MessageService;
import services.PaymentService;
import services.TourFriendService;

@Controller
@RequestMapping("/booking")
public class BookingController extends AbstractController {

	@Autowired
	private BookingService bookingService;

	@Autowired
	private EventService eventService;

	@Autowired
	private PaymentService paymentService;

	@Autowired
	private CommentEventService commentEventService;

	@Autowired
	private TourFriendService tourFriendService;

	@Autowired
	private MessageService messageService;

	public BookingController() {
		super();
	}

	@RequestMapping(value = "/myBookings.do", method = RequestMethod.GET)
	public ModelAndView myBookings() {
		ModelAndView result;

		TourFriend t = tourFriendService.findByPrincipal();
		Collection<Booking> bookings = bookingService.findByPrincipal(t.getId());

		result = new ModelAndView("booking/myBookings");

		result.addObject("bookings", bookings);
		result.addObject("requestURI", "booking/myBookings.do");
		result.addObject("balance", tourFriendService.findByPrincipal().getAvailableBalance());

		return result;
	}

	@RequestMapping(value = "/detailsOfBooking.do", method = RequestMethod.GET)
	public ModelAndView display(@RequestParam String bookingId) {
		ModelAndView result;

		TourFriend t = tourFriendService.findByPrincipal();
		Booking booking = bookingService.findOne(new Integer(bookingId));
		Assert.isTrue(booking.getTourFriend().equals(t));

		Collection<CommentEvent> commentEvents = commentEventService.commentEventOfEventsSameRoute(booking.getEvent().getRoute().getId());

		CommentEvent commentEvent = commentEventService.create(booking.getEvent().getId());
		Collection<TourFriend> tourFriendAttendSameEvent = tourFriendService.tourFriendAttendSameEvent(booking.getEvent().getId());

		boolean checkEventPass = commentEvent.getCreationMoment().after(booking.getEvent().getDate());
		boolean checkPrincipalNoCreatorEvent = !t.equals(commentEvent.getEvent().getTourFriend());
		boolean checkCodeVerified = booking.getCode().getIsVerified();
		
		Map<Integer, Boolean> isCodeVerifiedByTourfriend = bookingService.isCodeVerifiedByTroufriend(booking.getId());
		
		Collection<CommentEvent> commentEventsSameRoute = commentEventService.commentEventOfEventsSameRoute(booking.getEvent().getRoute().getId());
		
		Double ratingEventSameRoute = 0.0;
		
		if(!commentEventsSameRoute.isEmpty()){
			for(CommentEvent c:commentEventsSameRoute){
				ratingEventSameRoute += c.getEvent().getRating();
			}
			ratingEventSameRoute = ratingEventSameRoute/commentEventsSameRoute.size();
		}
		
		int numOfCommentOfEventOfARoute = commentEventService.numOfCommentOfEventOfARoute(booking.getEvent().getRoute().getId());

		result = new ModelAndView("booking/display");
		result.addObject("booking", booking);
		result.addObject("ratingEventSameRoute",ratingEventSameRoute);
		result.addObject("commentEvent", commentEvent);
		result.addObject("checkEventPass", checkEventPass);
		result.addObject("checkPrincipalNoCreatorEvent", checkPrincipalNoCreatorEvent);
		result.addObject("checkCodeVerified", checkCodeVerified);
		result.addObject("commentEvents", commentEvents);
		result.addObject("tourFriendAttendSameEvent", tourFriendAttendSameEvent);
		result.addObject("isCodeVerifiedByTourfriend", isCodeVerifiedByTourfriend);
		result.addObject("numOfCommentOfEventOfARoute", numOfCommentOfEventOfARoute);
		result.addObject("requestURI", "booking/detailsOfBooking.do");

		return result;
	}

	@RequestMapping(value = "/checkout.do", method = RequestMethod.GET)
	public ModelAndView checkout(@RequestParam(required = false, defaultValue = "0") String idEvent, HttpServletRequest request) {

		ModelAndView result = new ModelAndView("booking/checkout");
		HttpSession session = request.getSession();

		ModelAndView error = myBookings();
		error.addObject("paypalError", true);

		if (!checkEventBooking(idEvent)){

			try {
				TourFriend t = tourFriendService.findByPrincipal();
				Event event = eventService.findOne(new Integer(idEvent));
				result.addObject("balance", t.getAvailableBalance());
				result.addObject("event", event);

				/*Guardamos ID del evento*/
				session.setAttribute("idEvent", idEvent);
			} catch (Exception e) {
				e.printStackTrace();
				result = error;
			}
		}else{
			result = error;
		}

		return result;
	}

	@RequestMapping(value = "/book.do", method = RequestMethod.GET)
	public ModelAndView book(@RequestParam(required = false, defaultValue = "0") String numP, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, PayPalRESTException {

		ModelAndView result;
		HttpSession session = request.getSession();

		ModelAndView error = myBookings();
		error.addObject("paypalError", true);

		if (!checkEventNumP((String) session.getAttribute("idEvent"), numP)){
			try {
				TourFriend t = tourFriendService.findByPrincipal();
				Event event = eventService.findOne(new Integer((String) session.getAttribute("idEvent")));
				Integer numberP = new Integer(numP);

				Calendar dateEvent = Calendar.getInstance();
				dateEvent.setTime(event.getDate());

				Assert.isTrue(Calendar.getInstance().before(dateEvent));

				//Comprobamos que el evento no sea del TourFriend conectado
				Assert.isTrue(t.getId() != event.getTourFriend().getId());

				Double paypalFee = calcFee(new Double((event.getPrice()*numberP.doubleValue())));
				Double payTotal = (double) Math.round((((event.getPrice()*numberP.doubleValue())+paypalFee)-t.getAvailableBalance())*100)/100;

				if (payTotal <= 0.0){

					Booking b = bookingService.create();
					b.setEvent(event);
					b.setNumPeople(numberP);

					Payment payment = paymentService.create();
					payment.setAmount((double) Math.round((((event.getPrice()*numberP.doubleValue())+paypalFee*numberP.doubleValue()))*100)/100);
					payment.setStatus(StatusPayment.SUCCESSFUL);

					bookingService.save(b, payment);

					result = new ModelAndView("booking/complete");

					result.addObject("balance", t.getAvailableBalance());
					result.addObject("event", event);
					result.addObject("numP", numberP);

					updateBalanceTourFriend((double) Math.round((((event.getPrice()*numberP.doubleValue())+paypalFee*numberP.doubleValue())-t.getAvailableBalance())*100)/100);

					session.setAttribute("idEvent", "-1");
					session.setAttribute("numP", "-1");
				}else{
					result = new ModelAndView("redirect:" + payPalUrl(event, numberP, t.getAvailableBalance(), request));
					session.setAttribute("numP", numberP);
				}
			} catch (Exception e) {
				e.printStackTrace();
				result = error;
			}
		}else{
			result = error;
		}

		return result;
	}

	@RequestMapping(value = "/cancel.do", method = RequestMethod.GET)
	public ModelAndView cancel(@RequestParam(required = false, defaultValue = "0") String bookingId) {

		boolean bookingError = false;

		try{
			TourFriend tf = tourFriendService.findByPrincipal();

			Booking booking = bookingService.findOne(new Integer(bookingId));
			Assert.notNull(booking);
			Assert.isTrue(!booking.getIsCancelled());
			Assert.isTrue(booking.getTourFriend().getId() == tf.getId());

			Calendar dateNow = Calendar.getInstance();
			Calendar dateEvent = Calendar.getInstance();
			dateEvent.setTime(booking.getEvent().getDate());

			//Sumo 1 dia a la fecha de hoy para comparar
			dateNow.add(Calendar.DATE, 1);


			if (Calendar.getInstance().before(dateEvent)){
				Date now;
				long miliseconds;

				miliseconds = System.currentTimeMillis()-1;
				now = new Date(miliseconds);

				booking.setCancelledMoment(now);
				booking.setIsCancelled(true);

				//Ponemos el estado a cancelado
				bookingService.update(booking);

				//Se le devuelve el dinero integro de la reserva
				if (dateNow.before(dateEvent)){

					Integer numP = booking.getNumPeople();

					Double paymentFee = calcFee(new Double((booking.getEvent().getPrice()*numP.doubleValue())));
					Double payment = booking.getPayment().getAmount() - paymentFee;
					tf.setAvailableBalance(tf.getAvailableBalance() + payment);

					tourFriendService.update(tf);
				}

				//Enviamos mensaje al TourFriend que ha creado el evento para avisarle de que un TourFriend ha cancelado su reserva
				sendMessageAppMail(booking.getEvent().getTourFriend(), "Cancelación de reserva para el evento ("+booking.getEvent().getName() + ")", "El tourfriend (" + booking.getTourFriend().getFirstName() + " " + booking.getTourFriend().getLastName() + ") ha cancelado su reserva.");
			}else{
				bookingError = true;
			}
		}catch (Exception e){
			e.printStackTrace();
			bookingError = true;
		}

		ModelAndView result = myBookings();

		result.addObject("errorBooking", bookingError);

		return result;
	}

	@RequestMapping(value = "/complete.do", method = RequestMethod.GET)
	public ModelAndView complete(@RequestParam(required = false) String PayerID, @RequestParam(required = false) String paymentId, HttpServletRequest request) throws IOException, PayPalRESTException {

		ModelAndView result;
		HttpSession session = request.getSession();

		ModelAndView error = myBookings();
		error.addObject("paypalError", true);

		try {
			TourFriend t = tourFriendService.findByPrincipal();
			Event event = eventService.findOne(new Integer((String) session.getAttribute("idEvent")));
			Integer numberP = new Integer(session.getAttribute("numP").toString());

			Calendar dateEvent = Calendar.getInstance();
			dateEvent.setTime(event.getDate());

			Assert.isTrue(Calendar.getInstance().before(dateEvent));
			Assert.isTrue(checkEventNumP(new Integer(event.getId()).toString(), numberP.toString()) == false);

			//Comprobamos que el evento no sea del TourFriend conectado
			Assert.isTrue(t.getId() != event.getTourFriend().getId());

			result = new ModelAndView("booking/complete");

			excecutePayment(PayerID, paymentId);

			Booking b = bookingService.create();
			b.setEvent(eventService.findOne(new Integer((String) session.getAttribute("idEvent"))));
			b.setNumPeople(numberP);

			Double paypalFee = calcFee(new Double((event.getPrice()*numberP.doubleValue())));
			Double payTotal = (double) Math.round((((event.getPrice()*numberP.doubleValue())+paypalFee)-t.getAvailableBalance())*100)/100;

			Payment payment = paymentService.create();
			payment.setAmount(payTotal);
			payment.setStatus(StatusPayment.SUCCESSFUL);

			bookingService.save(b, payment);

			result.addObject("balance", t.getAvailableBalance());
			result.addObject("event", event);
			result.addObject("numP", numberP);

			updateBalanceTourFriend((double) Math.round((((event.getPrice()*numberP.doubleValue())+paypalFee*numberP.doubleValue())-t.getAvailableBalance())*100)/100);

		}catch (Exception e){
			e.printStackTrace();
			result = error;
		}

		return result;
	}

	private boolean checkEventBooking (String idE){

		boolean b = false;

		TourFriend t = tourFriendService.findByPrincipal();
		Event event;

		try {
			event = eventService.findOne(new Integer(idE));

			if (t.getEvents().contains(event)){
				b = true;
			}
		}catch (Exception e){
			b = true;
		}

		return b;
	}

	private boolean checkEventNumP (String idEvent, String numP){

		boolean b = false;

		try {
			Event event = eventService.findOne(new Integer(idEvent));

			if (event.getAvailableSlots() <= 0){
				b = true;
			}else{
				if (new Integer(numP) > event.getAvailableSlots()){
					b = true;
				}
			}
		}catch (Exception e){
			b = true;
		}

		return b;
	}

	private String payPalUrl(Event event, Integer numberP, Double availableBalance, HttpServletRequest request) throws IOException, PayPalRESTException {

		String url = "";

		Map<String, String> sdkConfig = new HashMap<String, String>();
		sdkConfig.put("mode", "sandbox");
		sdkConfig.put("http.ConnectionTimeOut", "20000");
		sdkConfig.put("http.Retry", "10");
		sdkConfig.put("http.ReadTimeOut", "30000");
		sdkConfig.put("http.MaxConnection", "200");

		APIContext apiContext = new APIContext("ASNjxNr1Xl7CIzGWjm3xe2JlTEljXeAAld3fAo_dlauluj9KbiatdfGqR1IctTRsxa5uk_GGK7BOWAQa", "EBTGrp6v-u3pg720Nzl-dO5q37LY0dUaptI3j_OBn8HCq-8xwClH4LCGfNnPP3kl5v-3fPRISbmRobkn", "sandbox", sdkConfig);

		Double paypalFee = calcFee(new Double((event.getPrice()*numberP.doubleValue())));
		Double payTotal = (double) Math.round((((event.getPrice()*numberP.doubleValue())+paypalFee)-availableBalance)*100)/100;

		Amount amount = new Amount();
		amount.setCurrency("EUR");
		amount.setTotal(payTotal.toString());

		Transaction transaction = new Transaction();
		transaction.setDescription(numberP+ " x " + event.getName());
		transaction.setAmount(amount);

		List<Transaction> transactions = new ArrayList<Transaction>();
		transactions.add(transaction);

		Payer payer = new Payer();
		payer.setPaymentMethod("paypal");

		com.paypal.api.payments.Payment payment = new com.paypal.api.payments.Payment();
		payment.setIntent("sale");
		payment.setPayer(payer);
		payment.setTransactions(transactions);

		//Construyendo las urls para redireccionar correctamente
		StringBuffer rUrl = new StringBuffer();
		rUrl.append("http://");
		rUrl.append(request.getServerName());
		rUrl.append(":");
		rUrl.append(request.getServerPort());
		rUrl.append(request.getContextPath());

		String returnURL = rUrl.toString() + "/booking/complete.do";
		String cancelURL = rUrl.toString() + "/booking/myBookings.do?paypalCancel=true";

		RedirectUrls redirectUrls = new RedirectUrls();
		redirectUrls.setReturnUrl(returnURL);
		redirectUrls.setCancelUrl(cancelURL);
		payment.setRedirectUrls(redirectUrls);

		com.paypal.api.payments.Payment createdPayment = payment.create(apiContext);

		url = createdPayment.getLinks().get(1).getHref()+"&useraction=commit";

		return url;
	}

	private Double calcFee(Double amount) {

		Double rango1 = 40.0;
		Double rango2 = 65.0;
		Double rango3 = 90.0;
		Double rango4 = 120.0;

		Double res;

		if (amount <= rango1){
			res = amount * 0.18;
		}else if (amount > rango1 && amount <= rango2 ){
			res = amount * 0.15;
		}else if (amount > rango2 && amount <= rango3 ){
			res = amount * 0.12;
		}else if (amount > rango3 && amount <= rango4 ){
			res = amount * 0.1;
		}else{
			res = amount * 0.09;
		}

		return res;
	}

	private void excecutePayment(String payerID, String paymentId) throws IOException, PayPalRESTException{

		Map<String, String> sdkConfig = new HashMap<>();
		sdkConfig.put("mode", "sandbox");
		sdkConfig.put("http.ConnectionTimeOut", "20000");
		sdkConfig.put("http.Retry", "10");
		sdkConfig.put("http.ReadTimeOut", "30000");
		sdkConfig.put("http.MaxConnection", "200");

		APIContext apiContext = new APIContext("ASNjxNr1Xl7CIzGWjm3xe2JlTEljXeAAld3fAo_dlauluj9KbiatdfGqR1IctTRsxa5uk_GGK7BOWAQa", "EBTGrp6v-u3pg720Nzl-dO5q37LY0dUaptI3j_OBn8HCq-8xwClH4LCGfNnPP3kl5v-3fPRISbmRobkn", "sandbox", sdkConfig);

		Payer payer = new Payer();
		payer.setPaymentMethod("paypal");
		com.paypal.api.payments.Payment payment = new com.paypal.api.payments.Payment();
		payment.setId(paymentId);

		PaymentExecution paymentExecute = new PaymentExecution();
		paymentExecute.setPayerId(payerID);
		payment.execute(apiContext, paymentExecute);
	}

	private void updateBalanceTourFriend(Double payTotal) {

		TourFriend tf = tourFriendService.findByPrincipal();

		if (payTotal > 0.0){
			tf.setAvailableBalance(0.0);
		}else{
			tf.setAvailableBalance(-payTotal);
		}

		tourFriendService.update(tf);
	}

	private void sendMessageAppMail(TourFriend tf, String subject, String body) {

		//App
		Message message = messageService.create(tf.getId());

		message.setSenderActor(tourFriendService.findAdministrator());
		message.setRecipientActor(tf);
		message.setSubject(subject);
		message.setBody(body);
		message.setIsRecipientCopy(true);
		message.setIsRead(false);

		messageService.save(message);
	}
}