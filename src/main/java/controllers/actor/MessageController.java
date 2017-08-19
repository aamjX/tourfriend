package controllers.actor;

import java.util.Collection;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import controllers.AbstractController;
import domain.Message;
import domain.TourFriend;
import services.EmailService;
import services.MessageService;
import services.TourFriendService;

@Controller
@RequestMapping("/message/actor")
public class MessageController extends AbstractController{
	
	// Supporting services ----------------------------------------------------
	
	@Autowired
	private MessageService messageService;
	@Autowired
	private TourFriendService tourfriendService;
	

	
	// Constructors -----------------------------------------------------------
	
	public MessageController(){
		super();
	}

	// Listing ----------------------------------------------------------------
	
	@RequestMapping(value="list", method=RequestMethod.GET)
	public ModelAndView listInboxMessages(){
		ModelAndView result;
		Collection<Message> messages;
		
		messages = messageService.findReceivedMessages();
		
		result = new ModelAndView("message/list");
		result.addObject("messages", messages);
		result.addObject("requestURI", "message/actor/list.do");
		result.addObject("folder", "Inbox");
		 
		return result;
	}
	
	@RequestMapping(value="listOutbox", method=RequestMethod.GET)
	public ModelAndView listOutboxMessages(){
		ModelAndView result;
		Collection<Message> messages;
		
		messages = messageService.findSentMessages();
		
		result = new ModelAndView("message/list");
		result.addObject("messages", messages);
		result.addObject("requestURI", "message/actor/listOutbox.do");
		result.addObject("folder", "outbox");
		 
		return result;
	}
	
	// Displaying -------------------------------------------------------------
	
	@RequestMapping(value="/display", method=RequestMethod.GET)
	public ModelAndView display(@RequestParam(required=true) int messageId){
		ModelAndView result;
		Message message;
		
		message = messageService.findOneToDisplay(messageId);
		message.setIsRead(true);
		messageService.save(message);
		
		result = new ModelAndView("message/display");
		result.addObject("displayedMessage", message);
		
		return result;	
	}
	
	// Creating ---------------------------------------------------------------
	
	@RequestMapping(value="/create", method=RequestMethod.GET)
	public ModelAndView create(@RequestParam int tourfriendId){
		ModelAndView result;
		Message message;
		
		message = messageService.create(tourfriendId);
		
		result = createModelAndView(message);
		
		return result;
		
	}
	
	@RequestMapping(value = "/create", method = RequestMethod.POST, params = "save")
	public ModelAndView save(@ModelAttribute("messageToEdit") @Valid Message message, BindingResult binding) {
		ModelAndView result;
		Integer noMessagesToday;
		TourFriend sender;
		TourFriend recipient; 
		
		if (binding.hasErrors()) {
			result = createModelAndView(message);
		} else {
			try {
				
				sender = tourfriendService.findOneByUserAccount(message.getSenderActor().getUserAccount().getId());
				recipient = tourfriendService.findOneByUserAccount(message.getRecipientActor().getUserAccount().getId());
				
				if(messageService.existingBookingBetweenTourFriends(sender.getId(), recipient.getId()) == 0){
					noMessagesToday = messageService.numberOfMessagesToday(message.getSenderActor().getId(), message.getRecipientActor().getId() );
					if(noMessagesToday < 3){
						messageService.save(message);
						message.setIsRead(false);
						message.setIsRecipientCopy(true);
						messageService.save(message);

						EmailService emailService = new EmailService();
						try{
							emailService.sendEmail(message.getRecipientActor().getEmail(), message.getSubject(), message.getBody());
						}catch (Exception e) {
							e.printStackTrace();
							System.out.println("Fallo al enviar el email :S");
						}
						
										
						result = new ModelAndView("redirect:listOutbox.do");
					}
					else{
						result = createModelAndView(message, null, true);
					}
				} else {
					messageService.save(message);
					message.setIsRead(false);
					message.setIsRecipientCopy(true);
					messageService.save(message);
					
					EmailService emailService = new EmailService();
					try{
						emailService.sendEmail(message.getRecipientActor().getEmail(), message.getSubject(), message.getBody());
					}catch (Exception e) {
						e.printStackTrace();
						System.out.println("Fallo al enviar el email :S");
					}
					
									
					result = new ModelAndView("redirect:listOutbox.do");
				}
			

			} catch (Throwable oops) {
				result = createModelAndView(message, "message.commit.error", false);
			}
		}

		return result;
	}
	

	// Ancillary methods ------------------------------------------------------

	protected ModelAndView createModelAndView(Message messageToEdit) {
		ModelAndView result;

		result = createModelAndView(messageToEdit, null, false);

		return result;
	}

	protected ModelAndView createModelAndView(Message messageToEdit, String message, Boolean error) {
		ModelAndView result;

		result = new ModelAndView("message/create");
		result.addObject("messageToEdit", messageToEdit);
		result.addObject("message", message);
		result.addObject("sendError", error);

		return result;
	}


}
