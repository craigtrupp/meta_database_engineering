# Define class MyFirstClass
class MyFirstClass:
    # Define string variable called index
    index = 'Author-Book'
    # Define function hand_list()
    def hand_list(self, philosopher, book):
        print(self.index)
        print(f'{philosopher} wrote the book: {book}')
        # variable + “ wrote the book: ” + variable
        
whodunnit = MyFirstClass()
whodunnit.hand_list('Sun Tzu', 'The Art of War')
# Call function handlist()



# Sample Solution code
class MyFirstClass():
    print("Who wrote this?")
    index = "Author-Book"

    def hand_list(self, philosopher, book):
        print(MyFirstClass.index)
        print(philosopher + " wrote the book: " + book)

whodunnit = MyFirstClass()
whodunnit.hand_list("Sun Tzu", "The Art of War")


## Inheritance & Super
# Parent
class Employees:
    def __init__(self, name, last) -> None:
        self.name = name
        self.last = last

class Supervisors(Employees):
    def __init__(self, name, last, password) -> None:
        super().__init__(name, last)
        self.password = password
    
class Chefs(Employees):
    def leave_reqeust(self, days):
        return "May I take leave for " + str(days) + " days?"

adrian = Employees('Adrian', 'Brody')
richard = Supervisors('Richard', 'Cardona', 'rccola_89')
emily = Chefs('Juno', 'McGuff')
harold = Chefs('Harold', 'Castle')

# Let's see what we can get with emily/richard in terms of attributes
print(f'Our chief supervisor : {richard.last}, {richard.name} is evaluating whether to approve {emily.last}, {emily.name} request. Her original email : {emily.leave_reqeust(4)}')
## Our chief supervisor : Cardona, Richard is evaluating whether to approve McGuff, Juno request. Her original email : May I take leave for 4 days?

## As we can see the Chefs instance of emily still has access to the parent's init method
# We included a supervisor call to the parent init "super().__init__" as we are also passing a password instance variable to assign when also creating the standard __init__ calls of name/value