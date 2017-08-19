package services;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import security.Authority;
import security.UserAccount;
import security.UserAccountRepository;

@Service
@Transactional
public class UserAccountService {

	// Managed repository -----------------------------------------------------

	@Autowired
	private UserAccountRepository	userAccountRepository;


	// Supporting services ----------------------------------------------------

	// Constructors -----------------------------------------------------------

	public UserAccountService() {
		super();
	}

	// Simple CRUD methods ----------------------------------------------------

	public UserAccount createByAdmin() {
		UserAccount result;
		Collection<Authority> authorities;
		Authority authority;

		authority = new Authority();
		authority.setAuthority("ADMIN");
		authorities = new ArrayList<Authority>();
		authorities.add(authority);

		result = new UserAccount();
		result.setAuthorities(authorities);

		return result;
	}

	public UserAccount createByTourFrien() {
		UserAccount result;
		Collection<Authority> authorities;
		Authority authority;

		authority = new Authority();
		authority.setAuthority("TOURFRIEND");
		authorities = new ArrayList<Authority>();
		authorities.add(authority);

		result = new UserAccount();
		result.setAuthorities(authorities);

		return result;
	}

	public UserAccount save(final UserAccount userAccount) {
		Assert.notNull(userAccount);
		UserAccount result;

		result = this.userAccountRepository.save(userAccount);

		return result;
	}

	public UserAccount findOne(final int id) {
		Assert.notNull(id);
		Assert.isTrue(id != 0);
		UserAccount result;

		result = this.userAccountRepository.findOne(id);
		Assert.notNull(result);

		return result;
	}

	public Collection<UserAccount> findAll() {
		Collection<UserAccount> result;

		result = this.userAccountRepository.findAll();
		Assert.notNull(result);

		return result;
	}

	// Other business methods -------------------------------------------------

}
