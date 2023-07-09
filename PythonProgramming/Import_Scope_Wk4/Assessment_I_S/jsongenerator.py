''' 
Import statements: 
    1. Import the built-in json python package
    2. From employee.py, import the details function and the employee_name, age, title variables
'''
### WRITE IMPORT STATEMENTS HERE
import json
from employee import details, employee_name, age, title


def create_dict(name, age, title):
    """ Creates a dictionary that stores an employee's information

    [IMPLEMENT ME]
        1. Return a dictionary that maps "first_name" to name, "age" to age, and "title" to title

    Args:
        name: Name of employee
        age: Age of employee
        title: Title of employee

    Returns:
        dict - A dictionary that maps "first_name", "age", and "title" to the
               name, age, and title arguments, respectively. Make sure that 
               the values are typecasted correctly (name - string, age - int, 
               title - string)
    """
    ### WRITE SOLUTION HERE
    employee_dictionary = {'first_name': name, 'age': int(age), 'title': title}
    # json_object = json.dumps(employee_dictionary) # encapsulates dictionary object
    # #print(type(employee_dictionary), type(json_object)) # <class 'dict'> <class 'str'>
    return employee_dictionary
    raise NotImplementedError()

def write_json_to_file(json_obj, output_file):
    """ Write json string to file

    [IMPLEMENT ME]
        1. Open a new file defined by output_file
        2. Write json_obj to the new file

    Args:
        json_obj: json string containing employee information
        output_file: the file the json is being written to
    """
    ### WRITE SOLUTION HERE
    newfile = open(output_file, 'w')
    newfile.write(json_obj)
    newfile.close()
    return newfile
    raise NotImplementedError()

def main():
    # Print the contents of details() -- This should print the details of an employee
    details()

    # Create employee dictionary
    employee_dict = create_dict(employee_name, age, title)
    print("employee_dict: " + str(employee_dict))

    ''' 
    Use a function called dumps from the json module to convert employee_dict
    into a json string and store it in a variable called json_object.
    '''
    ### WRITE YOUR CODE BY MODIFYING THE LINE BELOW
    # In the line below replace the None keyword with your code. 
    # The format should look like: variable = json.dumps(dict)
    json_object = json.dumps(employee_dict)  # encapsulates dictionary object
    print(f'Type for employee_dictionary : {type(employee_dict)}. Type for json_object using .dumps method : {type(json_object)}')
    print("json_object: " + str(json_object))

    # Write out the json object to file
    write_json_to_file(json_object, "employee.json")

if __name__ == "__main__":
    main()

## Printouts
# Employee name is:   Mario
# Employee age is:  55
# Employee title is:   owner
# employee_dict: {'first_name': 'Mario', 'age': 55, 'title': 'owner'}
# Type for employee_dictionary : <class 'dict'>. Type for json_object using .dumps method : <class 'str'>
# json_object: {"first_name": "Mario", "age": 55, "title": "owner"}