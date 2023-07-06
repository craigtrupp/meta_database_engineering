## Match/Case Statement
# Set http status
http_status = 503

## Traditional if/else conditional block
if http_status == 200 or http_status == 201:
    if http_status == 200:
        print(f'Ok Status : {http_status}')
    else:
        print(f'201: Resource Created w/http status : {http_status}')
elif http_status == 400:
    print(f'Bad Request returned a http status of : {http_status}')
elif http_status == 500 or http_status == 501:
    print('Server Error returned a status of : {}'.format(http_status))
else:
    print('Unknown status returned')


## Switch/Case (Match)
match http_status:
    case 200 | 201:
        print('Success with a status of : {}'.format(http_status))
    case 400:
        print(f'Bad Request for the http request, returned : {http_status}')
    case 500 | 501:
        print(f'Server issue : {http_status}')
    case _ :
        print('Unknown status of : {}'.format(http_status))

# printouts
# Unknown status returned
# Unknown status of : 503

# A match statement compares a value to several different conditions until one is met.

# Instructions
# 1.   Under the num_list create a new for loop and print out each value on the list in sequential order.
# 2.  Inside the for loop, create a condition that will look for all numbers that are greater than 45 and print out only numbers that meet that condition
# 3.  Change the print statement to “Over 45” and add an else condition with a print statement of “Under 45”.
# 4.  Update the for loop to use the enumerate function so you can get and use the index. Alter the condition to look for number 36 and print out the following: ‘Number found at position: ‘, index number
# 5.  Next, create a new variable called count and assign it a value of 0 and place it outside the for loop.
# 6.  Inside the for loop increment the counter by 1.
# 7.  Add a print statement outside the for loop to print the value of the count variable.
# 8.  Finally, add a break statement directly after the print statement inside the if condition for finding the number. 

num_list = [33,42,5,66,77,22,16,79,36,62,78,43,88,39,53,67,89,11]
print([x for x in num_list]) # 1 : [33, 42, 5, 66, 77, 22, 16, 79, 36, 62, 78, 43, 88, 39, 53, 67, 89, 11]
print([x for x in num_list if x > 45]) # 2 : [66, 77, 79, 62, 78, 88, 53, 67, 89]
print([f'{x} : Over 45' if x > 45 else f'{x} : Under 45' for x in num_list])
# ['33 : Under 45', '42 : Under 45', '5 : Under 45', '66 : Over 45', '77 : Over 45', '22 : Under 45', '16 : Under 45', '79 : Over 45', 
# '36 : Under 45', '62 : Over 45', '78 : Over 45', '43 : Under 45', '88 : Over 45', '39 : Under 45', '53 : Over 45', '67 : Over 45', '89 : Over 45', '11 : Under 45']

# 4 Enumerate
print([(i, j) for i, j in enumerate(num_list[:5])]) # [(0, 33), (1, 42), (2, 5), (3, 66), (4, 77)]
print([f'Number found at position : {i} for value {j}' for i, j in enumerate(num_list) if j == 36]) # ['Number found at position : 8 for value 36']


count = 0
for item in num_list:
    if item == 36:
        break
    else:
        count += 1
print(count) # 8