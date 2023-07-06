menu = {
    1: {"name": 'espresso',
        "price": 1.99},
    2: {"name": 'coffee', 
        "price": 2.50},
    3: {"name": 'cake', 
        "price": 2.79},
    4: {"name": 'soup', 
        "price": 4.50},
    5: {"name": 'sandwich',
        "price": 4.99}
}

def calculate_subtotal(order):
    """ Calculates the subtotal of an order

    [IMPLEMENT ME] 
        1. Add up the prices of all the items in the order and return the sum

    Args:
        order: list of dicts that contain an item name and price

    Returns:
        float = The sum of the prices of the items in the order
    """
    print('Calculating bill subtotal...')
    ### WRITE SOLUTION HERE
    ## Subtotal for the order is: ([{'name': 'espresso', 'price': 1.99}, {'name': 'coffee', 'price': 2.5}, {'name': 'cake', 'price': 2.79}], <class 'list'>)
    ## Take order is doing the heavy lifting and taking the provided menu item and simply indexing the menu dictionary with th integer to populate a list of the menu item with the price and name
    ## The argument is above (it's not the menu but the argument passed to the function we need to deal with)
    return sum([x['price'] for x in order])
    raise NotImplementedError()

def calculate_tax(subtotal):
    """ Calculates the tax of an order

    [IMPLEMENT ME] 
        1. Multiply the subtotal by 15% and return the product rounded to two decimals.

    Args:
        subtotal: the price to get the tax of

    Returns:
        float - The tax required of a given subtotal, which is 15% rounded to two decimals.
    """
    print('Calculating tax from subtotal...')
    ### WRITE SOLUTION HERE
    return round((0.15 * subtotal), 2)

    raise NotImplementedError()

def summarize_order(order):
    """ Summarizes the order

    [IMPLEMENT ME]
        1. Calculate the total (subtotal + tax) and store it in a variable named total (rounded to two decimals)
        2. Store only the names of all the items in the order in a list called names
        3. Return names and total.

    Args:
        order: list of dicts that contain an item name and price

    Returns:
        tuple of names and total. The return statement should look like 
        
        return names, total

    """
    total_w_o_tax = calculate_subtotal(order) 
    tax = calculate_tax(total_w_o_tax)
    total = round(total_w_o_tax + tax, 2)
    names = [x['name'] for x in order]
    return names, total
    ### WRITE SOLUTION HERE

    raise NotImplementedError()

# This function is provided for you, and will print out the items in an order
def print_order(order):
    print('You have ordered ' + str(len(order)) + ' items')
    items = []
    items = [item["name"] for item in order]
    print(items)
    return order

# This function is provided for you, and will display the menu
def display_menu():
    print("------- Menu -------")
    for selection in menu:
        print(f"{selection}. {menu[selection]['name'] : <9} | {menu[selection]['price'] : >5}")
    print()

# This function is provided for you, and will create an order by prompting the user to select menu items
def take_order():
    display_menu()
    order = []
    count = 1
    for i in range(3):
        item = input('Select menu item number ' + str(count) + ' (from 1 to 5): ')
        count += 1
        order.append(menu[int(item)])
    return order

'''
Here are some sample function calls to help you test your implementations.
Feel free to change, uncomment, and add these as you wish.
'''
def main():
    order = take_order()
    print_order(order)

    subtotal = calculate_subtotal(order) # return here is the float of the subtotal of all selected items
    print("Subtotal for the order is: " + str(subtotal))

    tax = calculate_tax(subtotal) # passing the float value to get the  tax
    print("Tax for the order is: " + str(tax))
    items, subtotal = summarize_order(order)
    print(items, subtotal)

if __name__ == "__main__":
    main()


## Readout
# ------- Menu -------
# 1. espresso  |  1.99
# 2. coffee    |   2.5
# 3. cake      |  2.79
# 4. soup      |   4.5
# 5. sandwich  |  4.99

# Select menu item number 1 (from 1 to 5): 1
# Select menu item number 2 (from 1 to 5): 2
# Select menu item number 3 (from 1 to 5): 3
# You have ordered 3 items
# ['espresso', 'coffee', 'cake']
# Calculating bill subtotal...
# Subtotal for the order is: 7.28
# Calculating tax from subtotal...
# Tax for the order is: 1.09
# Calculating bill subtotal...
# Calculating tax from subtotal...
# ['espresso', 'coffee', 'cake'] 8.37