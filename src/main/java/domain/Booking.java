package domain;

import java.util.Date;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.Valid;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Access(AccessType.PROPERTY)
public class Booking extends DomainEntity{

	// Attributes ---------------------------------------------------------

	private Date bookingMoment;
	private boolean isCancelled;
	private Date cancelledMoment;
	private boolean isPaied;
	private int numPeople;
	
	@NotNull
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	@Past
	@Temporal(TemporalType.TIMESTAMP)
	public Date getBookingMoment() {
		return bookingMoment;
	}

	public void setBookingMoment(Date bookingMoment) {
		this.bookingMoment = bookingMoment;
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

	public Boolean getIsPaied() {
		return isPaied;
	}

	public void setIsPaied(Boolean isPaied) {
		this.isPaied = isPaied;
	}
	
	@Min(value = 1)
	public int getNumPeople() {
        return numPeople;
    }
	
	public void setNumPeople(int numPeople) {
        this.numPeople = numPeople;
    }

	// Relationships ----------------------------------------------------------
	
	
    private Payment payment;
    private Code code;
    private TourFriend tourFriend;
    private Event event;
    
    @Valid
    @NotNull
    @OneToOne(optional = false)
    public Payment getPayment() {
        return payment;
    }

    public void setPayment(Payment payment) {
        this.payment = payment;
    }

    @Valid
    @NotNull
    @OneToOne(optional = false)
    public Code getCode() {
        return code;
    }
    public void setCode(Code code) {
        this.code = code;
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
    @NotNull
    @ManyToOne(optional = false)
    public Event getEvent() {
        return event;
    }
    public void setEvent(Event event) {
        this.event = event;
    }

}
