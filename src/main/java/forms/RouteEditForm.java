package forms;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.SafeHtml;

import javax.validation.constraints.NotNull;

/**
 * Created by santy on 17/04/2017.
 */
public class RouteEditForm {
    // Attributes ---------------------------------------------------------

    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String city;
    private String description;
    private String name;


    // Constructor ---------------------------------------------------------
    public RouteEditForm(){
        super();
    }

    @NotBlank
    @SafeHtml
    @NotNull
    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }
    @NotBlank
    @SafeHtml
    @NotNull
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    @NotBlank
    @SafeHtml
    @NotNull
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
