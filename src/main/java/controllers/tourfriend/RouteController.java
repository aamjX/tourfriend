package controllers.tourfriend;

import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import controllers.AbstractController;
import domain.Event;
import domain.Poi;
import domain.Route;
import domain.TourFriend;
import forms.RouteEditForm;
import services.EventService;
import services.RouteService;
import services.TourFriendService;

@Controller
@RequestMapping("/route")
public class RouteController extends AbstractController {
	
	@Autowired
	private RouteService routeService;
	
	@Autowired
	private TourFriendService tourFriendService;
	

	@RequestMapping(value = "/detailsOfRoute.do", method = RequestMethod.GET)
	public ModelAndView display(@RequestParam String routeId) {
		ModelAndView result;

		Route route = routeService.findOne(new Integer(routeId));
		RouteEditForm routeEditForm = routeService.fragment(route);
		// Listado de Comentarios
		
		if(route.getIsDisabled()){
			result = new ModelAndView("redirect:list.do");
		}else{
			result = new ModelAndView("route/display");
			result.addObject("route", route);
			result.addObject("routeEditForm", routeEditForm);
			result.addObject("requestURI", "route/detailsOfRoute.do");

		}

		
		return result;
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView list() {
		ModelAndView result;

		Collection<Route> routes = routeService.findRouteCreateByTourFriend();
		result = new ModelAndView("route/list");

		result.addObject("routes", routes);
		result.addObject("requestURI", "route/list.do");
		
		
		/*result.addObject("success",true);
		result.addObject("success_msg","route.list.success");*/


		return result;
	}

	@RequestMapping(value = "/step-1", method = RequestMethod.GET)
	public ModelAndView create() {

		Route route = routeService.create();
		ModelAndView m = createModelAndView(route, "step-1");


		return m;
	}
	
	
	@RequestMapping(value="/edit", method=RequestMethod.GET)
	public ModelAndView edit(@RequestParam String id){
		ModelAndView result;
		
		Route route = routeService.findOne(new Integer(id));
		result=createModelAndView(route, "edit");
		
		return result;
	}

	@RequestMapping(value="/editRoute", method=RequestMethod.GET)
	public ModelAndView editRoute(@RequestParam String id){
		ModelAndView result;

		RouteEditForm routeEditForm = routeService.fragment(routeService.findOne(new Integer(id)));
		result=createModelAndView2(routeEditForm);

		return result;
	}
	
	

	@RequestMapping(value = "/step-1", method = RequestMethod.POST, params = "save")
	public ModelAndView save(@Valid Route route, BindingResult binding, HttpServletRequest request) {
		

		ModelAndView m = null;
		boolean routeMatch = false;
		
		if(checkRoute(route.getCity()))
			routeMatch = true;


		//Si hay errores y no existe la ciudad
		if (binding.hasErrors() || !routeMatch) {
			if(!routeMatch){
				m = createModelAndView(route, "edit");
				m.addObject("showDanger", true);
				m.addObject("danger_msg", "route.checkRoute");
			}else{
				m = createModelAndView(route, "edit");
			}

		} else {
			try {
				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("routeToSave", route);
				m = new ModelAndView("redirect:/poi/step-2.do");

			} catch (Throwable e) {
				m = createModelAndView(route, "edit");
			}
		}

		return m;

	}

	@RequestMapping(value = "/editRoute", method = RequestMethod.POST, params = "save")
	public ModelAndView saveEdit(@Valid RouteEditForm routeEditForm, BindingResult binding) {
		ModelAndView m;
		Route route;
		if (binding.hasErrors() ) {

				m = createModelAndView2(routeEditForm);
				m.addObject("showDanger", true);
				m.addObject("danger_msg", "route.checkRoute");
		} else {
			try {
				route = routeService.reconstruct(routeEditForm);
				routeService.save(route);
				m = new ModelAndView("redirect:/route/detailsOfRoute.do?routeId="+route.getId());

			} catch (Throwable e) {
				m = createModelAndView2(routeEditForm);
			}
		}

		return m;

	}
	


	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public ModelAndView delete(@RequestParam(required = false) String id) {

		ModelAndView m;
		Route route = routeService.findOne(new Integer(id));


		try {
			routeService.delete(routeService.findOne(route.getId()));
			m = new ModelAndView("redirect:list.do");
		} catch (Throwable e) {

			m = createModelAndView(route, "edit");
		}

		return m;
	}
	
	
	@RequestMapping(value = "/disable", method = RequestMethod.GET)
	public ModelAndView disable(@RequestParam(required = false) String routeId) {

		ModelAndView m;
		
		try{
		
			TourFriend tourFriend = tourFriendService.findByPrincipal();
			Route route = routeService.findRouteByTourFriendCreator(tourFriend.getId(), new Integer(routeId));
			Collection<Event> eventsAvaliables = route.getEvents();
			Collection<Event> eventAvaliablesFromRoute = new ArrayList<Event>();
			
			
			Date fecha = new Date();
			for(Event e: eventsAvaliables){
				if(e.getIsCancelled() || fecha.before(e.getDate())){
					eventAvaliablesFromRoute.add(e);
				}
			}
			
			
			if(route != null){
				if(eventAvaliablesFromRoute.size()==0){
					route.setIsDisabled(true);
					routeService.save(route);
					m = new ModelAndView("redirect:list.do");
					m.addObject("showDisableSuccess",true);
					
				}else{
					// la ruta no puede ser desactivada porque tiene eventos activos ya tiene eventos asignados
					m = new ModelAndView("redirect:list.do");
					m.addObject("showDisableFailureEvents",true);
				}
				
			}else{
				//ruta no valida, no eres dueño de la ruta
				m = new ModelAndView("redirect:list.do");
				m.addObject("showDisableFailureRouteOwner",true);
			}
		}catch(Throwable e){
			m = new ModelAndView("redirect:list.do");
		}


		return m;
	}


	protected ModelAndView createModelAndView(Route route, String action) {

		ModelAndView result = null;
		if (action.equals("edit")) {
			result = new ModelAndView("route/list");
			Collection<Route> routes = routeService.findRouteCreateByTourFriend();
			result.addObject("routes", routes);
			result.addObject("routeModal", true);
			result.addObject("requestURI", "route/list.do");

		} else if (action.equals("step-1")) {
			result = new ModelAndView("route/list");
			result.addObject("route", route);
			result.addObject("create",true);
			Collection<Route> routes = routeService.findRouteCreateByTourFriend();
			result.addObject("routes", routes);
			result.addObject("routeModal", true);
			result.addObject("requestURI", "route/list.do");

		}else if (action.equals("detailsOfRoute")){
			result = new ModelAndView("route/display");
			result.addObject("route", route);
		}

		return result;
	}
	
	
	protected ModelAndView createModelAndViewPoi(Poi poi) {

		ModelAndView result = null;
		result = new ModelAndView("poi/list");
		result.addObject("poi", poi);
		return result;
	}
	
	
	private boolean checkRoute(String city) {
		boolean existe = false;
		try {
		    String url = "http://maps.googleapis.com/maps/api/geocode/xml?address=" + URLEncoder.encode(city, "UTF-8") + "&sensor=true";
		    
	    	Document doc = Jsoup.parse(new URL(url).openStream(), "UTF-8", "", Parser.xmlParser());
	    	Element ciudad = doc.select("formatted_address").first();
	    	
	    	if(ciudad != null){
	    		existe = true;
	    		System.out.println(ciudad);
	    	}

		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		return existe;
	}


	protected ModelAndView createModelAndView2(RouteEditForm routeEditForm) {
		ModelAndView result;

		Route route = routeService.findOne(routeEditForm.getId());
		result = new ModelAndView("route/display");
		result.addObject("route", route);
		result.addObject("routeEditorm",routeEditForm);

		return result;
	}
	

}