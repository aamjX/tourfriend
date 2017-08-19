package domain;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.SafeHtml;

@Entity
@Access(AccessType.PROPERTY)
public class Code extends DomainEntity {

	// Attributes ---------------------------------------------------------

	private String value;

	private boolean isVerified;

	@NotBlank
	@NotNull
	@SafeHtml
	@Size(min = 8, max = 8)
	@Pattern(regexp = "^[0-9A-Za-z]{8}$")
	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public Boolean getIsVerified() {
		return isVerified;
	}

	public void setIsVerified(Boolean isVerified) {
		this.isVerified = isVerified;
	}

	// Relationships ----------------------------------------------------------

}
