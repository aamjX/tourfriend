package domain;

import java.util.Collection;
import java.util.Date;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.Valid;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Digits;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.SafeHtml;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Access(AccessType.PROPERTY)
public class TourFriend extends Actor {

	// Attributes ---------------------------------------------------------

	private double availableBalance;
	private int availablePoints;
	private String aboutMe;
	private Date dateOfBirth;
	private String image;
	private Double rating;


	@DecimalMin(value = "0")
	@Digits(integer = 9, fraction = 2)
	public double getAvailableBalance() {
		return availableBalance;
	}

	public void setAvailableBalance(double availableBalance) {
		this.availableBalance = availableBalance;
	}

	@Min(value = 0)
	public int getAvailablePoints() {
		return availablePoints;
	}

	public void setAvailablePoints(int availablePoints) {
		this.availablePoints = availablePoints;
	}

	@SafeHtml
	public String getAboutMe() {
		return aboutMe;
	}

	public void setAboutMe(String aboutMe) {
		this.aboutMe = aboutMe;
	}

	@NotNull
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "dd/MM/yyyy")
	@Past
	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	@NotNull
	@NotBlank
	@Column(length = 50000)
	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	
	@Transient
	public Double getRating() {
		rating = 0.0;
		Double res = 0.0;
		for(CommentTourFriend c: this.commentTourFriends){
			rating+=c.getScore();
		}
		int count = commentTourFriends.size();
		if(count!=0){
			res = rating/count;
		}
		return res;
	}


	// Relationships ----------------------------------------------------------

	private Collection<CommentEvent> myCommentEvents;
	private Collection<CommentTourFriend> myCommentTourFriends;
	private Collection<Booking> bookings;
	private Collection<CommentTourFriend> commentTourFriends;
	private Collection<CouponTourFriend> couponTourFriends;
	private Collection<Poi> pois;
	private Collection<Event> events;
	private Collection<Route> myRoutes;
	private Collection<Language> languages;
	private Collection<Route> favouriteRoutes;

	@Valid
	@OneToMany(mappedBy = "tourFriendCreator")
	@NotNull
	public Collection<CommentEvent> getMyCommentEvents() {
		return myCommentEvents;
	}

	public void addMyCommentEvent(CommentEvent commentEvent) {
		this.myCommentEvents.add(commentEvent);
	}

	public void removeMyCommentEvent(CommentEvent commentEvent) {
		this.myCommentEvents.remove(commentEvent);
	}

	public void setMyCommentEvents(Collection<CommentEvent> commentEvents) {
		this.myCommentEvents = commentEvents;
	}

	@Valid
	@OneToMany(mappedBy = "tourFriendCreator")
	@NotNull
	public Collection<CommentTourFriend> getMyCommentTourFriends() {
		return myCommentTourFriends;
	}

	public void addMyCommentTourFriend(CommentTourFriend commentTourFriend) {
		this.myCommentTourFriends.add(commentTourFriend);
	}

	public void removeMyCommentTourFriend(CommentTourFriend commentTourFriend) {
		this.myCommentTourFriends.remove(commentTourFriend);
	}

	public void setMyCommentTourFriends(Collection<CommentTourFriend> commentTourFriends) {
		this.myCommentTourFriends = commentTourFriends;
	}

	@Valid
	@OneToMany(mappedBy = "tourFriend")
	@NotNull
	public Collection<Booking> getBookings() {
		return bookings;
	}

	public void addBooking(Booking booking) {
		this.bookings.add(booking);
	}

	public void removeBooking(Booking booking) {
		this.bookings.remove(booking);
	}

	public void setBookings(Collection<Booking> bookings) {
		this.bookings = bookings;
	}

	@Valid
	@OneToMany(mappedBy = "tourFriend")
	@NotNull
	public Collection<CommentTourFriend> getCommentTourFriends() {
		return commentTourFriends;
	}

	public void addCommentTourFriend(CommentTourFriend commentTourFriend) {
		this.commentTourFriends.add(commentTourFriend);
	}

	public void removeCommentTourFriend(CommentTourFriend commentTourFriend) {
		this.commentTourFriends.remove(commentTourFriend);
	}

	public void setCommentTourFriends(Collection<CommentTourFriend> commentTourFriends) {
		this.commentTourFriends = commentTourFriends;
	}

	@Valid
	@OneToMany(mappedBy = "tourFriend")
	@NotNull
	public Collection<CouponTourFriend> getCouponTourFriends() {
		return couponTourFriends;
	}

	public void addCouponTourFriend(CouponTourFriend couponTourFriend) {
		this.couponTourFriends.add(couponTourFriend);
	}

	public void removeCouponTourFriend(CouponTourFriend couponTourFriend) {
		this.couponTourFriends.remove(couponTourFriend);
	}

	public void setCouponTourFriends(Collection<CouponTourFriend> couponTourFriends) {
		this.couponTourFriends = couponTourFriends;
	}

	@Valid
	@OneToMany(mappedBy = "tourFriendCreator")
	@NotNull
	public Collection<Poi> getPois() {
		return pois;
	}

	public void addPoi(Poi poi) {
		this.pois.add(poi);
	}

	public void removePoi(Poi poi) {
		this.pois.remove(poi);
	}

	public void setPois(Collection<Poi> pois) {
		this.pois = pois;
	}

	@Valid
	@OneToMany(mappedBy = "tourFriend")
	@NotNull
	public Collection<Event> getEvents() {
		return events;
	}

	public void addEvent(Event event) {
		this.events.add(event);
	}

	public void removeEvent(Event event) {
		this.events.remove(event);
	}

	public void setEvents(Collection<Event> events) {
		this.events = events;
	}

	@Valid
	@OneToMany(mappedBy = "tourFriendCreator")
	@NotNull
	public Collection<Route> getMyRoutes() {
		return myRoutes;
	}

	public void addMyRoute(Route route) {
		this.myRoutes.add(route);
	}

	public void removeMyRoute(Route route) {
		this.myRoutes.remove(route);

	}

	public void setMyRoutes(Collection<Route> routes) {
		this.myRoutes = routes;
	}

	@Valid
	@ManyToMany
	@NotNull
	public Collection<Language> getLanguages() {
		return languages;
	}

	public void addLanguage(Language language) {
		this.languages.add(language);

	}

	public void removeLanguage(Language language) {
		this.languages.remove(language);
	}

	public void setLanguages(Collection<Language> languages) {
		this.languages = languages;
	}

	@Valid
	@ManyToMany
	@NotNull
	public Collection<Route> getFavouriteRoutes() {
		return favouriteRoutes;
	}

	public void addFavouriteRoute(Route route) {
		this.favouriteRoutes.add(route);
	}

	public void removeFavouriteRoute(Route route) {
		this.favouriteRoutes.remove(route);
	}
	
	public void setFavouriteRoutes(Collection<Route> routes) {
		this.favouriteRoutes = routes;
	}

}
