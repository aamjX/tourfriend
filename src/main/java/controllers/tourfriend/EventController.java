package controllers.tourfriend;

import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import controllers.AbstractController;
import domain.CommentEvent;
import domain.Event;
import domain.Message;
import domain.Route;
import domain.TourFriend;
import services.CommentEventService;
import services.EmailService;
import services.EventService;
import services.MessageService;
import services.RouteService;
import services.TourFriendService;

@Controller
@RequestMapping("/event")
public class EventController extends AbstractController {

	@Autowired
	private EventService eventService;

	@Autowired
	private TourFriendService tourFriendService;
	
	@Autowired
	private RouteService routeService;

	@Autowired
	private CommentEventService commentEventService;
	
	@Autowired
	private MessageService messageService;

	public EventController() {
		super();
	}

	@RequestMapping(value = "/allEvents", method = RequestMethod.GET)
	public ModelAndView listAllEvents() {
		ModelAndView result;

		Collection<Event> events = eventService.findAllAvailables();
		Collection<Event> bookings = eventService.findEventBookingByPrincipal();
		result = new ModelAndView("event/allEvents");

		result.addObject("bookings", bookings);
		result.addObject("events", events);
		result.addObject("requestURI", "event/allEvents.do");

		return result;
	}

	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public ModelAndView search(@RequestParam(required = false) String city, @RequestParam(required = false) String date,
			@RequestParam(required = false) Integer numPersonasMin,
			@RequestParam(required = false) Integer numPersonasMax, @RequestParam(required = false) Double precioMin,
			@RequestParam(required = false) Double precioMax, @RequestParam(required = false) Integer calificationMin,
			@RequestParam(required = false) Integer calificationMax,
			@RequestParam(required = false) Integer calificationTRMin,
			@RequestParam(required = false) Integer calificationTRMax,
			@RequestParam(required = false) String orderBy) {
		ModelAndView result;
		List<Event> events;

		events = eventService.avancedSearch(date, city, numPersonasMin, numPersonasMax, precioMin, precioMax, calificationTRMin,
				calificationTRMax, orderBy);
		result = new ModelAndView("event/allEvents");

		result.addObject("events", events);
		result.addObject("requestURI", "event/allEvents.do");
		return result;
	}
	
	@RequestMapping(value = "enterCode", method = RequestMethod.GET)
	public ModelAndView enterCode(@RequestParam(required = true) String code, @RequestParam(required = true) Integer eventId){
		ModelAndView result;
		Boolean itsOk = this.eventService.manageCode(code, eventId);
		
		result = new ModelAndView("event/codeConfirmation");
		result.addObject("itsOk", itsOk);
		result.addObject("eventId", eventId);
		return result;
		
	}

	@RequestMapping(value = "/myEvents", method = RequestMethod.GET)
	public ModelAndView list() {
		ModelAndView result;

		TourFriend t = tourFriendService.findByPrincipal();
		Collection<Event> events = eventService.findAllByTourFriend(t.getId());
		result = new ModelAndView("event/myEvents");

		result.addObject("events", events);
		result.addObject("requestURI", "event/myEvents.do");

		return result;
	}

	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public ModelAndView create() {

		ModelAndView m;

		Event event = eventService.create();

		m = createEditModelAndView(event);

		return m;
	}

	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public ModelAndView edit(@RequestParam String id) {

		ModelAndView m;
		Event object;
		TourFriend tourfriend = null;

		
		try {
			object = eventService.findOne(new Integer(id));
			Assert.notNull(object);

			tourfriend = tourFriendService.findByPrincipal();
			Assert.isTrue(object.getTourFriend().equals(tourfriend));

			m = createEditModelAndView(object);
		} catch (Throwable e) {
			m = new ModelAndView("redirect:myEvents.do");
		}

		return m;
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST, params = "save")
	public ModelAndView save(@Valid Event event, BindingResult binding) {

		ModelAndView m;

		if (binding.hasErrors()) {
			m = createEditModelAndView(event);
		} else {
			try {
				
				if(event.getMinPeople()>event.getMaxPeople()){
					m = createEditModelAndView(event, "event.error.minmax");
					m.addObject("minMaxError", true);
				}else{
					eventService.save(event);
					m = new ModelAndView("redirect:myEvents.do");
				}
				
				
			} catch (Exception e) {

				m = createEditModelAndView(event, "event.commit.error");
			}
		}

		return m;
	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public ModelAndView delete(@RequestParam String id) {

		ModelAndView m;
		Event event = eventService.findOne(new Integer(id));
		try {

			eventService.delete(event);
			m = new ModelAndView("redirect:myEvents.do");
		} catch (Throwable e) {

			m = createEditModelAndView(event, "event.delete.error");
		}

		return m;
	}
	
	@RequestMapping(value = "/cancel", method = RequestMethod.GET)
	public ModelAndView cancel(@RequestParam String id) {

		ModelAndView m;
		Event event = eventService.findOne(new Integer(id));
		try {
			eventService.cancel(event);
			m = new ModelAndView("redirect:myEvents.do");
		} catch (Throwable e) {
			
			m = new ModelAndView("redirect:myEvents.do");
			m .addObject("errorMessage",true);
			m .addObject("message","event.cancel.error");
		}

		return m;
	}

	@RequestMapping(value = "/detailsOfEvent.do", method = RequestMethod.GET)
	public ModelAndView display(@RequestParam String eventId) {
		ModelAndView result;
		Collection<CommentEvent> commentEvents;
		Boolean isEnterCode;
		Date date;
		Collection<TourFriend> tourFriendAttendSameEvent;
		
		Event event = eventService.findOne(new Integer(eventId));
		date = new Date();

		if (event.getDate().before(date)){
			isEnterCode = true;
		} else {
			isEnterCode = false;
		}

		// Listado de Comentarios

		commentEvents = commentEventService.commentEventOfEventsSameRoute(event.getRoute().getId());
		tourFriendAttendSameEvent = tourFriendService.tourFriendAttendSameEvent(event.getId());
		
		Double ratingEventSameRoute = 0.0;
		
		if(!commentEvents.isEmpty()){
			for(CommentEvent c:commentEvents){
				ratingEventSameRoute += c.getEvent().getRating();
			}
			ratingEventSameRoute = ratingEventSameRoute/commentEvents.size();
		}
				
		int numOfCommentOfEventOfARoute = commentEventService.numOfCommentOfEventOfARoute(event.getRoute().getId());

		result = new ModelAndView("event/display");
		result.addObject("event", event);
		result.addObject("ratingEventSameRoute",ratingEventSameRoute);
		result.addObject("commentEvents", commentEvents);
		result.addObject("tourFriendAttendSameEvent", tourFriendAttendSameEvent);
		result.addObject("numOfCommentOfEventOfARoute", numOfCommentOfEventOfARoute);
		result.addObject("isEnterCode", isEnterCode);
		result.addObject("requestURI", "booking/detailsOfBooking.do");

		return result;
	}
	
	@RequestMapping(value = "/report", method = RequestMethod.POST)
	public ModelAndView reportEvent(@RequestParam(required = false) String enventId,@RequestParam(required = false) String msnBody,@RequestParam(required = false) String language) {
		ModelAndView result;

		if(enventId != null && msnBody != null && language != null){
			
			try{
				TourFriend tourFriendLogged = tourFriendService.findByPrincipal();
				TourFriend tourFriendEventCreator =  eventService.findTourFriendCreatorEvenet(new Integer(enventId));
				Message message = messageService.create(174);
				String menssageToSend = "";
				String subject = "";
				if(language.equals("ES"))
				{
					menssageToSend ="Tourfriend: " + tourFriendLogged.getFirstName() + " ha reportado el siguiente evento: http://www.tourfriend.es/event/detailsOfEvent.do?eventId=" +enventId  + " el evento fue creado por: " + tourFriendEventCreator.getFirstName() + " ,el motivo del reporte es: " + msnBody;
					subject = "Evento reportado";
				}else if(language.equals("EN")){
					menssageToSend ="Tourfriend: " + tourFriendLogged.getFirstName() + " has reported the following event: http://www.tourfriend.es/event/detailsOfEvent.do?eventId=" +enventId  + " the event was created by: " + tourFriendEventCreator.getFirstName() + " ,the reason for the report is: " + msnBody;
					subject = "Reported event";

				}
				message.setBody(menssageToSend);
				message.setSubject(subject);
				message.setIsRead(false);
				message.setIsRecipientCopy(true);
				messageService.save(message);
				
				EmailService emailService = new EmailService();
				try{
					emailService.sendEmail("soportetourfriend@gmail.com", message.getSubject(), message.getBody());
				}catch (Exception e) {
					e.printStackTrace();
					System.out.println("Fallo al enviar el email :S");
				}
			}catch(Throwable e){
				result = new ModelAndView("redirect:allEvents.do");

			}
			result = new ModelAndView("redirect:allEvents.do");
		}else{
			result = new ModelAndView("redirect:allEvents.do");
		}


		return result;
	}

	protected ModelAndView createEditModelAndView(Event event) {

		ModelAndView m;

		m = createEditModelAndView(event, null);

		return m;
	}


protected ModelAndView createEditModelAndView(Event event, String message) {

		ModelAndView m;

		m = new ModelAndView("event/edit");
		Collection<Route> routes = routeService.findRouteAvailableByTourFriend(tourFriendService.findByPrincipal().getId());
		m.addObject("event", event);
		m.addObject("message", message);
		m.addObject("routes", routes);
		return m;
	}
}