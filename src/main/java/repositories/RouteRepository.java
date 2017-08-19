package repositories;

import java.util.Collection;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.Route;

@Repository
public interface RouteRepository extends JpaRepository<Route, Integer> {
	
	@Query("select r from Route r where r.tourFriendCreator.id = ?1 ")
	Collection<Route> findRouteCreateByTourFriend(int tourFriendId);
	
	@Query("select r from Route r where r.tourFriendCreator.id = ?1 order by r.id desc")
	Collection<Route> findRouteToAddPoiOrCategory(int tourFriendId);
	
	//Rutas con mas eventos
	@Query("select r from Route r order by r.events.size DESC")
	Collection<Route> routesWithMoreEvents();
	
	//Rutas con menos eventos
	@Query("select r from Route r order by r.events.size ASC")
	Collection<Route> routesWithLessEvents();
	
	//Rutas con mejor puntuacion
	//@Query("select e.route.name,sum(c.score)/e.commentEvents.size*1.0 from Route r join r.events e join e.commentEvents c group by e order by sum(c.score)/e.commentEvents.size*1.0 DESC")
	@Query("select e.route.name,avg(c.score) from Route r join r.events e join e.commentEvents c group by e order by avg(c.score) DESC")
	Collection<Object[]> routesHighestRated();
		
	//Rutas con peor puntuacion
	//@Query("select e.route.name,sum(c.score)/e.commentEvents.size*1.0 from Route r join r.events e join e.commentEvents c group by e order by sum(c.score)/e.commentEvents.size*1.0 ASC")
	@Query("select e.route.name,avg(c.score) from Route r join r.events e join e.commentEvents c group by e order by avg(c.score) ASC")
	Collection<Object[]> routesLowestRated();
	
	//Rutas con evento este mes
	@Query("select r from Route r join r.events e where MONTH(e.date) = MONTH(CURRENT_DATE)")
	List<Route> routeThisMonth();

	//Rutas con mejor puntuacion sin media
	@Query("select e.route from Event e left join e.commentEvents c group by e.route order by avg(coalesce(c.score,0)) DESC")
	Collection<Route> routesHighestRatedWithoutAvg();

	//Rutas con mejor puntuacion sin media por ciudad
	@Query("select e.route from Event e left join e.commentEvents c where e.route.city LIKE ?1 group by e.route order by avg(coalesce(c.score,0)) DESC")
	Collection<Route> routesHighestRatedWithoutAvgByCity(String city);
	
	@Query("select r from Route r where r.tourFriendCreator.id=?1 and r.id=?2")
	Route findRouteByTourFriendCreator(int tourFriendId,int routeId);
	
	//Rutas disponibles de un tourfriend
		@Query("select r from Route r where r.tourFriendCreator.id = ?1 and r.isDisabled = false ")
		Collection<Route> findRouteAvailableByTourFriend(int tourFriendId);
	
}
