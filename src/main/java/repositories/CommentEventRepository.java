package repositories;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.CommentEvent;

@Repository
public interface CommentEventRepository extends JpaRepository<CommentEvent, Integer> {
	
	@Query("select e.commentEvents from Event e where e.route.id = ?1")
	Collection<CommentEvent> commentEventOfEventsSameRoute(int routeId);
	
	@Query("select sum(e.commentEvents.size) from Event e where e.route.id = ?1")
	int numOfCommentOfEventOfARoute(int routeId);
	
	@Query("select c from CommentEvent c where c.tourFriendCreator.id = ?1 and c.event.id = ?2")
	Collection<CommentEvent> commentsBetweenTourfriendAndEvent(int tourfriendCreatorID, int eventID);

}
