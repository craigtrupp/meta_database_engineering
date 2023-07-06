# Let's write a recursive function that reverses a string
def reverse_str(str):
    # Create Base Case
    if len(str) == 0:
        return str
    # Recursive
    else:
        return reverse_str(str[1:]) + str[0]

test_str = 'craig'
reverse_test_str = reverse_str(test_str)
print(test_str, reverse_test_str)

## Printout 
# craig giarc

## Breakdown
# reverse_str(test_str)
# 1: return reverse_str('raig') + 'c' == raigc (reference value)
# 2: return reverse_str('aig') + 'r' == aigrc (reference value)
# 3: return reverse_str('ig') + 'a' == igarc (reference value)
# 4: return reverse_str('g') + 'i' == giarc
