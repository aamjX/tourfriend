package controllers.tourfriend;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import controllers.AbstractController;
import domain.Booking;
import domain.CommentEvent;
import domain.CommentTourFriend;
import domain.TourFriend;
import services.BookingService;
import services.CommentEventService;
import services.CommentTourFriendService;
import services.TourFriendService;

@Controller
@RequestMapping("/comment")
public class CommentController extends AbstractController {

	// Services ---------------------------------------------
	@Autowired
	private CommentEventService commentEventService;

	@Autowired
	private CommentTourFriendService commentTourFriendService;

	@Autowired
	private BookingService bookingService;

	@Autowired
	private TourFriendService tourFriendService;

	// Constructors -----------------------------------------------------------

	public CommentController() {
		super();
	}

	// Listing ---------------------------------------------------------------


	// Creation ---------------------------------------------------------------

	@RequestMapping(value = "/createCommentEvent", method = RequestMethod.GET)
	public ModelAndView createCommentEvent(@RequestParam String eventId) {
		ModelAndView result;
		CommentEvent commentEvent;

		commentEvent = commentEventService.create(new Integer(eventId));
		result = createEditModelAndViewCE(commentEvent);

		return result;
	}

	// Edition --------------------------------------------------

	@RequestMapping(value = "/editCommentEvent", method = RequestMethod.GET)
	public ModelAndView editCommentEvent(@RequestParam int commentEventId) {
		ModelAndView result;
		CommentEvent commentEvent;

		commentEvent = commentEventService.findOne(commentEventId);
		result = createEditModelAndViewCE(commentEvent);

		return result;
	}

	@RequestMapping(value = "/editCommentEvent", method = RequestMethod.POST, params = "save")
	public ModelAndView saveCommentEvent(@Valid CommentEvent commentEvent, BindingResult binding, RedirectAttributes redirectAttributes) {
		ModelAndView result;
		Booking booking;
		TourFriend tourFriend;
		
		Integer score = new Integer(commentEvent.getScore());
		Assert.notNull(score);
		commentEvent.setScore(score);

		
		if (binding.hasErrors()) {
			result = createEditModelAndViewCE(commentEvent);
		} else {
			try {
				commentEventService.save(commentEvent);

				tourFriend = tourFriendService.findByPrincipal();
				booking = bookingService.findBookingOfPrincipalByEvent(commentEvent.getEvent().getId(),
						tourFriend.getId());
				result = new ModelAndView("redirect:/booking/detailsOfBooking.do?bookingId=" + booking.getId());
				redirectAttributes.addFlashAttribute("commentError",false);

			} catch (Throwable oops) {
				tourFriend = tourFriendService.findByPrincipal();
				booking = bookingService.findBookingOfPrincipalByEvent(commentEvent.getEvent().getId(),
						tourFriend.getId());
				result = new ModelAndView("redirect:/booking/detailsOfBooking.do?bookingId=" + booking.getId());

				redirectAttributes.addFlashAttribute("commentError",true);
				//result = createEditModelAndViewCE(commentEvent, "booking.comment.commit.error");
			}
		}

		return result;
	}
	
	@RequestMapping(value = "/editCommentTourFriend", method = RequestMethod.POST, params="save")
	public ModelAndView editCommentTourFriend(@RequestParam(required = true) int bookingId, @RequestParam(required = true) int tourfriendID, @RequestParam(required = true) String comment, @RequestParam(required = true) int rating,
											  RedirectAttributes redirectAttributes){
		ModelAndView result;
		CommentTourFriend commentTourFriend;
		TourFriend principal;

		try {

			principal = tourFriendService.findByPrincipal();
			Assert.isTrue(bookingService.findOne(bookingId).getTourFriend().getId() == principal.getId());

			commentTourFriend = commentTourFriendService.create(tourfriendID);
			commentTourFriend.setDescription(comment);
			commentTourFriend.setScore(rating);

			commentTourFriendService.save(commentTourFriend);

			result = new ModelAndView("redirect:/booking/detailsOfBooking.do?bookingId=" + bookingId);
			redirectAttributes.addFlashAttribute("commentError",false);

		} catch (Throwable oops) {
			result = new ModelAndView("redirect:/booking/detailsOfBooking.do?bookingId=" + bookingId);
			redirectAttributes.addFlashAttribute("commentError",true);
		}
		return result;
		
	}


	// Ancillary Methods ----------------------------------------------

	private ModelAndView createEditModelAndViewCE(CommentEvent commentEvent) {
		ModelAndView result;

		result = createEditModelAndViewCE(commentEvent, null);

		return result;
	}

	private ModelAndView createEditModelAndViewCE(CommentEvent commentEvent, String message) {
		ModelAndView result;
		TourFriend principal;
		
		principal = tourFriendService.findByPrincipal();

		result = new ModelAndView("booking/display");
		result.addObject("commentEvent", commentEvent);
		result.addObject("message", message);
		result.addObject("principal", principal);

		return result;
	}

}
