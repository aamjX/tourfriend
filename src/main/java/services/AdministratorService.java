package services;

import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.web.servlet.ModelAndView;

import domain.Administrator;
import domain.Route;
import domain.TourFriend;
import repositories.AdministratorRepository;
import security.LoginService;
import security.UserAccount;

@Service
@Transactional
public class AdministratorService {

	// Managed repository -----------------------

	@Autowired
	private AdministratorRepository administratorRepository;

	// Supporting services ----------------------

	@Autowired
	private UserAccountService userAccountService;
	
	@Autowired
	private RouteService routeService;
	
	@Autowired
	private BookingService bookingService;
	
	@Autowired
	TourFriendService tourFriendService;
	
	@Autowired
	EventService eventService;

	// Constructors -----------------------------

	public AdministratorService() {
		super();
	}

	// Simple CRUD methods ----------------------
	
	public Administrator create() {
		Administrator res;
		
		
		res = new Administrator();

		UserAccount userAccount;

		userAccount = this.userAccountService.createByAdmin();
		res.setUserAccount(userAccount);

		return res;
	}

	public void save(final Administrator admin) {
		Assert.notNull(admin);

		if (admin.getId() == 0) {//Nuevo admin sin guardar.
			Md5PasswordEncoder encoder;
			String hash;

			encoder = new Md5PasswordEncoder();
			hash = encoder.encodePassword(admin.getUserAccount().getPassword(), null);

			admin.getUserAccount().setPassword(hash);
		}
		this.administratorRepository.save(admin);
	}

	public Administrator findOne(final int adminId) {
		Assert.notNull(adminId);
		Assert.isTrue(adminId != 0);

		final Administrator result = this.administratorRepository.findOne(adminId);
		return result;
	}

	public Collection<Administrator> findAll() {
		Collection<Administrator> result;

		result = this.administratorRepository.findAll();
		Assert.notNull(result);

		return result;
	}

	// Other business methods ------------------------------------------

	public Administrator findByPrincipal() {
		Administrator result;
		UserAccount userAccount;

		userAccount = LoginService.getPrincipal();
		Assert.notNull(userAccount);
		
		result = findByUserAccount(userAccount);

		return result;
	}
	
	public Administrator findByUserAccount(UserAccount userAccount) {
		Assert.notNull(userAccount);

		Administrator result;

		result = administratorRepository.findByUserAccountId(userAccount.getId());

		return result;
	}
	
	public ModelAndView dashBoard(){
		 final ModelAndView result;
		 Collection<Route> routeWithMoreEvents;
		 Collection<Route> routeWithLessEvents;
		 List<List<String>> routesHighestRated;
		 List<List<String>> routesLowestRated;
		 List<List<String>> routeThisMonth;
		 Integer numBookingThisMonth;
		 Integer numBookingPreviousMonth;
		 Integer numBookingMakeTwoMonth;
		 List<List<String>> tourfriendsHighestRated;
		 List<List<String>> tourfriendsLowestRated;
		 Integer numBookingThisYear;
		 Integer numBookingPreviousYear;
		 Integer numBookingMakeTwoYear;
		 Integer avgPriceOfEventThisYear;
		 Integer avgPriceOfEventPreviousYear;
		 Integer avgPriceOfEventMake2Year;
		 List<List<String>> cityMoreBookings;
		 List<List<String>> cityLessBookings;
		 Integer eventReportedThisMonth;
		 Integer eventReportedPreviousMonth;
		 Integer eventReportedMake2Month;
		 
		 
		 routeWithMoreEvents = routeService.routesWithMoreEvents();
		 routeWithLessEvents = routeService.routesWithLessEvents();
		 routesHighestRated = routeService.routesHighestRated();
		 routesLowestRated = routeService.routesLowestRated();
		 routeThisMonth	= routeService.routeThisMonth();
		 numBookingThisMonth = bookingService.numBookingThisMonth();
		 numBookingPreviousMonth = bookingService.numBookingPreviousMonth();
		 numBookingMakeTwoMonth = bookingService.numBookingMakeTwoMonth();
		 tourfriendsHighestRated = tourFriendService.tourfriendsHighestRated();
		 tourfriendsLowestRated = tourFriendService.tourfriendsLowestRated();
		 numBookingThisYear = bookingService.numBookingThisYear();
		 numBookingPreviousYear = bookingService.numBookingPreviousYear();
		 numBookingMakeTwoYear = bookingService.numBookingMakeTwoYear();
		 avgPriceOfEventThisYear = eventService.avgPriceOfEventThisYear();
		 avgPriceOfEventPreviousYear = eventService.avgPriceOfEventPreviousYear();
		 avgPriceOfEventMake2Year = eventService.avgPriceOfEventMake2Year();
		 cityMoreBookings = bookingService.cityMoreBookings();
		 cityLessBookings = bookingService.cityLessBookings();
		 eventReportedThisMonth = eventService.eventReportedThisMonth();
		 eventReportedPreviousMonth = eventService.eventReportedPreviousMonth();
		 eventReportedMake2Month = eventService.eventReportedMake2Month();
		 
		 result = new ModelAndView("dashboard/display");
		 
		 result.addObject("routeWithMoreEvents",routeWithMoreEvents);
		 result.addObject("routeWithLessEvents",routeWithLessEvents);
		 result.addObject("routesHighestRated",routesHighestRated);
		 result.addObject("routesLowestRated",routesLowestRated);
		 result.addObject("routeThisMonth",routeThisMonth);
		 result.addObject("numBookingThisMonth",numBookingThisMonth);
		 result.addObject("numBookingPreviousMonth",numBookingPreviousMonth);
		 result.addObject("numBookingMakeTwoMonth",numBookingMakeTwoMonth);
		 result.addObject("tourfriendsHighestRated",tourfriendsHighestRated);
		 result.addObject("tourfriendsLowestRated",tourfriendsLowestRated);
		 result.addObject("numBookingThisYear",numBookingThisYear);
		 result.addObject("numBookingPreviousYear",numBookingPreviousYear);
		 result.addObject("numBookingMakeTwoYear",numBookingMakeTwoYear);
		 result.addObject("avgPriceOfEventThisYear",avgPriceOfEventThisYear);
		 result.addObject("avgPriceOfEventPreviousYear",avgPriceOfEventPreviousYear);
		 result.addObject("avgPriceOfEventMake2Year",avgPriceOfEventMake2Year);
		 result.addObject("cityMoreBookings",cityMoreBookings);
		 result.addObject("cityLessBookings",cityLessBookings);
		 result.addObject("eventReportedThisMonth",eventReportedThisMonth);
		 result.addObject("eventReportedPreviousMonth",eventReportedPreviousMonth);
		 result.addObject("eventReportedMake2Month",eventReportedMake2Month);
		 
		 
		 return result;		
	}

}
