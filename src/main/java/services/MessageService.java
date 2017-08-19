package services;

import java.util.Collection;
import java.util.Date;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import domain.Actor;
import domain.Message;
import repositories.MessageRepository;

@Service
@Transactional
public class MessageService {
	
	// Repositories -----------------------------------------------------------
	
	@Autowired
	private MessageRepository messageRepository;
	
	// Supporting services ----------------------------------------------------
	
	@Autowired
	private ActorService actorService;
	@Autowired
	private TourFriendService tourfriendService;
	
	// Constructors -----------------------------------------------------------
	
	// Simple CRUD methods ----------------------------------------------------
	
	public Message create(int recipientActorId) {
		Message result;
		Actor senderActor;
		Date sentMoment;
		Actor recipientActor;
		
		senderActor = actorService.findByPrincipal();
		recipientActor = actorService.findOne(recipientActorId);
		if (recipientActor == null){
			recipientActor = actorService.findOneByUserAccount(tourfriendService.findOne(recipientActorId).getUserAccount().getId());
		}
		sentMoment = new Date();

		result = new Message();

		result.setIsRead(true);
		result.setIsRecipientCopy(false);
		result.setSenderActor(senderActor);
		result.setRecipientActor(recipientActor);
		result.setSentMoment(sentMoment);
		
		return result;
	}


	public Message save(Message message) {
		Assert.notNull(message);
	
		return messageRepository.saveAndFlush(message);
	}
	
	public void delete(Message message) {
		Assert.notNull(message);
		Assert.isTrue(message.getId() != 0);

		Actor principal;

		principal = actorService.findByPrincipal();
		
		Assert.isTrue(principal.equals(message.getSenderActor()) || principal.equals(message.getRecipientActor()));
			
		messageRepository.delete(message);
		
	}


	public Message findOneToDisplay(int messageId) {
		// Associated business rules:
		//  - No messages from other user should be retrieved
		Message result;
		Actor principal;
		
		principal = actorService.findByPrincipal();
		
		result = messageRepository.findOne(messageId);
		
		Assert.isTrue(result.getRecipientActor().equals(principal) || result.getSenderActor().equals(principal));
		
		return result;
	}
	
	// Other business methods -------------------------------------------------
	
	public Collection<Message> findSentMessages(){
		Collection<Message> result;
		Actor principal;
		
		principal = actorService.findByPrincipal();
		result = messageRepository.findSentMessages(principal.getId());
		
		return result;
	}
	
	public Collection<Message> findReceivedMessages(){
		Collection<Message> result;
		Actor principal;
		
		principal = actorService.findByPrincipal();
		result = messageRepository.findReceivedMessages(principal.getId());
		
		return result;
	}
	
	public Integer getNotReadMessages(Actor actor){
		Integer result = 0;
		
		result = messageRepository.getNoReadMessages(actor.getId());
	
		return result;
	}
		
	public Integer numberOfMessagesToday(int senderActorId, int recipientActorId){
		Integer result;
		
		result = messageRepository.numberOfMessagesToday(senderActorId, recipientActorId);
		System.out.println(result);
		return result;
	}
	
	public int existingBookingBetweenTourFriends(int senderTourfriendId, int recipientTourfriendId){
		int result;
		
		result = messageRepository.existingBookingBetweenTourFriends(senderTourfriendId, recipientTourfriendId).size();
		System.out.println(result);
		return result;
	}

}
