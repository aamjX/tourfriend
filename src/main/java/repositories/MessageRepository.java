package repositories;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.Booking;
import domain.Message;

@Repository
public interface MessageRepository extends JpaRepository<Message, Integer> {
	
	@Query("select m from Message m where m.senderActor.id = ?1 and m.isRecipientCopy = false")
	Collection<Message> findSentMessages(int principalId);
	
	@Query("select m from Message m where m.recipientActor.id = ?1 and m.isRecipientCopy = true")
	Collection<Message> findReceivedMessages(int principalId);
	
	@Query("select count(m) from Message m where m.recipientActor.id = ?1 and m.isRead = false")
	Integer getNoReadMessages(int principalId);
	
	@Query("select b from Booking b where (b.tourFriend.id = ?1 and b.event.tourFriend.id = ?2 and b.isCancelled = false and date_format(b.event.date, '%Y-%m-%d') >= curdate()) or (b.tourFriend.id = ?2 and b.event.tourFriend.id = ?1 and b.isCancelled = false and date_format(b.event.date, '%Y-%m-%d') >= curdate())")
	Collection<Booking> existingBookingBetweenTourFriends(int senderTourfriendId, int recipientTourfriendId);
	
	@Query("select count(m)/2 from Message m where m.senderActor.id = ?1 and m.recipientActor.id = ?2 and date_format(m.sentMoment, '%Y-%m-%d') = current_date")
	Integer numberOfMessagesToday(int senderActorId, int recipientActorId);
	
}
