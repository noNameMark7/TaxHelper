import Foundation

enum TextValues: String {
    case designationLabel = "Designations"
    case designationText = """
    Net price - the price of the product before the sales tax is applied.\n
    Sales tax - the sales tax that the government charges on the retail price of a product.\n
    Gross price - the price of the product after the sales tax is applied.
    """
    case salesTaxDefinitionLabel = "Sales tax definition"
    case salesTaxDefinitionText = """
    Sales tax is a consumption-based tax that is indirectly charged on the consumer at the point of final purchase of a good or service.The indirect feature of the tax means that the consumer bears the burden of the tax, however it's collected and transferred to authorities by the seller. The most popular type of sales tax is the retail sales tax which is present on state-level in the United States. Under such a taxation framework, consumers pay the price of the item plus the amount of the sales tax which is collected by the store at the cash register and printed on the receipt. In the next section, you can get more insight into its concept as we illustrate the difference between the sales tax and value-added tax.
    """
    
    case howToCalculateItLabel = "How to calculate it?"
    case howToCalculateItTextView = """
    1. Find out the sales tax rate, an example will be the state of Oklahoma, in which 4.5%.\n
    2. Find out the net price of a product. Let's use $1299.\n
    3. Multiply your net price by 4.5%, so by 0.045, to find out the tax amount: 1299 * 0.045 = 58.45.\n
    4. Add the tax amount to the net price to find out the gross price: 1299 + 58.45 = 1357.45.
    """
    case whatStatesDonotHaveItLabel = "What states don’t have it?"
    case whatStatesDonotHaveItTextView = """
    Alaska, Delaware, Montana, New Hampshire and Oregon all do not have a statewide sales tax, although Alaska and Montana both allow local sales taxes. Delaware also imposes a gross receipts tax on businesses. Some other states have not taxes on food and other items.
    """
    case isItRegressiveLabel = "Is it regressive?" 
    case isItRegressiveTextView = """
    Yes, sales taxes are regressive. They are charged as a percentage of the sale price, and therefore are the same regardless of your income. This means that a poorer person pays a larger percent of their income.
    """
    case isMyBusinessRequiredToCollectIt = "Is my business required to collect it?"
    case isMyBusinessRequiredToCollectItTextView = """
    If you’re selling tangible goods that are not exempt from sales tax (such as groceries), you more than likely have to collect sales tax. If you’re selling a service, such as house cleaning or legal work, that will depend on your state’s specific laws.\n
    If you’re selling goods online, you are typically required to collect sales tax from wherever your business is located.
    """
    case whatHappensIfIDonotCollectIt = "What happens if I don't collect it?"
    case whatHappensIfIDonotCollectItTextView = """
        If you were supposed to collect sales tax and didn’t, you could be looking at high financial penalties and interest. Those rates will depend on your state. You could also potentially face criminal charges or lose your vendor license.
        """
}
