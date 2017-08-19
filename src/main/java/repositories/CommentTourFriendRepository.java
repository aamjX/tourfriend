package repositories;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.CommentTourFriend;

@Repository
public interface CommentTourFriendRepository extends JpaRepository<CommentTourFriend, Integer> {
	
	@Query("select c from CommentTourFriend c where c.tourFriend.id = ?1 order by c.creationMoment")
	Collection<CommentTourFriend> findByTourFriend(int tourfriendId);
	
	@Query("select c from CommentTourFriend c where c.tourFriend.id = ?1 and c.tourFriendCreator.id = ?2")
	Collection<CommentTourFriend> commentsBetweenTourfriends(int tourfriendID, int tourfriendCreatorID);

}