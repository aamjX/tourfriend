package utilities.paypal;

public class Transaction
{
    private Amount amount;

    private String description;

    public Amount getAmount ()
    {
        return amount;
    }

    public void setAmount (Amount amount)
    {
        this.amount = amount;
    }

    public String getDescription ()
    {
        return description;
    }

    public void setDescription (String description)
    {
        this.description = description;
    }

    @Override
    public String toString()
    {
        return "ClassPojo [amount = "+amount+", description = "+description+"]";
    }
}