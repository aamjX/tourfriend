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
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.SafeHtml;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Access(AccessType.PROPERTY)
public class Message extends DomainEntity {

	// Attributes ---------------------------------------------------------

	private String subject;
	private String body;
	private Date sentMoment;
	private boolean isRead;
	private boolean isRecipientCopy;

	@Size(max = 150)
	@NotBlank
	@SafeHtml
	@NotNull
	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	@NotBlank
	@SafeHtml
	@NotNull
	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	@NotNull
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	@Past
	public Date getSentMoment() {
		return sentMoment;
	}

	public void setSentMoment(Date sentMoment) {
		this.sentMoment = sentMoment;
	}

	public boolean getIsRead() {
		return isRead;
	}

	public void setIsRead(boolean isRead) {
		this.isRead = isRead;
	}
	
	public boolean getIsRecipientCopy() {
		return isRecipientCopy;
	}

	public void setIsRecipientCopy(boolean isRecipientCopy) {
		this.isRecipientCopy = isRecipientCopy;
	}

	// Relationships ----------------------------------------------------------
	
	
    private Actor senderActor;
    private Actor recipientActor;
    
    @Valid
    @ManyToOne(optional = false)
    @NotNull
    public Actor getSenderActor() {
        return senderActor;
    }
    public void setSenderActor(Actor actor) {
        this.senderActor = actor;
    }

    @Valid
    @ManyToOne(optional = false)
    @NotNull
    public Actor getRecipientActor() {
        return recipientActor;
    }
    public void setRecipientActor(Actor actor) {
        this.recipientActor = actor;
    }



}
