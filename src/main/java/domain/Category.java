package domain;

import java.util.Collection;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.persistence.ManyToMany;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.SafeHtml;

@Entity
@Access(AccessType.PROPERTY)
public class Category extends DomainEntity {

	// Attributes ---------------------------------------------------------

	private String name;

	@NotBlank
	@SafeHtml
	@NotNull
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	// Relationships ----------------------------------------------------------


	
	private Collection<Route> routes;

	@NotNull
	@ManyToMany(mappedBy = "categories")
	public Collection<Route> getRoutes() {
		return routes;
	}

	public void addRoute(Route route) {
		this.routes.add(route);
	}

	public void removeRoute(Route route) {
		this.routes.remove(route);
	}

	public void setRoutes(Collection<Route> routes) {
		this.routes = routes;
	}

}
