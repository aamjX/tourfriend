package controllers.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import controllers.AbstractController;
import services.AdministratorService;

@Controller
@RequestMapping("/dashboard/admin")
public class DashboardAdministratorController extends AbstractController {

	// Services -------------------------------------------------------
	@Autowired
	private AdministratorService administratorService;

	// Constructors ---------------------------------------------------
	public DashboardAdministratorController() {
		super();
	}

	// Listing ---------------------------------------------------
	@RequestMapping(value = "/display", method = RequestMethod.GET)
	public ModelAndView list() {
		final ModelAndView result;

		result = this.administratorService.dashBoard();

		return result;
	}

}
