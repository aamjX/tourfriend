package services;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import domain.Category;
import domain.Event;
import domain.Poi;
import domain.Route;
import domain.TourFriend;
import forms.RouteEditForm;
import repositories.RouteRepository;

@Service
@Transactional
public class RouteService {

	@Autowired
	private RouteRepository routeRepository;

	@Autowired
	private TourFriendService tourFriendService;

	public RouteService() {
		super();
	}

	public Route create() {
		Assert.notNull(tourFriendService.findByPrincipal());
		Route route = new Route();
		route.setName("");
		route.setDescription("");
		route.setIsDisabled(false);
		route.setCity("");
		route.setEvents(new ArrayList<Event>());
		route.setPois(new ArrayList<Poi>());
		route.setCategories(new ArrayList<Category>());
		route.setTourFriendCreator(tourFriendService.findByPrincipal());
		route.setFavouriteTourFriends(new ArrayList<TourFriend>());
		return route;
	}

	public Route findOne(int routeId) {
		Assert.notNull(routeId);
		return routeRepository.findOne(routeId);
	}

	public Collection<Route> findAll() {
		return routeRepository.findAll();
	}

	public Route save(Route route) {
		// Assert.notNull(tourFriendService.findByPrincipal());
		// Assert.isTrue(route.getTourFriendCreator() ==
		// tourFriendService.findByPrincipal());
		return routeRepository.saveAndFlush(route);
	}

	public void delete(Route route) {
		Assert.notNull(tourFriendService.findByPrincipal());
		Assert.isTrue(route.getTourFriendCreator() == tourFriendService.findByPrincipal());
		routeRepository.delete(route.getId());
	}

	public Collection<Route> findRouteCreateByTourFriend() {
		TourFriend principal;

		principal = tourFriendService.findByPrincipal();
		Assert.notNull(principal);

		return routeRepository.findRouteCreateByTourFriend(principal.getId());
	}

	public Collection<Route> findMyRoutes() {
		TourFriend t = tourFriendService.findByPrincipal();
		return t.getMyRoutes();
	}

	public Route findRouteToAddPoiOrCategory() {
		// Assert.notNull(tourFriendService.findByPrincipal());
		TourFriend tourFriend = tourFriendService.findByPrincipal();
		Collection<Route> routes = routeRepository.findRouteToAddPoiOrCategory(tourFriend.getId());
		// Comprobamos que estamos añadiendo un poi a una category a una ruta
		// del mismo tourfriend que esta logeado
		// Assert.isTrue(tourFriend.getId()==route.getTourFriendCreator().getId());
		Route route = null;
		for (Route r : routes) {
			route = r;
			break;
		}

		return route;
	}

	public RouteEditForm fragment(Route route) {
		RouteEditForm result;

		result = new RouteEditForm();
		result.setId(route.getId());
		result.setCity(route.getCity());
		result.setName(route.getName());
		result.setDescription(route.getDescription());

		return result;
	}

	public Route reconstruct(RouteEditForm routeEditForm) {
		Route result;

		result = findOne(routeEditForm.getId());
		result.setDescription(routeEditForm.getDescription());
		result.setName(routeEditForm.getName());
		result.setCity(routeEditForm.getCity());

		return result;
	}

	public Collection<Route> routesWithMoreEvents() {
		Collection<Route> routes;
		List<Route> routesWithMoreEvents;

		routes = routeRepository.routesWithMoreEvents();
		routesWithMoreEvents = new ArrayList<>(routes);
		if (routes.size() >= 10) {
			routesWithMoreEvents = routesWithMoreEvents.subList(0, 10);
		}

		return routesWithMoreEvents;
	}

	public Collection<Route> routesWithLessEvents() {
		Collection<Route> routes;
		List<Route> routesWithLessEvents;

		routes = routeRepository.routesWithLessEvents();
		routesWithLessEvents = new ArrayList<>(routes);
		if (routes.size() >= 10) {
			routesWithLessEvents = routesWithLessEvents.subList(0, 10);
		}

		return routesWithLessEvents;
	}

	public List<List<String>> routesHighestRated() {
		Collection<Object[]> routes;
		List<List<String>> lista1 = new ArrayList<>();

		routes = routeRepository.routesHighestRated();
		List<Object[]> list = new ArrayList<>(routes);
		if (list.size() >= 10) {
			routes = list.subList(0, 10);
		}
		for (Object[] o : list) {
			for (int i = 0; i < o.length;) {
				List<String> liss = new ArrayList<>();
				liss.add(o[i].toString());
				liss.add(o[i + 1].toString());
				lista1.add(liss);
				i = i + 2;
			}
		}

		return lista1;
	}

	public List<List<String>> routesLowestRated() {
		Collection<Object[]> routes;
		List<List<String>> lista1 = new ArrayList<>();

		routes = routeRepository.routesLowestRated();
		List<Object[]> list = new ArrayList<>(routes);
		if (list.size() >= 10) {
			routes = list.subList(0, 10);
		}
		for (Object[] o : list) {
			for (int i = 0; i < o.length;) {
				List<String> liss = new ArrayList<>();
				liss.add(o[i].toString());
				liss.add(o[i + 1].toString());
				lista1.add(liss);
				i = i + 2;
			}
		}

		return lista1;
	}

	public List<List<String>> routeThisMonth() {
		List<Route> routeThisMonth;
		List<List<String>> result = new ArrayList<>();

		Date actual = new Date();
		int monthActual = actual.getMonth() + 1;

		routeThisMonth = routeRepository.routeThisMonth();
		if (routeThisMonth.size() >= 10) {
			;
			routeThisMonth = routeThisMonth.subList(0, 10);
		}
		for (Route r : routeThisMonth) {
			String rname = r.getName();
			int cont = 0;
			for (Event e : r.getEvents()) {
				if (e.getDate().getMonth() + 1 == monthActual) {
					cont++;
				}
			}
			List<String> liss = new ArrayList<>();
			liss.add(rname);
			liss.add(String.valueOf(cont));
			result.add(liss);
		}

		return result;
	}

	public List<Route> routesHighRatedWithoutAvg(){
		List<Route> result;

		result = (List<Route>) routeRepository.routesHighestRatedWithoutAvg();
		if(result.size()>2) {
			result = result.subList(0, 2);
		}
		return result;
	}

	public List<Route> routesHighRatedByCity(String city){
		List<Route> result;
		city = "%" + city + "%";

		result = (List<Route>) routeRepository.routesHighestRatedWithoutAvgByCity(city);

		if(result.size()>2) {
			result = result.subList(0, 2);
		}

		return result;
	}
	
	public Route findRouteByTourFriendCreator(int tourFriendId, int routeId){
		return routeRepository.findRouteByTourFriendCreator(tourFriendId,routeId);
	}
	

	public Collection<Route> findRouteAvailableByTourFriend(int id) {
		
		return routeRepository.findRouteAvailableByTourFriend(id);
	}
}
