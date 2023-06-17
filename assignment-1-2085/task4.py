"""
This file is modified to explain the insertion_sort() function.
Each comment is used to explain what each line of code does.
"""

__author__ = "Shoumil Guha"

from typing import List, TypeVar

T = TypeVar('T')


def insertion_sort(the_list: List[T]):  # pass a list into the function
    length = len(the_list)  # store the length of the list in a local variable
    for i in range(1, length):  # iterate over each value in the array except the first
        key = the_list[i]   # initialize a local variable with the value at the current index of the list temporarily
        j = i - 1   # variable j used to access index position behind i
        while j >= 0 and key < the_list[j]:  # while j >= index of first element & next element < previous element
            the_list[j + 1] = the_list[j]   # put the previous element in the position of the succeeding element
            j -= 1  # go to the back of the index of the jth element (the_list[j])
        the_list[j + 1] = key   # put the stored value of the overwritten element in that index position


def main() -> None:
    arr = [6, -2, 7, 4, -10]
    insertion_sort(arr)
    for i in range(len(arr)):
        print(arr[i], end=" ")
    print()


main()
