package repositories;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.TourFriend;
import security.UserAccount;

@Repository
public interface TourFriendRepository extends JpaRepository<TourFriend, Integer> {

	@Query("select t from TourFriend t where t.userAccount = ?1")
	TourFriend findActorByUserAccount(UserAccount userAccount);

	@Query("select t from TourFriend t where t.userAccount.id = ?1")
	TourFriend findTourfriendByUserAccountId(int userAccountId);

	@Query("select distinct b.tourFriend from Booking b where b.event.id = ?1 and b.isCancelled = false")
	Collection<TourFriend> tourFriendAttendSameEvent(int eventId);

	// Tourfriend con mas comentarios
	@Query("select t from TourFriend t order by t.commentTourFriends.size DESC")
	Collection<TourFriend> tourfriendsMoreComments();

	// Tourfriend con menos comentarios
	@Query("select t from TourFriend t order by t.commentTourFriends.size ASC")
	Collection<TourFriend> tourfriendsLessComments();

	// Tourfriends con mejor puntuacion
	//@Query("select t.firstName,sum(c.score)/t.commentTourFriends.size*1.0 from TourFriend t join t.commentTourFriends c group by t order by sum(c.score)/t.commentTourFriends.size*1.0 DESC")
	@Query("select t.firstName,avg(c.score) from TourFriend t join t.commentTourFriends c group by t order by avg(c.score) DESC")
	Collection<Object[]> tourfriendsHighestRated();

	// Tourfriends con peor puntuacion
	//@Query("select t.firstName,sum(c.score)/t.commentTourFriends.size*1.0 from TourFriend t join t.commentTourFriends c group by t order by sum(c.score)/t.commentTourFriends.size*1.0 ASC")
	@Query("select t.firstName,avg(c.score) from TourFriend t join t.commentTourFriends c group by t order by avg(c.score) ASC")
	Collection<Object[]> tourfriendsLowestRated();

}
