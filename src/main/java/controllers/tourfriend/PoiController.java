package controllers.tourfriend;

import java.util.Base64;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import controllers.AbstractController;
import domain.Poi;
import domain.Route;
import services.PoiService;
import services.RouteService;

@Controller
@RequestMapping("/poi")
public class PoiController extends AbstractController {
	
	@Autowired
	private RouteService routeService;
	
	@Autowired
	private PoiService poiService;
	
	
	
	@RequestMapping(value = "/step-2", method = RequestMethod.GET)
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView result;
		
		HttpSession httpSession = request.getSession();
		Route route = (Route) httpSession.getAttribute("routeToSave");

		if(route!=null){

			Collection<Route> routes = routeService.findRouteCreateByTourFriend();
			result = new ModelAndView("route/list");
	
			result.addObject("routes", routes);
			result.addObject("requestURI", "route/list.do");
			
			Collection<Poi> pois = poiService.findMyPois();
	
			result.addObject("pois", pois);
			result.addObject("requestURI", "poi/step-2.do");
					
			result.addObject("showSuccess",true);
			result.addObject("success_msg","poi.list.success");
			result.addObject("poiListModal", true);
		}else{
			result = new ModelAndView("redirect:/welcome/index.do");

		}

		return result;
	}
	
	
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public ModelAndView  search(@RequestParam String keyword) {
		ModelAndView result;
		
		Collection<Route> routes = routeService.findRouteCreateByTourFriend();
		result = new ModelAndView("route/list");

		result.addObject("routes", routes);
		result.addObject("requestURI", "route/list.do");

		Collection<Poi> pois = poiService.searchPoi(keyword);

		result.addObject("pois", pois);

		result.addObject("requestURIPois", "poi/search.do");
		result.addObject("poiListModal", true);

		
		
		result.addObject("showSuccess",true);
		result.addObject("success_msg","poi.search.result");


		return result;
	}

	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public ModelAndView create(HttpServletRequest request) {

		HttpSession httpSession = request.getSession();
		Route route = (Route) httpSession.getAttribute("routeToSave");

		if(route!=null){
			Poi poi = poiService.create();
			return createModelAndView(poi, "create");
		}else{
			return new ModelAndView("redirect:/welcome/index.do");

		}
		
	}
	
	
	@RequestMapping(value="/edit", method=RequestMethod.GET)
	public ModelAndView edit(@RequestParam int id){
		ModelAndView result;
		
		
		Poi poi = poiService.findOne(id);
		result=createModelAndView(poi, "edit");
		
		return result;
	}
	
	

	@RequestMapping(value = "/step-2", method = RequestMethod.POST, params = "save")
	public ModelAndView save(HttpServletRequest request) {

		ModelAndView m = null;
		String[] items = request.getParameterValues("chk_group");
		HttpSession httpSession = request.getSession();
		Route route = (Route) httpSession.getAttribute("routeToSave");

		if(route!=null){
		
			try{
				//Accedemos a la session para obtener el objeto ruta que creamos en el paso 1
				// y le anadimos los pois seleccionados
				//Route route = (Route) httpSession.getAttribute("routeToSave");
				//Route route = routeService.findRouteToAddPoiOrCategory();
		
				if(items==null){
					m = new ModelAndView("poi/step-2");
					m.addObject("showWarning",true);
					m.addObject("warning_msg","poi.selected.option");
					m  =list(request);
					m.addObject("showWarning",true);
					m.addObject("warning_msg","poi.selected.option");
					//m.addObject("poi", poiService.create());
				}else{
					
					//Collection<Poi> poisToSave = new Collection<Poi>();
					for(String s: items){
						Poi poi = poiService.findOne(new Integer(s));
						route.addPoi(poi);
					}
					
					httpSession.setAttribute("routeToSave", route);
					m = new ModelAndView("redirect:/category/step-3.do");
		
				}
			}catch(Throwable e){
				m = new ModelAndView("poi/step-2");
			}
		}else{
			m = new ModelAndView("redirect:/welcome/index.do");

		}
		
		return m;

	}
	
	
	
	@RequestMapping(value = "/step-2-newPoi", method = RequestMethod.POST, params = "save")
	public ModelAndView save(@Valid Poi poi,BindingResult binding,HttpServletRequest request) {

		ModelAndView m=null;
		
		HttpSession httpSession = request.getSession();
		Route route = (Route) httpSession.getAttribute("routeToSave");

		if(route!=null){
		
			if (binding.hasErrors()) {
				m = createModelAndView(poi,"edit");
			} else {
				try {
					httpSession.setAttribute("poiToSave", poi);
					m = new ModelAndView("redirect:/poi/step-2-addPhoto.do");
				} catch (Throwable e) {
	
					m = createModelAndView(poi, "poi.commit.error");
				}
			}
		}else{
			m = new ModelAndView("redirect:/welcome/index.do");
		}

		return m;
	}
	
	@RequestMapping(value = "/step-2-addPhoto")
	public ModelAndView showFormPhoto(HttpServletRequest request) {
		ModelAndView result;
		
		HttpSession httpSession = request.getSession();
		Route route = (Route) httpSession.getAttribute("routeToSave");

		if(route!=null){
			result = new ModelAndView("route/list");
			Collection<Route> routes = routeService.findRouteCreateByTourFriend();
			result.addObject("routes", routes);
			result.addObject("requestURI", "route/list.do");
			result.addObject("poiAddPhotoModal", true);
		}else{
			result = new ModelAndView("redirect:/welcome/index.do");
		}

		return result;
	}
	
	
	@RequestMapping(value = "/step-2-addPhoto", method = RequestMethod.POST)
	public ModelAndView addPhoto(@RequestParam("file") Collection<MultipartFile> files,HttpServletRequest request) {

		ModelAndView m=null;
		HttpSession httpSession = request.getSession();
		Poi poi = (Poi) httpSession.getAttribute("poiToSave");
		Route route = (Route) httpSession.getAttribute("routeToSave");

		if(route!=null){
		
			for(MultipartFile file: files){
				if(!file.isEmpty()){
					try {
						byte[] barr = file.getBytes();
						String base64Encoded = Base64.getEncoder().encodeToString(barr);
	
						 poi.addPhoto(base64Encoded);
				
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
	   
			}
			
			try{
				
				//httpSession.setAttribute("poiToSave", null);
				m = new ModelAndView("redirect:/poi/step-2.do");
			}catch(Throwable e){
				m = new ModelAndView("redirect:/poi/step-2.do");
			}
		}else{
			m = new ModelAndView("redirect:/welcome/index.do");
		}
		


		return m;
	}
	
	@RequestMapping(value = "/cancel")
	public ModelAndView onClickCancelButton(HttpServletRequest request) {
		
		HttpSession httpSession = request.getSession();
		httpSession.setAttribute("routeToSave", null);
		return new ModelAndView("redirect:../route/list.do");

	}
	
	@RequestMapping(value = "/next")
	public ModelAndView next(HttpServletRequest request) {
		
		HttpSession httpSession = request.getSession();
		Poi poi = (Poi) httpSession.getAttribute("poiToSave");
		if(poi==null){
			return new ModelAndView("redirect:/route/list.do");

		}else{
			poiService.save(poi);
			httpSession.setAttribute("poiToSave", null);
			return new ModelAndView("redirect:/poi/step-2.do");
		}


	}
	

	
	//Todavia no usado
	@RequestMapping(value = "/edit", method = RequestMethod.POST, params = "delete")
	public ModelAndView delete(@RequestParam(required = false) String id) {

		ModelAndView m;
		Poi poi = poiService.findOne(new Integer(id));


		try {
			routeService.delete(routeService.findOne(poi.getId()));
			m = new ModelAndView("redirect:list.do");
		} catch (Throwable e) {

			m = createModelAndView(poi, "edit");
		}

		return m;
	}


	protected ModelAndView createModelAndView(Poi poi, String action) {

		ModelAndView result = null;
		if (action.equals("edit")) {
			result = new ModelAndView("poi/edit");
			result.addObject("poi", poi);
			result.addObject("edit",true);

		} else if (action.equals("create")) {
			result = new ModelAndView("route/list");
			result.addObject("poi", poi);
			result.addObject("create",true);
			Collection<Route> routes = routeService.findRouteCreateByTourFriend();
			result.addObject("routes", routes);
			result.addObject("requestURI", "route/list.do");
			result.addObject("poiAddNewPoiModal", true);

			

		}

		return result;
	}
	

	

}