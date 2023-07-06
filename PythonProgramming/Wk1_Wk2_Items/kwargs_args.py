def sum_args(*args):
    print([x for x in args], type(args))
    return sum(args)

print(sum_args(3,9,15))

## Returns 
# [3, 9, 15] <class 'tuple'> - args is a tuple (immutable object)
# 27


def sum_kargs(**kwargs):
    print(kwargs) # dicionary : {'juice': 2.35, 'oranges': 3.15, 'bananas': 4.12}
    return round(sum(list(kwargs.values())), 2)

print(sum_kargs(juice=2.35, oranges=3.15, bananas=4.12))  # 9.62