package services;

import java.util.Collection;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.validation.Validator;

import domain.Booking;
import domain.CommentEvent;
import domain.Event;
import domain.TourFriend;
import repositories.CommentEventRepository;

@Service
@Transactional
public class CommentEventService {

	// Managed repository -------------------------------------------

	@Autowired
	private CommentEventRepository commentEventRepository;

	// Supporting services ------------------------------------------

	@Autowired
	private TourFriendService tourFriendService;

	@Autowired
	private EventService eventService;

	@Autowired
	private BookingService bookingService;

	@Autowired
	private Validator validator;

	// Constructor --------------------------------------------------

	public CommentEventService() {
		super();
	}

	// Simple CRUD methods ------------------------------------------

	public CommentEvent create(int eventId) {
		CommentEvent result;
		Date creationMoment;
		TourFriend tourFriend;
		Event event;

		result = new CommentEvent();

		creationMoment = new Date(System.currentTimeMillis() - 1);
		tourFriend = tourFriendService.findByPrincipal();
		event = eventService.findOne(eventId);
		Assert.notNull(event);

		result.setCreationMoment(creationMoment);
		result.setTourFriendCreator(tourFriend);
		result.setEvent(event);
		result.setScore(0);

		return result;
	}

	public void save(CommentEvent commentEvent) {
		TourFriend principal;
		Booking booking;

		principal = tourFriendService.findByPrincipal();

		booking = bookingService.findBookingOfPrincipalByEvent(commentEvent.getEvent().getId(), principal.getId());

		//Se comprueba que la persona tiene esa reserva
		Assert.notNull(booking);

		// Se comprueba que el evento ya ha pasado
		Assert.isTrue(commentEvent.getCreationMoment().after(commentEvent.getEvent().getDate()));
		// Se comprubea que la persona que crea un comentario sobre el evento no
		// es la creadora del evento
		Assert.isTrue(!principal.equals(commentEvent.getEvent().getTourFriend()));
		// Se comprueba que la persona que crea un comentario sobre el evento
		// tiene el codigo de asistencia de la booking de ese evento verificado
		Assert.isTrue(booking.getCode().getIsVerified());

		commentEventRepository.save(commentEvent);

		Collection<CommentEvent> comments = commentsBetweenTourfriendAndEvent(commentEvent);

		if (comments.size() == 1) {
			TourFriend tourFriendCreator = commentEvent.getTourFriendCreator();
			tourFriendCreator.setAvailablePoints(tourFriendCreator.getAvailablePoints() + 1);
			tourFriendService.save(tourFriendCreator);
		}
	}

	public CommentEvent findOne(int commentEventId) {
		CommentEvent result;

		result = commentEventRepository.findOne(commentEventId);
		Assert.notNull(result);

		return result;
	}

	public void delete(CommentEvent commentEvent) {
		commentEventRepository.delete(commentEvent);
	}

	// Other business methods ---------------------------------------

	public Collection<CommentEvent> commentEventOfEventsSameRoute(int routeId) {
		Collection<CommentEvent> result;

		result = commentEventRepository.commentEventOfEventsSameRoute(routeId);
		Assert.notNull(result);

		return result;
	}

	public int numOfCommentOfEventOfARoute(int routeId) {
		return commentEventRepository.numOfCommentOfEventOfARoute(routeId);
	}

	public Collection<CommentEvent> commentsBetweenTourfriendAndEvent(CommentEvent comment) {
		Collection<CommentEvent> comments;

		comments = commentEventRepository.commentsBetweenTourfriendAndEvent(comment.getTourFriendCreator().getId(),
				comment.getEvent().getId());

		return comments;
	}

}
