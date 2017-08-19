package controllers.tourfriend;

import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import controllers.AbstractController;
import domain.Category;
import domain.Poi;
import domain.Route;
import services.CategoryService;
import services.PoiService;
import services.RouteService;

@Controller
@RequestMapping("/category")
public class CategoryController extends AbstractController {
	
	@Autowired
	private RouteService routeService;
	
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private PoiService poiService;
	
	
	
	@RequestMapping(value = "/step-3", method = RequestMethod.GET)
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView result;

		HttpSession httpSession = request.getSession();
		Route route = (Route) httpSession.getAttribute("routeToSave");

		if(route!=null){
		
			Collection<Category> categorys = categoryService.findAll();
			result = new ModelAndView("route/list");
	
			result.addObject("categorys", categorys);
			result.addObject("requestURICategory", "route/step-3.do");
			
			
			result.addObject("showSuccess",true);
			result.addObject("success_msg","category.list.success");
			
			Collection<Route> routes = routeService.findRouteCreateByTourFriend();
			result.addObject("routes", routes);
			result.addObject("requestURI", "route/list.do");
			result.addObject("categoryListModal", true);
		}else{
			result = new ModelAndView("redirect:/welcome/index.do");
		}


		return result;
	}
	
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public ModelAndView search(@RequestParam String keyword) {
		ModelAndView result;

		
		Collection<Category> categorys = categoryService.searchCategory(keyword);
		result = new ModelAndView("route/list");

		result.addObject("categorys", categorys);

		result.addObject("requestURICategory", "category/search.do");
		
		
		result.addObject("showSuccess",true);
		result.addObject("success_msg","category.search.result");
		
		Collection<Route> routes = routeService.findRouteCreateByTourFriend();
		result.addObject("routes", routes);
		result.addObject("requestURI", "route/list.do");
		result.addObject("categoryListModal", true);


		return result;
	}

	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public ModelAndView create() {

		Category category = categoryService.create();
		ModelAndView m = createModelAndView(category, "create");
		return m;
	}
	
	
	@RequestMapping(value="/edit", method=RequestMethod.GET)
	public ModelAndView edit(@RequestParam int categoryId){
		ModelAndView result;
		
		Category category = categoryService.findOne(categoryId);
		result=createModelAndView(category, "edit");
		
		return result;
	}
	
	

	@RequestMapping(value = "/step-3", method = RequestMethod.POST, params = "save")
	public ModelAndView save(HttpServletRequest request) {

		ModelAndView m = null;
		//Recogemos los checkbox que estan marcados, el value del checkbox es el id de la category
		String[] items = request.getParameterValues("chk_group");
		HttpSession httpSession = request.getSession();
		Route route = (Route) httpSession.getAttribute("routeToSave");

		if(route!=null){
			try{
				
				if(items==null){
					
					//Gestion del error, no ha seleccionado ninguno
					m = new ModelAndView("category/step-3");
					m.addObject("showWarning",true);
					m.addObject("warning_msg","category.selected.option");
					m = list(request);
					m.addObject("showWarning",true);
					m.addObject("warning_msg","category.selected.option");
				
				}else{
					
					for(String s: items){
						Category category = categoryService.findOne(new Integer(s));
						route.addCategory(category);
					}
					
					routeService.save(route);
					httpSession.setAttribute("routeToSave", null);
					m = new ModelAndView("redirect:/route/list.do");
					m.addObject("showSuccess", true);
					
		
				}
			}catch(Throwable e){
				m = new ModelAndView("category/step-3");
			}
		}else{
			m = new ModelAndView("redirect:/welcome/index.do");

		}
		return m;

	}
	
	
	@RequestMapping(value = "/edit", method = RequestMethod.POST, params = "delete")
	public ModelAndView delete(@RequestParam(required = false) String id) {

		ModelAndView m=null;
		Poi poi = poiService.findOne(new Integer(id));


		try {
			routeService.delete(routeService.findOne(poi.getId()));
			m = new ModelAndView("redirect:list.do");
		} catch (Throwable e) {

			//m = createModelAndView(poi, "edit");
		}

		return m;
	}


	protected ModelAndView createModelAndView(Category category, String action) {

		ModelAndView result = null;
		if (action.equals("edit")) {
			result = new ModelAndView("category/edit");
			result.addObject("category", category);
			result.addObject("edit",true);

		} else if (action.equals("create")) {
			result = new ModelAndView("category/create");
			result.addObject("category", category);
			result.addObject("create",true);

		}

		return result;
	}
	
	
	

}