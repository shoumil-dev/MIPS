"""
This file is modified to explain the combination_aux() function.
Each comment is used to explain what each line of code does.
"""

__author__ = "Shoumil Guha"


def print_combination(arr, n, r):
    data = [0] * r

    combination_aux(arr, n, r, 0, data, 0)


def combination_aux(arr, n, r, index, data, i):  # calling combination aux function

    if (index == r):  # if the index is equal to the value of r
        for j in range(r):
            print(data[j], end=" ")  # print all elements until the rth element of the data array
        print()  # print a newline after
        return  # leave the function after printing

    if (i >= n):  # if i is greater than or equal to size of initial array
        return  # leave the function if the value of i is greater than the size of the initial array

    data[index] = arr[i]  # put the value of the ith index of initial array in the data array's specified index
    combination_aux(arr, n, r, index + 1,
                    data, i + 1)  # call the function recursively passing incremented values of index and i as args

    combination_aux(arr, n, r, index,
                    data, i + 1)  # call the function recursively again passing incremented value of i as an arg


def main():
    arr = [1, 2, 3, 4, 5]
    r = 3
    n = len(arr)
    print_combination(arr, n, r)


main()
