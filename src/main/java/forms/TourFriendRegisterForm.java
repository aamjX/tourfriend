package forms;

import java.util.Date;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.SafeHtml;
import org.springframework.format.annotation.DateTimeFormat;

public class TourFriendRegisterForm {

	// Attributes ---------------------------------------------------------

	private String firstName;
	private String lastName;
	private String email;
	private String phone;
	private Date dateOfBirth;
	private String username;
	private String password1;
	private String password2;
	private boolean termsAndConditions;

	// Constructor ---------------------------------------------------------

	public TourFriendRegisterForm() {
		super();
	}

	// Getters and Setters --------------------------------------------------

	@NotBlank
	@NotNull
	@SafeHtml
	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	@NotBlank
	@NotNull
	@SafeHtml
	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	@NotBlank
	@NotNull
	@Email
	@SafeHtml
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@NotBlank
	@NotNull
	@SafeHtml
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	@NotNull
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "dd/MM/yyyy")
	@Past
	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	@Size(min = 5, max = 32)
	@SafeHtml
	public String getUsername() {
		return this.username;
	}

	public void setUsername(final String username) {
		this.username = username;
	}

	@Size(min = 5, max = 32)
	@SafeHtml
	public String getPassword1() {
		return this.password1;
	}

	public void setPassword1(final String password1) {
		this.password1 = password1;
	}

	@Size(min = 5, max = 32)
	@SafeHtml
	public String getPassword2() {
		return this.password2;
	}

	public void setPassword2(final String password2) {
		this.password2 = password2;
	}

	public boolean isTermsAndConditions() {
		return this.termsAndConditions;
	}

	public void setTermsAndConditions(final boolean termsAndConditions) {
		this.termsAndConditions = termsAndConditions;
	}

}
