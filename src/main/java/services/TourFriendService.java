package services;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;

import domain.Administrator;
import domain.Booking;
import domain.CommentEvent;
import domain.CommentTourFriend;
import domain.CouponTourFriend;
import domain.Event;
import domain.Language;
import domain.Poi;
import domain.Route;
import domain.TourFriend;
import forms.TourFriendRegisterForm;
import repositories.TourFriendRepository;
import security.Authority;
import security.LoginService;
import security.UserAccount;

@Service
@Transactional
public class TourFriendService {

	// Managed repository -----------------------------------------------------

	@Autowired
	private TourFriendRepository tourFriendRepository;
	
	@Autowired
	private AdministratorService administratorService;


	// Supporting services ----------------------------------------------------

	@Autowired
	UserAccountService userAccountService;

	@Autowired
	private Validator validator;

	@Autowired
	private AuthenticationManager authenticationManager;

	// Constructors -----------------------------------------------------------

	public TourFriendService() {
		super();
	}

	// Simple CRUD methods ----------------------------------------------------

	public TourFriend create() {
		TourFriend res;
		double availableBalance;
		int availablePoints;
		String image;
		Collection<CommentEvent> myCommentEvents;
		Collection<CommentTourFriend> myCommentTourFriends;
		Collection<Booking> bookings;
		Collection<CommentTourFriend> commentTourFriends;
		Collection<CouponTourFriend> couponTourFriends;
		Collection<Poi> pois;
		Collection<Event> events;
		Collection<Route> myRoutes;
		Collection<Language> languages;
		Collection<Route> favouriteRoutes;

		availableBalance = 0.0;
		availablePoints = 0;
		image = "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AooooAM0UtFACUUtFACUUUUAGKKWkoAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAFooooA/me/aQ0v8AsT49+PrDG37PrNzHj6Oa84r379vfQk8P/tf/ABRgjyI5dYluVB7eZ82PpkmvAaACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiipLWA3NzDCOsjhB+JxQB/SD+x3pf9jfsvfDW1xjGjQyY/38v/7NXsVch8HNJj0H4R+CdNiz5dpollCN3U7YEGT7119ABRRRQAUUUUAFLSUtACUtFJQAUUUUAFFFFAC0lLSUAFLRSUAFFLSUAFFLSUALRRRQAUlFFAC0lLRQAlFLSUAFFFFABRRRQAUUtJQAtJS0lABRRRQAUtFJQAUUUtACUtJS0AfgN/wVC03+zv2yPGHGPPSCf/vpP/rV8oV92f8ABY3w2mkftUWepR7sapodvI4PTejOhx+AWvhOgAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigArY8G232zxfodvjPm38EePrIorHr0T9nTw6viz49fD3SHLCO612zRynXaJlJx+ANAH9KHhe2+x+GdJt+nlWkMePogFadIiBFVVGFAwB6CloAKKKKAFpKKKACiiigAoopaAEoNFFABRRS0AJRRRQAUUtJQACiiigAooooAMUUtFABRSUUAFFFFAC0lFFABRRRQAUUUUALRSUUAHSlpKKACiiloASlopKAFooooAKKK+bf27v2rYf2V/g3dapYPbyeLtTDWuj282GAlI5mK/xKmc46HpQB+ff/BaTWtF1P41eDraw1CC61Sy0yWK/t4jlrcl1ZA3bJBbj2r87a1PFHinVvGuv3ut67qE+q6teyGW4u7ly7yMepJrLoAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAK9q/Yt1XSNE/an+G9/rt7Fp2lW+qK81zPnYnyNtzj1baPxrxWlVijBlJVgcgg4INAH9UkUqTxJJG6yRuAyupyGB6EGn1+a3/BKP9tO/wDH+nv8JfG2pC71jT4zJol9cP8AvZ7cdYGJ+8U5IPXaQO1fpRQAtFJRQAUUUUAFLSUUAFFFFAC0lFFABRRRQAUUUUAFFFFABS0lFABRRRQAtFJmigAopaSgAooooAKKWkoAKKKKADNFFFABRRRQAUUUUAFFFFABRRRQAUUUUABOK/Aj/gpn8c5PjN+1J4itra6M2heGW/sWyVWym6L/AFzAdOZTIM9wBX7n/FLxZH4E+HHibxDIhkXTdPmudgbbuKoSBntziv5jdc1efxBrWoapdHddXtxJcyn1d2LN+pNAFKiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA6X4afEDVPhZ490LxboszQ6npF3HdwlWIyUYHafY4wRX9Mfw/8aaf8RvA+g+KdJkEum6zZQ31uwP8EiBgD784Ir+Xev3i/wCCU3xDk8cfsj6HZTjFxoNxNppbdndGrEx/T5SB+FAH2LRS0lABRRRQAUUUUAFFFFABRRRQAUtJRQAtFJRQAtJS0lABRRRQAUUUUAFFLRQAlFLSUAFFFLQAUlLSUAFFLSCgAooooAKKWkoAKKKWgBKKKWgBKKKKACiiloA8D/bz1z/hHf2QPijfB9jrpRjUj+88iIB+bV/OnX9DH/BRXS59W/Yx+J0UBG+OwjmIPdUnjYj8ga/nnoAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAr9gv8AgiTrn2z4VfEPS2fJstVt5FT0WSJufzU1+Ptfrd/wRA0uePwZ8UNQYgW8t/ZwoO5ZY5CT/wCPCgD9OqSiigAooooAKKKWgBKKWkoAWkoooAKKKKACiiigAooooAKKKKAFpKKKAFooooASiiigAooooAKKKKACiiigAooooAKKKOaACiiigAooooAWkpaSgAoopaAPLv2ovDjeLf2d/iHpKLua40a4wMf3V3f+y1/NR0r+qG/tFv7G4tn5SaNo2z6EY/rX8zXx78BT/C/41eN/CtwoV9K1e5t029DGJCYyPYoVP40AcHRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFftb/wAEaPDb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AKKKKACgAsQAMk9AKK+i/wBgv9nWX9pD9oPR9HuLd5fD2mY1HVpAp2iFCMIWHQs2APXB9KAP1j/4JgfAv/hTf7L+i3t7biHXPFBOsXRK4YRuP3Cn/tmEP1Y19c1FaWsNhaw21tEkFvCixxxRrhUUDAUDsABipaACiiigAooooAKKKKACilpKAClpKKACiiigApaSigAooooAKKWkoAKKO9FABRRRQAtJRRQAtFJn3ooAKKKKACiiigAopaSgAooooAKKKKACiiigAooooAOtFFFABRRRQACiiigAopaSgBaKSloAKSiigDz79oD4Qad8ePg94n8D6mq+VqtoUikYZ8qdSHik/wCAuqn6A1/Nz8QfBGp/DbxtrXhjWIGt9S0u6e2mjYc5U8H8Rg/jX9Q9flb/AMFfv2Tg7Wvxn8NWLbtotfEEcKZHH+quCB043Kx9koA/KqiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAAMnA5Nfu5/wS7/ZqPwL+A413VLfyvE3i0x3tyGXDRW6g+TGf++3b/gQ9K/NL/gnR+yrJ+0l8brK41W1kk8GeH5FvdTfadkzLzHBnp8zbcjrt3V++tvBHawRwwxrHDGoREUYCqBgACgCSkopaACkpaSgAooooAKKKKACilooASloooASlopKACilpKACilpKACilpKACiiloAKSiigAopaKACiiigBKKKKACiiigAooooAKKMUUAFFFFABRS0goAKKKKACiiigAooooAKKKKACiiigBaSiloASilpDQAVm+JvDmn+L/D2paJqtut3puoW721xA44dGGCD+BrTooA/m+/a2/Zz1X9mT40a34TvUMmmec0+lXnUXFoxzGc/3gpAYdiD1614xX9BP7fP7JFl+1J8ILuOxt408b6OjXWj3XRpGAJa3Y91cZAz0bBr8Ata0e88PaveaZqNu9pf2crQTwSDDI6nBBH1FAFOiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACtTwt4Z1Lxn4i07Q9HtXvdTv5lt7eCMZLuxwBWXX62f8ABJr9i/8AsPTx8ZPGWn/6fdrs8PWs6n91F1a5x6sflX0AJ7igD7R/ZA/Z2s/2ZPgboPhCMRyat5YudWuY+RNduAZCD3UH5R7KK9qpaKAEooooAKKW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";
		myCommentEvents = new ArrayList<>();
		myCommentTourFriends = new ArrayList<>();
		bookings = new ArrayList<>();
		commentTourFriends = new ArrayList<>();
		couponTourFriends = new ArrayList<>();
		pois = new ArrayList<>();
		events = new ArrayList<>();
		myRoutes = new ArrayList<>();
		languages = new ArrayList<>();
		favouriteRoutes = new ArrayList<>();

		res = new TourFriend();

		res.setAvailableBalance(availableBalance);
		res.setAvailablePoints(availablePoints);
		res.setImage(image);
		res.setMyCommentEvents(myCommentEvents);
		res.setMyCommentTourFriends(myCommentTourFriends);
		res.setBookings(bookings);
		res.setCommentTourFriends(commentTourFriends);
		res.setCouponTourFriends(couponTourFriends);
		res.setPois(pois);
		res.setEvents(events);
		res.setMyRoutes(myRoutes);
		res.setLanguages(languages);
		res.setFavouriteRoutes(favouriteRoutes);

		return res;
	}

	public void save(final TourFriend tourFriend) {
		Assert.notNull(tourFriend);

		if (tourFriend.getId() == 0) {// Nuevo admin sin guardar.
			Md5PasswordEncoder encoder;
			String hash;

			encoder = new Md5PasswordEncoder();
			hash = encoder.encodePassword(tourFriend.getUserAccount().getPassword(), null);

			tourFriend.getUserAccount().setPassword(hash);
			tourFriend.getUserAccount().setEnabled(true);
		}
		this.tourFriendRepository.save(tourFriend);
	}
	
	public void setPassword(final TourFriend tourfriend, String old_pass, String new_pass, String repeat_new_pass){
		Assert.notNull(tourfriend);
		Md5PasswordEncoder encoder;
		String hash;
		
		Md5PasswordEncoder encoder2;
		String hash2;
		
		encoder = new Md5PasswordEncoder();
		hash = encoder.encodePassword(old_pass, null);
		
		Assert.isTrue(hash.equals(tourfriend.getUserAccount().getPassword()));
		Assert.isTrue(new_pass.equals(repeat_new_pass));
		
		encoder2 = new Md5PasswordEncoder();
		hash2 = encoder2.encodePassword(new_pass, null);
		
		tourfriend.getUserAccount().setPassword(hash2);
		tourfriend.getUserAccount().setEnabled(true);
		
		this.tourFriendRepository.save(tourfriend);
		
		EmailService emailService = new EmailService();
		
		try{
			emailService.sendEmail(tourfriend.getEmail(), "New Pass!", "Congratulations! Your password has been updated successfully!");
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("Ops! Fail to send email!");
		}
		
	}

	public TourFriend findOne(final int tourFriendId) {
		Assert.notNull(tourFriendId);
		Assert.isTrue(tourFriendId != 0);

		TourFriend res;
		res = this.tourFriendRepository.findOne(tourFriendId);
		Assert.notNull(res);

		return res;
	}

	public TourFriend findOneByUserAccount(final int userAccountId) {
		Assert.notNull(userAccountId);
		Assert.isTrue(userAccountId != 0);

		UserAccount userAccount;
		TourFriend res;

		userAccount = this.userAccountService.findOne(userAccountId);
		res = this.tourFriendRepository.findActorByUserAccount(userAccount);
		Assert.notNull(res);

		return res;

	}

	public Collection<TourFriend> findAll() {
		Collection<TourFriend> res;

		res = this.tourFriendRepository.findAll();
		Assert.notNull(res);

		return res;
	}

	// Other business methods -------------------------------------------------

	public TourFriend findByPrincipal() {
		TourFriend res;
		UserAccount userAccount;

		userAccount = LoginService.getPrincipal();
		Assert.notNull(userAccount);

		res = tourFriendRepository.findTourfriendByUserAccountId(userAccount.getId());
		Assert.notNull(res);

		return res;
	}

	public TourFriend reconstruct(final TourFriendRegisterForm tourFriendRegisterForm, final BindingResult binding) {
		Assert.notNull(tourFriendRegisterForm);
		Assert.notNull(binding);

		// Comprobaciones basicas: acepta condiciones de uso y confirma
		// contraseñas
		Assert.isTrue(tourFriendRegisterForm.isTermsAndConditions());
		Assert.isTrue(tourFriendRegisterForm.getPassword1().equals(tourFriendRegisterForm.getPassword2()));

		TourFriend result;
		UserAccount userAccount;

		userAccount = this.userAccountService.createByTourFrien();
		Assert.notNull(userAccount);
		userAccount.setUsername(tourFriendRegisterForm.getUsername());
		userAccount.setPassword(tourFriendRegisterForm.getPassword1());

		result = this.create();
		result.setFirstName(tourFriendRegisterForm.getFirstName());
		result.setLastName(tourFriendRegisterForm.getLastName());
		result.setEmail(tourFriendRegisterForm.getEmail());
		result.setPhone(tourFriendRegisterForm.getPhone());
		result.setDateOfBirth(tourFriendRegisterForm.getDateOfBirth());
		result.setUserAccount(userAccount);

		// La validacion va sobre el FORM (que es lo que se va a devolver a la
		// vista) si hay errores.
		this.validator.validate(tourFriendRegisterForm, binding);

		return result;
	}

	public TourFriend reconstructProfile(final TourFriend tourFriend, final BindingResult binding) {
		Assert.notNull(tourFriend);
		Assert.notNull(binding);
		TourFriend result;

		if (tourFriend.getId() == 0)

			result = tourFriend;

		else {
			
			result = this.findByPrincipal();
			
			tourFriend.setAvailableBalance(result.getAvailableBalance());
			tourFriend.setAvailablePoints(result.getAvailablePoints());
			tourFriend.setBookings(result.getBookings());
			tourFriend.setCommentTourFriends(result.getCommentTourFriends());
			tourFriend.setCouponTourFriends(result.getCouponTourFriends());
			tourFriend.setDateOfBirth(result.getDateOfBirth());
			tourFriend.setEmail(result.getEmail());
			tourFriend.setEvents(result.getEvents());
			tourFriend.setFavouriteRoutes(result.getFavouriteRoutes());
			tourFriend.setFirstName(result.getFirstName());
			tourFriend.setLanguages(result.getLanguages());
			tourFriend.setLastName(result.getLastName());
			tourFriend.setMyCommentEvents(result.getMyCommentEvents());
			tourFriend.setMyCommentTourFriends(result.getMyCommentTourFriends());
			tourFriend.setMyRoutes(result.getMyRoutes());
			tourFriend.setPois(result.getPois());
			tourFriend.setUserAccount(result.getUserAccount());
			tourFriend.setImage(result.getImage());
			
		}

		this.validator.validate(tourFriend, binding);

		return tourFriend;
	}

	public void authenticateUserAndSetSession(String username, String pass, HttpServletRequest request) {
		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(username, pass);

		// generate session if one doesn't exist
		request.getSession();

		token.setDetails(new WebAuthenticationDetails(request));
		try {
			Authentication authenticatedUser = authenticationManager.authenticate(token);

			SecurityContextHolder.getContext().setAuthentication(authenticatedUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Collection<TourFriend> tourFriendAttendSameEvent(int eventId) {
		Collection<TourFriend> result;

		result = tourFriendRepository.tourFriendAttendSameEvent(eventId);
		Assert.notNull(result);

		return result;
	}

	public void update(TourFriend tf) {

		Assert.notNull(tf);
		tourFriendRepository.saveAndFlush(tf);
	}

	public TourFriend findAdministrator() {

		return tourFriendRepository.findOne(174);
	}

	public List<List<String>> tourfriendsHighestRated() {
		Collection<Object[]> tourfriends;
		List<List<String>> lista1 = new ArrayList<>();

		tourfriends = tourFriendRepository.tourfriendsHighestRated();
		List<Object[]> list = new ArrayList<>(tourfriends);
		if (list.size() >= 10) {
			tourfriends = list.subList(0, 10);
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

	public List<List<String>> tourfriendsLowestRated() {
		Collection<Object[]> tourfriends;
		List<List<String>> lista1 = new ArrayList<>();

		tourfriends = tourFriendRepository.tourfriendsLowestRated();
		List<Object[]> list = new ArrayList<>(tourfriends);
		if (list.size() >= 10) {
			tourfriends = list.subList(0, 10);
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

	public void ban(int tourfriendId) {
		
		
		TourFriend  tourfriend = this.findOne(tourfriendId);
		Assert.notNull(tourfriend);
		boolean result = true;
		for (Authority a : tourfriend.getUserAccount().getAuthorities()) {
			if (a.getAuthority().equals(Authority.ADMIN)) {
				result = false;
			}  
		}
		Assert.isTrue(result);
		Assert.notNull(this.administratorService.findByPrincipal());
		
			
		final UserAccount userAccount = tourfriend.getUserAccount();
		userAccount.setEnabled(false);
		tourfriend.setUserAccount(userAccount);
		this.tourFriendRepository.saveAndFlush(tourfriend);
		
	}
	
public void unBan(int tourfriendId) {
		
		TourFriend  tourfriend = this.findOne(tourfriendId);
		Assert.notNull(tourfriend);
		Assert.notNull(this.administratorService.findByPrincipal());

			
		final UserAccount userAccount = tourfriend.getUserAccount();
		userAccount.setEnabled(true);
		tourfriend.setUserAccount(userAccount);
		this.tourFriendRepository.saveAndFlush(tourfriend);
		
	}
}
