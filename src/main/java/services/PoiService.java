package services;

import java.util.ArrayList;
import java.util.Collection;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import domain.Poi;
import domain.Route;
import repositories.PoiRepository;

@Service
@Transactional
public class PoiService {
	
	@Autowired
	private PoiRepository poiRepository;
	
	@Autowired
	private TourFriendService tourFriendService;
	
	
	public PoiService(){
		super();
	}
	
	public Poi create(){
		Poi poi = new Poi();
		poi.setTourFriendCreator(tourFriendService.findByPrincipal());
		poi.setPhotos(new ArrayList<String>());
		poi.setRoutes(new ArrayList<Route>());
		return poi;
	}
	
	public Poi findOne(int poiId){
		Assert.notNull(poiId);
		return poiRepository.findOne(poiId);
	}
	
	public Collection<Poi> findAll(){
		return poiRepository.findAll();
	}
	
	public Poi save(Poi poi){
		return poiRepository.saveAndFlush(poi);
	}
	
	public void delete(Poi poi){
		poiRepository.delete(poi.getId());
	}
	
	public Collection<Poi> searchPoi(String keyword){
		return poiRepository.searchPoi(keyword,tourFriendService.findByPrincipal().getId());
	}
	
	public Collection<Poi> findMyPois(){
		return poiRepository.findMyPois(tourFriendService.findByPrincipal().getId());
	}
	


}
