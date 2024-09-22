from collections import List

fn add(a: Int16, b: Int16) -> Int16:
    return a + b

fn subtract(a: Int16, b: Int16) -> Int16:
    return a - b

fn multiply(a: Int16, b: Int16) -> Int16:
    return a * b

fn divide(a: Float64, b: Float64) -> Float64:
    if b == 0.0:
        print("Error: Division by zero is not allowed.")
        return 0.0
    return a / b

fn try_parse_int(value: String) -> Int:
    if len(value) == 0 or not value.isdigit():
        print("Invalid input. Please enter a valid number.")
        return 0
    try:
        return Int(int(value))
    except:
        print("Invalid input. Please enter a valid number.")
        return 0

fn try_parse_float(value: String) -> Float64:
    if len(value) == 0:
        print("Invalid input. Please enter a valid number.")
        return 0.0
    try:
        return Float64(atof(value))
    except:
        print("Invalid input. Please enter a valid number.")
        return 0.0

def main():
    
    var simple_options = List[Int](1,2,3)
    while True:
        print("\nCalculator")
        print("1. Add")
        print("2. Subtract")
        print("3. Multiply")
        print("4. Divide")
        print("5. Exit")
        print("Enter your choice: ", end="")
        choice = input()

        int_choice = try_parse_int(choice)

        if int_choice == 0 and choice != "0":
            continue
    
        if int_choice == 5:
            print("Exiting...")
            break

        if int_choice in simple_options:
            print("Enter first number: ", end="")
            a = try_parse_int(input())
            print("Enter second number: ", end="")
            b = try_parse_int(input())

            if int_choice == 1:
                print("The sum is: ", add(a, b))
            elif int_choice == 2:
                print("The difference is: ", subtract(a, b))
            elif int_choice == 3:
                print("The product is: ", multiply(a, b))
        elif int_choice == 4:
            print("Enter first number: ", end="")
            a_float = try_parse_float(input())
            print("Enter second number: ", end="")
            b_float = try_parse_float(input())

            if b_float != 0:
                result = divide(a_float, b_float)
                print("The result of the division is: ", result)
            else:
                print("Error: Division by zero is not allowed.")
        else:
            print("Invalid choice. Please choose a valid option.")
