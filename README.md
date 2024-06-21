Static-Storage-of-Even-Odd-Number-Pairs

Objective

The objective of this project is to create a program in Pascal that stores a set of even-odd number pairs in an array. The numbers are generated using a pseudorandom number generator and stored in a queue. The pairs of numbers are then created using two stacks, where one stack holds even numbers and the other stack holds odd numbers. The queue and stacks are implemented using singly linked lists. The queue has a fixed length of 25 elements.

Task Description

Overview

The task involves creating a program that:
1. Initializes a queue with 25 pseudorandomly generated integers.
2. Processes the queue to separate even and odd numbers, storing them in two respective stacks.
3. Forms pairs of even and odd numbers from these stacks and stores them in a static array.
4. Displays the contents of the queue, stacks, and the array of pairs on the console.

Detailed Steps

1. Initialization and Data Loading:
   - Initialize the data structures: a queue for storing the integers, and two stacks for separating even and odd numbers.
   - Load the queue with 25 pseudorandomly generated integers.

2. Queue Processing:
   - Extract elements from the queue one by one.
   - Determine whether each element is even or odd using the modulo operation.
   - Push even numbers onto the even stack and odd numbers onto the odd stack.

3. Condition Checking:
   - Continue processing the queue until it is empty.
   - Check the stacks to ensure they contain elements for pairing.

4. Pair Formation:
   - While both stacks contain elements, pop the top elements from each stack.
   - Form a pair from these elements and store the pair in the static array.

5. Display:
   - Display the contents of the queue, the even and odd stacks, and the array of pairs on the console.

Explanation of Code

Types and Data Structures

The program defines several record types to represent different data structures:

- pNode: A pointer to a tNode, representing a node in a singly linked list.
- tNode: A record that contains an integer data field and a pointer to the next node.
- tQueue: A record with pointers to the first and last nodes, representing the queue.
- tPairOfNumbers: A record that stores a pair of integers.
- tSequenceOfPairs: A record that stores an array of tPairOfNumbers and an integer indicating the number of pairs.

Procedures and Functions

The program includes several procedures and functions to handle various tasks:

- displayProgramInfo: Displays program information.
- displayList: Displays the contents of a linked list starting from a given node.
- displaySequenceOfPairs: Displays the contents of an array of pairs.
- addToQueue: Adds an integer to the end of the queue.
- retrieveFromQueue: Removes and returns an integer from the front of the queue.
- pushToStack: Pushes an integer onto a stack.
- popFromStack: Pops and returns an integer from a stack.
- generateRandomNumbersToQueue: Generates 25 pseudorandom integers and adds them to the queue.
- executeExerciseAlgorithm: Processes the queue to separate even and odd numbers into stacks, forms pairs, and stores them in an array.

Main Program

The main program performs the following steps:

1. Initialization: Initializes the queue, stacks, and the array of pairs.
2. Display Information: Displays program information and waits for user input.
3. Generate Random Numbers: Generates random numbers and adds them to the queue.
4. Display Queue: Displays the contents of the queue.
5. Execute Algorithm: Processes the queue, forms pairs, and displays the stacks and array of pairs.
6. End Program: Waits for user input to terminate the program.
Conclusion

This project demonstrates the use of data structures such as queues, stacks, and arrays in Pascal to solve a specific problem of organizing and pairing even and odd numbers. The implementation showcases the use of linked lists to create dynamic data structures and illustrates how to handle and manipulate these structures effectively.
