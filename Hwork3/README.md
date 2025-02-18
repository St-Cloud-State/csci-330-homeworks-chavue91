# Homework 3 CSCI 330

## Author: Cha Vue

### Running the C++ Program
To compile and run `non-recursive-quicksort.cpp`, use the following commands:

```sh
g++ non-recursive-quicksort.cpp -o quicksort
./quicksort
```

### Running the Lisp Programs
To run the Lisp programs, follow these steps:

1. Place the Lisp files into the directory `sbcl-1.4.3-x86-linux`.
2. Change into the directory:

   ```sh
   cd sbcl-1.4.3-x86-linux
   ```

3. Start SBCL:

   ```sh
   sbcl
   ```

4. Load the desired Lisp file:

   ```lisp
   (load "<file-name>")
   ```

5. Run the sorting function with a list:

   ```lisp
   (<function> '(<list>))
   ```

### Example Usage
For example, to run `bottom-up-mergesort.lisp` with a sample list:

```lisp
(load "bottom-up-mergesort.lisp")
(bottom-up-mergesort '(7 3 5 2 9 1 4))
```

This will return a sorted list as output.

---

This README provides the necessary steps to run both the C++ and Lisp implementations for Homework 3 in CSCI 330. If any issues arise, ensure that the files are in the correct directory and SBCL is properly installed.

