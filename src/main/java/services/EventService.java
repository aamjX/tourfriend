package services;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import domain.Booking;
import domain.Code;
import domain.CommentEvent;
import domain.Event;
import domain.Message;
import domain.TourFriend;
import repositories.EventRepository;

@Service
@Transactional
public class EventService {

	@Autowired
	private EventRepository eventRepository;

	@Autowired
	private TourFriendService tourFriendService;

	@Autowired
	private MessageService messageService;
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private BookingService bookingService;

	public EventService() {
		super();
	}

	public Event create() {

		Event event = new Event();
		event.setTourFriend(tourFriendService.findByPrincipal());
		Collection<Booking> b = new HashSet<Booking>();
		Collection<CommentEvent> c = new HashSet<CommentEvent>();
		event.setBookings(b);
		event.setIsCancelled(false);
		event.setCommentEvents(c);

		return event;
	}

	public Event save(Event event) {

		Date now = new Date();
		
		Assert.notNull(event);
		Assert.isTrue(event.getBookings().isEmpty());
		Assert.isTrue(event.getDuration() >= 0.5);
		Assert.isTrue(event.getMinPeople()<=event.getMaxPeople());
		Assert.isTrue(!event.getRoute().getIsDisabled());
		Assert.isTrue(event.getDate().after(now));
		
		return eventRepository.saveAndFlush(event);
	}

	public Collection<Event> findAll() {

		return eventRepository.findAll();
	}

	public Event findOne(int id) {

		return eventRepository.findOne(id);
	}

	public Collection<Event> findAllAvailables() {

		return eventRepository.findAllAvailables();
	}

	public void delete(Event event) {

		eventRepository.delete(event);
	}

	public Collection<Event> findEventBookingByPrincipal() {
		TourFriend tf = tourFriendService.findByPrincipal();

		return eventRepository.findEventBookingByTourfiend(tf.getId());
	}

	public Collection<Event> findByTourFriend(int id) {

		return eventRepository.findByTourFriendId(id);
	}
	
	public Collection<Event> findAllByTourFriend(int id) {

		return eventRepository.findAllByTourFriendId(id);
	}
	
	
	public Boolean manageCode(String code, int eventId){
		Boolean result = false;
		Collection<Code> codes;
		TourFriend principal;
		TourFriend customer;
		Event event;
		Double newBalance;
		
		codes = codeService.findByEventId(eventId);
		principal = tourFriendService.findByPrincipal();
		event = findOne(eventId);
		
		for (Code c :codes){
			if (c.getValue().equals(code) && c.getIsVerified().equals(false)){
				c.setIsVerified(true);
				codeService.save(c);
				newBalance = event.getPrice() + principal.getAvailableBalance();
				principal.setAvailableBalance(newBalance);
				principal.setAvailablePoints(principal.getAvailablePoints()+1);
				tourFriendService.save(principal);
				customer = bookingService.findByCode(c).getTourFriend();
				customer.setAvailablePoints(customer.getAvailablePoints()+5);
				tourFriendService.save(customer);
				result = true;
				break;
			}
		}
		
		return result;
		
	}

	public List<Event> avancedSearch(String date, String city, Integer numPersonasMin, Integer numPersonasMax, Double precioMin,
			Double precioMax, Integer calificationTRMin, Integer calificationTRMax, String orderBy) {
		List<Event> result = new ArrayList<Event>();
		List<Event> c1;

		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
		Date d;
		Date now = new Date();

		try {
			d = sdf.parse(date);
			if(d.before(now)) {
				d = now;
			}
		} catch (ParseException e) {
			d = null;
		}

		city = "%" + city + "%";

		c1 = eventRepository.avancedSearch(d, city, numPersonasMin, numPersonasMax, precioMin, precioMax);

		if (calificationTRMax != null && calificationTRMin != null) {
			for (Event e1 : c1) {
				if (e1.getTourFriend().getRating() >= calificationTRMin
						&& e1.getTourFriend().getRating() <= calificationTRMax) {
					result.add(e1);
				}
			}
		} else if (calificationTRMax != null) {
			for (Event e1 : c1) {
				if (e1.getTourFriend().getRating() <= calificationTRMax) {
					result.add(e1);
				}
			}
		} else if (calificationTRMin != null) {
			for (Event e1 : c1) {
				if (e1.getTourFriend().getRating() >= calificationTRMin) {
					result.add(e1);
				}
			}
		} else {
			result = c1;
		}

		if (orderBy.equals("price")) {
			Comparator<Event> cmp = new Comparator<Event>() {
				public int compare(Event e1, Event e2) {
					return e1.getPrice().compareTo(e2.getPrice());
				}
			};

			Collections.sort(result, cmp);

		} else if (orderBy.equals("rating")) {
			Comparator<Event> cmp = new Comparator<Event>() {
				public int compare(Event e1, Event e2) {
					return e1.getTourFriend().getRating().compareTo(e2.getTourFriend().getRating());
				}
			};

			Collections.sort(result, cmp);
		}

		return result;

	}

	public void cancel(Event event) {
		Calendar now = Calendar.getInstance();
		Calendar eventDate = Calendar.getInstance();
		eventDate.setTime(event.getDate());

		//Se mira que el evento no haya pasado ya
		Assert.isTrue(eventDate.after(now));

		//Se suman 48 horas para mirar lo del cupo minimo de personas
		now.add(Calendar.HOUR, 48);

		TourFriend tourFriendPrincipal = tourFriendService.findByPrincipal();

		Assert.notNull(event);
		//Se mira que el evento no este cancelado de antes
		Assert.isTrue(!event.getIsCancelled());
		//Se mira que el evento es del tourfriend
		Assert.isTrue(event.getTourFriend().getId() == tourFriendPrincipal.getId());

		if(eventDate.before(now)){
			//Si la fecha del evento es en menos de 48h mirar si se alcanza el numero minimo
			Assert.isTrue(event.getNumberOfBookings()<event.getMinPeople());
		}

		event.setCancelledMoment(now.getTime());

		for(Booking b:event.getBookings()){
			TourFriend tf = b.getTourFriend();
			//Se devuelve el dinero integro con los gastos de gestion tambien
			tf.setAvailableBalance(tf.getAvailableBalance()+b.getPayment().getAmount());
			tourFriendService.update(tf);

			b.setCancelledMoment(now.getTime());
			bookingService.update(b);

			EmailService emailService = new EmailService();
			//Mensaje para emisor
			Message message = messageService.create(b.getTourFriend().getId());
			message.setBody("El evento "+event.getName()+" del día "+event.getDate()+" ha sido cancelado por el tourFriend creador");
			message.setSubject("Evento cancelado");
			messageService.save(message);
			//Mensaje para receptor
			message.setIsRecipientCopy(true);
			message.setIsRead(false);
			messageService.save(message);
			
			
			try{
				emailService.sendEmail(message.getRecipientActor().getEmail(), message.getSubject(), message.getBody());
			}catch (Exception e) {
				e.printStackTrace();
				System.out.println("Fallo al enviar el email :S");
			}
		}

		event.setIsCancelled(true);
		eventRepository.saveAndFlush(event);
	}
	
	public Integer avgPriceOfEventThisYear(){
    	Integer res;
    	
    	res = eventRepository.avgPriceOfEventThisYear();
    	
    	if(res==null){
    		res= 0;
    	}
    	return res;
    }
    
    public Integer avgPriceOfEventPreviousYear(){
    	Integer res;
    	
    	res = eventRepository.avgPriceOfEventPreviousYear();
    	
    	if(res==null){
    		res= 0;
    	}
    	return res;
    }
    
    public Integer avgPriceOfEventMake2Year(){
    	Integer res;
    	
    	res = eventRepository.avgPriceOfEventMake2Year();
    	
    	if(res==null){
    		res= 0;
    	}
    	return res;
    }
    
    public TourFriend findTourFriendCreatorEvenet(int eventId){
    	return eventRepository.findTourFriendCreatorEvenet(eventId);
    }
    
    public Integer eventReportedThisMonth(){
    	Integer res;
    	
    	res = eventRepository.eventReportedThisMonth();
    	
    	if(res==null){
    		res= 0;
    	}
    	return res;
    }
    
    public Integer eventReportedPreviousMonth(){
    	Integer res;
    	
    	res = eventRepository.eventReportedPreviousMonth();
    	
    	if(res==null){
    		res= 0;
    	}
    	return res;
    }
    
    public Integer eventReportedMake2Month(){
    	Integer res;
    	
    	res = eventRepository.eventReportedMake2Month();
    	
    	if(res==null){
    		res= 0;
    	}
    	return res;
    }
}
