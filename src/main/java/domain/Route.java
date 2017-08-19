package domain;

import java.util.Collection;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.persistence.Transient;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.SafeHtml;

@Entity
@Access(AccessType.PROPERTY)
public class Route extends DomainEntity {

	// Attributes ---------------------------------------------------------

	private String name;
	private String description;
	private boolean isDisabled;
	private String city;
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
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public boolean getIsDisabled() {
		return isDisabled;
	}

	public void setIsDisabled(boolean isDisabled) {
		this.isDisabled = isDisabled;
	}

	@NotBlank
	@SafeHtml
	@NotNull
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	@Transient
	public Double getRating() {
		rating = 0.0;
		for (Event e : this.events) {
			rating += e.getRating();
		}

		return rating / events.size();
	}

	// Relationships ----------------------------------------------------------

	private Collection<Event> events;
	private Collection<Poi> pois;
	private Collection<Category> categories;
	private TourFriend tourFriendCreator;
	private Collection<TourFriend> favouriteTourFriends;

	@OneToMany(mappedBy = "route")
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

	@ManyToMany
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

	@ManyToMany
	@NotNull
	public Collection<Category> getCategories() {
		return categories;
	}

	public void addCategory(Category category) {
		this.categories.add(category);
	}

	public void removeCategory(Category category) {
		this.categories.remove(category);
	}

	public void setCategories(Collection<Category> categories) {
		this.categories = categories;
	}

	@Valid
	@ManyToOne(optional = true)
	@NotNull
	public TourFriend getTourFriendCreator() {
		return tourFriendCreator;
	}

	public void setTourFriendCreator(TourFriend tourFriend) {
		this.tourFriendCreator = tourFriend;
	}

	@ManyToMany(mappedBy = "favouriteRoutes")
	@NotNull
	public Collection<TourFriend> getFavouriteTourFriends() {
		return favouriteTourFriends;
	}

	public void addFavouriteTourFriend(TourFriend tourFriend) {
		this.favouriteTourFriends.add(tourFriend);
	}

	public void removeFavouriteTourFriend(TourFriend tourFriend) {
		this.favouriteTourFriends.remove(tourFriend);
	}

	public void setFavouriteTourFriends(Collection<TourFriend> tourFriends) {
		this.favouriteTourFriends = tourFriends;
	}

}
