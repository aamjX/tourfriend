package domain;

import java.util.Collection;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.SafeHtml;

@Entity
@Access(AccessType.PROPERTY)
public class Poi extends DomainEntity {

	// Attributes ---------------------------------------------------------

	private String description;
	private String name;
	private String place;
	private Collection<String> photos;


	@NotBlank
	@SafeHtml
	@NotNull
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

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
	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}
	
	@Valid
	@NotNull
	@ElementCollection
	@Column(length = 50000)
	public Collection<String> getPhotos() {
		return photos;
	}

	public void addPhoto(String photo) {
		this.photos.add(photo);
	}

	public void removePhoto(String photo) {
		this.photos.remove(photo);
	}

	public void setPhotos(Collection<String>photos){
		this.photos = photos;
	}


	// Relationships ----------------------------------------------------------

	private TourFriend tourFriendCreator;
	private Collection<Route> routes;

	
	@Valid
	@ManyToOne(optional = false)
	@NotNull
	public TourFriend getTourFriendCreator() {
		return tourFriendCreator;
	}

	public void setTourFriendCreator(TourFriend tourFriend) {
		this.tourFriendCreator = tourFriend;
	}

	@Valid
	@ManyToMany(mappedBy = "pois")
	@NotNull
	public Collection<Route> getRoutes() {
		return routes;
	}

	public void addRoute(Route route) {
		this.routes.add(route);
	}

	public void removeRoute(Route route) {
		this.routes.remove(route);
	}

	public void setRoutes(Collection<Route> routes) {
		this.routes = routes;
	}

}
