package utilities.paypal;

import java.util.List;

public class Payment
{
    private String id;

    private List<Transaction> transactions;

    private String update_time;

    private Payer payer;

    private String state;

    private String create_time;

    private RedirectUrls redirectUrls;

    private String intent;

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

   

    public List<Transaction> getTransactions() {
		return transactions;
	}

	public void setTransactions(List<Transaction> transactions) {
		this.transactions = transactions;
	}

	public String getUpdate_time ()
    {
        return update_time;
    }

    public void setUpdate_time (String update_time)
    {
        this.update_time = update_time;
    }

    public Payer getPayer ()
    {
        return payer;
    }

    public void setPayer (Payer payer)
    {
        this.payer = payer;
    }

    public String getState ()
    {
        return state;
    }

    public void setState (String state)
    {
        this.state = state;
    }

    public String getCreate_time ()
    {
        return create_time;
    }

    public void setCreate_time (String create_time)
    {
        this.create_time = create_time;
    }

    

    public RedirectUrls getRedirectUrls() {
		return redirectUrls;
	}

	public void setRedirectUrls(RedirectUrls redirectUrls) {
		this.redirectUrls = redirectUrls;
	}

	public String getIntent ()
    {
        return intent;
    }

    public void setIntent (String intent)
    {
        this.intent = intent;
    }

   
}