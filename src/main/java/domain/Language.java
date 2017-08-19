package domain;

import java.util.Collection;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.ManyToMany;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

import domain.enumeration.LanguageEnum;

@Entity
@Access(AccessType.PROPERTY)
public class Language extends DomainEntity {

	// Attributes ---------------------------------------------------------

	private LanguageEnum name;
	
	
	@NotNull
	@Enumerated(EnumType.STRING)
	public LanguageEnum getName() {
		return name;
	}
	public void setName(LanguageEnum name) {
		this.name = name;
	}

	// Relationships ----------------------------------------------------------

	
    private Collection<TourFriend> tourFriends;
	
    @Valid
    @ManyToMany(mappedBy = "languages")
	@NotNull
	public Collection<TourFriend> getTourFriends() {
        return tourFriends;
    }
    public void addTourFriend(TourFriend tourFriend) {
        this.tourFriends.add(tourFriend);
    }
    public void removeTourFriend(TourFriend tourFriend) {
        this.tourFriends.remove(tourFriend);
    }
    public void setTourFriends(Collection<TourFriend> tourFriends) {
        this.tourFriends = tourFriends;
    }
	
}
