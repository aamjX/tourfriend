package services;

import java.util.Collection;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import domain.CommentTourFriend;
import domain.TourFriend;
import repositories.CommentTourFriendRepository;

@Service
@Transactional
public class CommentTourFriendService {

	// Managed repository -------------------------------------------

	@Autowired
	private CommentTourFriendRepository commentTourFriendRepository;

	// Supporting services ------------------------------------------

	@Autowired
	private TourFriendService tourFriendService;

	// Constructor --------------------------------------------------

	public CommentTourFriendService() {
		super();
	}

	// Simple CRUD methods ------------------------------------------

	public CommentTourFriend create(int commentedTourfriendId) {
		CommentTourFriend result;
		TourFriend tourFriendCreator;
		TourFriend tourfriend;
		Date creationMoment;
		
		tourFriendCreator = tourFriendService.findByPrincipal();
		tourfriend = tourFriendService.findOne(commentedTourfriendId);
		creationMoment = new Date(System.currentTimeMillis() - 1);
		
		result = new CommentTourFriend();
		
		result.setTourFriendCreator(tourFriendCreator);
		result.setTourFriend(tourfriend);
		result.setCreationMoment(creationMoment);		
		
		return result;
	}

	public void save(CommentTourFriend commentTourFriend) {
		Assert.isTrue(commentTourFriend.getTourFriend() != commentTourFriend.getTourFriendCreator());
		
		commentTourFriendRepository.save(commentTourFriend);
		
		Collection<CommentTourFriend> comments = commentsBetweenTourfriend(commentTourFriend);
		
		if(comments.size() == 1){
			TourFriend tourFriendCreator = commentTourFriend.getTourFriendCreator();
			tourFriendCreator.setAvailablePoints(tourFriendCreator.getAvailablePoints()+1);
			tourFriendService.save(tourFriendCreator);
		}
		
		
	}
	
	public CommentTourFriend findOne(int commentTourFriendId) {
		CommentTourFriend result;
		
		result = commentTourFriendRepository.findOne(commentTourFriendId);
		Assert.notNull(result);
		
		return result;
	}
	
	public Collection<CommentTourFriend> findByTourFriend(int tourfriendId) {
		Collection<CommentTourFriend> result;
		
		result = commentTourFriendRepository.findByTourFriend(tourfriendId);
		
		return result;
	}
	
	
	public void delete(CommentTourFriend commentTourFriend) {
		commentTourFriendRepository.delete(commentTourFriend);
	}

	// Other business methods ---------------------------------------
	
	public Collection<CommentTourFriend> commentsBetweenTourfriend(CommentTourFriend comment){
		Collection<CommentTourFriend> comments;
		
		comments = commentTourFriendRepository.commentsBetweenTourfriends(comment.getTourFriend().getId(), comment.getTourFriendCreator().getId());
		
		return comments;
	}
	
}
