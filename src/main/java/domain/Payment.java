package domain;

import java.util.Date;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;

import org.springframework.format.annotation.DateTimeFormat;

import domain.enumeration.StatusPayment;

@Entity
@Access(AccessType.PROPERTY)
public class Payment extends DomainEntity {

	// Attributes ---------------------------------------------------------

	private double amount;
	private Date paymentMoment;
	private StatusPayment status;

	@DecimalMin(value = "0")
	@Digits(integer = 9, fraction = 2)
	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	@NotNull
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	@Past
	public Date getPaymentMoment() {
		return paymentMoment;
	}

	public void setPaymentMoment(Date paymentMoment) {
		this.paymentMoment = paymentMoment;
	}

	@NotNull
	@Enumerated(EnumType.STRING)
	public StatusPayment getStatus() {
		return status;
	}

	public void setStatus(StatusPayment status) {
		this.status = status;
	}

	// Relationships ----------------------------------------------------------

}
