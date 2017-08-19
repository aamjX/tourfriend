package services;

import domain.Booking;
import domain.Code;
import domain.Event;
import domain.Payment;
import domain.TourFriend;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import repositories.BookingRepository;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class BookingService {

	@Autowired
	private BookingRepository bookingRepository;

	@Autowired
    private PaymentService paymentService;

    @Autowired
    private CodeService codeService;

    @Autowired
    private TourFriendService tourFriendService;

	public BookingService() {
		super();
	}

	public Booking create() {

		Booking booking = new Booking();

		booking.setBookingMoment(new Date(System.currentTimeMillis()));
        booking.setIsCancelled(false);
        booking.setIsPaied(true);
        booking.setNumPeople(1);

		return booking;
	}
	
	public Booking findByCode(Code c){
		
		return this.bookingRepository.findByCode(c.getId());
	}

	public Booking save(Booking b, Payment p) {

		Assert.notNull(b);

        TourFriend t = tourFriendService.findByPrincipal();
        Code c = codeService.create();

        b.setTourFriend(t);
        b.setPayment(paymentService.saveAndFlush(p));
        b.setCode(c);
        b.setBookingMoment(new Date(System.currentTimeMillis()));
		b.setCode(codeService.save(codeService.create()));

		return bookingRepository.saveAndFlush(b);
	}

	public Collection<Booking> findAll() {

		return bookingRepository.findAll();
	}

	public Booking findOne(int id) {

		return bookingRepository.findOne(id);
	}

	public void delete(Booking booking) {

		bookingRepository.delete(booking);
	}

    public Collection<Booking> findByPrincipal(int id) {

	    return bookingRepository.findByPrincipal(id);
    }

    public Booking findOneByTourFriendAndEvent(int idTourFriend, int idEvent) {

	    return bookingRepository.findOneByTourFriendAndEvent(idTourFriend, idEvent);
    }

    public Collection<Booking> findAllByEvent(int intEvent) {

	    return bookingRepository.findAllByEvent(intEvent);
    }
    
    public Booking findBookingOfPrincipalByEvent(int eventId, int tourFriendId){
    	Booking result;
    	
    	result = bookingRepository.findBookingOfPrincipalByEvent(eventId, tourFriendId);
    	Assert.notNull(result);
    	
    	return result;
    }
    
    public Map<Integer, Boolean> isCodeVerifiedByTroufriend(int bookingId){
    	
    	Map<Integer, Boolean> result = new HashMap<Integer, Boolean>();
    	Event event = findOne(bookingId).getEvent();
    	Collection<Booking> bookings = event.getBookings();
    	
    	for (Booking b : bookings){
    		result.put(b.getTourFriend().getId(), b.getCode().getIsVerified());
    	}
    	
    	return result;
    	
    }

    public void update(Booking booking) {

		Assert.notNull(booking);
		bookingRepository.saveAndFlush(booking);
	}
    
    public Integer numBookingThisMonth(){
    	Integer res;
    	
    	res = bookingRepository.numBookingThisMonth();
    	
    	if(res==null){
    		res= 0;
    	}
    	return res;
    }
    
    public Integer numBookingPreviousMonth(){
    	Integer res;
    	
    	res = bookingRepository.numBookingPreviousMonth();
    	
    	if(res==null){
    		res= 0;
    	}
    	return res;
    }
    
    public Integer numBookingMakeTwoMonth(){
    	Integer res;
    	
    	res = bookingRepository.numBookingMakeTwoMonth();
    	
    	if(res==null){
    		res= 0;
    	}
    	return res;
    }
    
    public Integer numBookingThisYear(){
    	Integer res;
    	
    	res = bookingRepository.numBookingThisYear();
    	
    	if(res==null){
    		res= 0;
    	}
    	return res;
    }
    
    public Integer numBookingPreviousYear(){
    	Integer res;
    	
    	res = bookingRepository.numBookingPreviousYear();
    	
    	if(res==null){
    		res= 0;
    	}
    	return res;
    }
    
    public Integer numBookingMakeTwoYear(){
    	Integer res;
    	
    	res = bookingRepository.numBookingMakeTwoYear();
    	
    	if(res==null){
    		res= 0;
    	}
    	return res;
    }
    
    public List<List<String>> cityMoreBookings() {
		Collection<Object[]> city;
		List<List<String>> lista1 = new ArrayList<>();

		city = bookingRepository.cityMoreBookings();
		List<Object[]> list = new ArrayList<>(city);
		if (list.size() >= 10) {
			city = list.subList(0, 10);
		}
		for (Object[] o : list) {
			for (int i = 0; i < o.length;) {
				List<String> liss = new ArrayList<>();
				liss.add(o[i].toString());
				liss.add(o[i + 1].toString());
				lista1.add(liss);
				i = i + 2;
			}
		}

		return lista1;
	}

	public List<List<String>> cityLessBookings() {
		Collection<Object[]> city;
		List<List<String>> lista1 = new ArrayList<>();

		city = bookingRepository.cityLessBookings();
		List<Object[]> list = new ArrayList<>(city);
		if (list.size() >= 10) {
			city = list.subList(0, 10);
		}
		for (Object[] o : list) {
			for (int i = 0; i < o.length;) {
				List<String> liss = new ArrayList<>();
				liss.add(o[i].toString());
				liss.add(o[i + 1].toString());
				lista1.add(liss);
				i = i + 2;
			}
		}

		return lista1;
	}
}
