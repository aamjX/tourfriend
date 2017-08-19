package domain;

import java.util.Date;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Range;
import org.hibernate.validator.constraints.SafeHtml;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Access(AccessType.PROPERTY)
public class CommentEvent extends DomainEntity {

	// Attributes ---------------------------------------------------------

	private String description;

	private int score;

	private Date creationMoment;

	@NotBlank
	@SafeHtml
	@NotNull
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	
	@Range(min = 0, max = 5)
	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	@NotNull
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	@Past
	public Date getCreationMoment() {
		return creationMoment;
	}

	public void setCreationMoment(Date creationMoment) {
		this.creationMoment = creationMoment;
	}

	// Relationships ----------------------------------------------------------

	private TourFriend tourFriendCreator;
	private Event event;

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
	@ManyToOne(optional = false)
	@NotNull
	public Event getEvent() {
		return event;
	}

	public void setEvent(Event event) {
		this.event = event;
	}

}
