package domain;

import java.util.Collection;
import java.util.Date;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
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
public class Event extends DomainEntity {

	// Attributes ---------------------------------------------------------

	private String name;
	private String overview;
	private Double price;
	private String meetingPoint;
	private int minPeople;
	private int maxPeople;
	private Date date;
	private Double duration;
	private boolean isCancelled;
	private Date cancelledMoment;
	private String thingsToNote;
	private Integer availableSlots;
	private Double rating;
	
	@NotBlank
	@SafeHtml
	@NotNull
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@NotBlank
	@SafeHtml
	@NotNull
	public String getOverview() {
		return overview;
	}

	public void setOverview(String overview) {
		this.overview = overview;
	}

	@DecimalMin(value = "0")
	@Digits(integer = 9, fraction = 2)
	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	@NotBlank
	@SafeHtml
	@NotNull
	public String getMeetingPoint() {
		return meetingPoint;
	}

	public void setMeetingPoint(String meetingPoint) {
		this.meetingPoint = meetingPoint;
	}

	@Min(value = 1)
	public int getMinPeople() {
		return minPeople;
	}

	public void setMinPeople(int minPeople) {
		this.minPeople = minPeople;
	}

	@Min(value = 1)
	public int getMaxPeople() {
		return maxPeople;
	}

	public void setMaxPeople(int maxPeople) {
		this.maxPeople = maxPeople;
	}

	@NotNull
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
	@DecimalMin(value = "0.5")
	@Digits(integer = 9, fraction = 2)
	public Double getDuration() {
		return duration;
	}

	public void setDuration(Double duration) {
		this.duration = duration;
	}

	public Boolean getIsCancelled() {
		return isCancelled;
	}

	public void setIsCancelled(Boolean isCancelled) {
		this.isCancelled = isCancelled;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	@Past
	public Date getCancelledMoment() {
		return cancelledMoment;
	}

	public void setCancelledMoment(Date cancelledMoment) {
		this.cancelledMoment = cancelledMoment;
	}

	@SafeHtml
	public String getThingsToNote() {
		return thingsToNote;
	}

	public void setThingsToNote(String thingsToNote) {
		this.thingsToNote = thingsToNote;
	}
	
	@Transient
	public Integer getAvailableSlots(){

		Integer availableSlots = getMaxPeople();

		for (Booking b : getBookings()) {
			if (!b.getIsCancelled()){
				availableSlots = availableSlots - b.getNumPeople();
			}
		}

		return availableSlots;
	}
	
	@Transient
	public Double getRating() {
		rating = 0.0;
		int count;
		Double res = 0.0;
		for(CommentEvent c: this.commentEvents){
			rating+=c.getScore();			
		}
		count = commentEvents.size();
		if(count!=0){
			res= rating/count;
		}
		return res;
	}
	
	

	// Relationships ----------------------------------------------------------

	private Collection<CommentEvent> commentEvents;
	private Collection<Booking> bookings;
	private TourFriend tourFriend;
	private Route route;

	@Valid
	@OneToMany(mappedBy = "event")
	@NotNull
	public Collection<CommentEvent> getCommentEvents() {
		return commentEvents;
	}

	public void addCommentEvent(CommentEvent commentEvent) {
		this.commentEvents.add(commentEvent);
	}

	public void removeCommentEvent(CommentEvent commentEvent) {
		this.commentEvents.remove(commentEvent);

	}

	public void setCommentEvents(Collection<CommentEvent> commentEvents) {
		this.commentEvents = commentEvents;
	}

	@Valid
	@OneToMany(mappedBy = "event")
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
	@ManyToOne(optional = false)
	@NotNull
	public TourFriend getTourFriend() {
		return tourFriend;
	}

	public void setTourFriend(TourFriend tourFriend) {
		this.tourFriend = tourFriend;
	}

	@Valid
	@ManyToOne(optional = false)
	@NotNull
	public Route getRoute() {
		return route;
	}

	public void setRoute(Route route) {
		this.route = route;
	}

		
	@Transient
	public Integer getNumberOfBookings(){

		Integer numberOfBookings = 0;

		for (Booking b : getBookings()) {
			if (!b.getIsCancelled()){
				numberOfBookings = numberOfBookings + b.getNumPeople();
			}
		}

		return numberOfBookings;
	}

}
