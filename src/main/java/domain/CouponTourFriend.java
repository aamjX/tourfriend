package domain;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.validation.Valid;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.SafeHtml;

@Entity
@Access(AccessType.PROPERTY)
public class CouponTourFriend extends DomainEntity{
	
	// Attributes ---------------------------------------------------------
	
	
    private String name;
    private String description;
    private Double value;
    private boolean isUsed;

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

    @DecimalMin(value = "0")
    @Digits(integer = 9, fraction = 2)
    public double getValue() {
        return value;
    }
    public void setValue(double value) {
        this.value = value;
    }

    public boolean getIsUsed() {
        return isUsed;
    }
    public void setIsUsed(boolean isUsed) {
        this.isUsed = isUsed;
    }
	
	// Relationships ----------------------------------------------------------
    
  
    private TourFriend tourFriend;
    
    @Valid
    @ManyToOne(optional = false)
    @NotNull
    public TourFriend getTourFriend() {
        return tourFriend;
    }
    public void setTourFriend(TourFriend tourFriend) {
        this.tourFriend = tourFriend;
    }


}
