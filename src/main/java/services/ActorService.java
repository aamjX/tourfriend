package services;

import java.util.Collection;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import domain.Actor;
import repositories.ActorRepository;
import security.Authority;
import security.LoginService;
import security.UserAccount;

@Service
@Transactional
public class ActorService {

	// Managed repository -----------------------------------------------------

	@Autowired
	private ActorRepository			actorRepository;

	// Supporting services ----------------------------------------------------

	@Autowired
	private AdministratorService	administratorService;
	@Autowired
	UserAccountService userAccountService;
	@Autowired
	private TourFriendService			tourFriendService;
	

	// Constructors -----------------------------------------------------------
	public ActorService() {
		super();
	}

	// Simple CRUD methods ----------------------------------------------------
	
	public void save(Actor actor) {
		Assert.notNull(actor);
		actorRepository.save(actor);
	}

	public Collection<Actor> findAll() {
		Collection<Actor> res;

		res = actorRepository.findAll();
		Assert.notNull(res);

		return res;
	}
	
	// Other business methods -------------------------------------------------

		public Actor findByPrincipal() {
			Actor result;
			UserAccount userAccount;
			Collection<Authority> authorities;

			userAccount = LoginService.getPrincipal();
			Assert.notNull(userAccount);
			authorities = userAccount.getAuthorities();

			result = null;
			for (Authority a : authorities) {
				if (a.getAuthority().equals(Authority.ADMIN)) {
					result = administratorService.findByPrincipal();
				}  else if (a.getAuthority().equals(Authority.TOURFRIEND)) {
					result = tourFriendService.findByPrincipal();
				} 
			}
			Assert.notNull(result);

			return result;
		}
		
		public Actor findOne(int actorId) {
			// Associated business rules:
			//	- The id passed as parameter must be associated to an actor
			Actor result;
			
			result = actorRepository.findOne(actorId);
			Assert.notNull(result);
			
			return result;
		}
		
		public Actor findOneByUserAccount(final int userAccountId) {
			Assert.notNull(userAccountId);
			Assert.isTrue(userAccountId != 0);

			UserAccount userAccount;
			Actor res;

			userAccount = this.userAccountService.findOne(userAccountId);
			res = this.actorRepository.findActorByUserAccount(userAccount.getId());
			Assert.notNull(res);

			return res;

		}


}
