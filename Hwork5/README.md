# Homework 5 CSCI 330

## Author: Cha Vue

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
For example, to run `descentParser.lisp` with a sample list:

```lisp
(load "descentParser.lisp")
(parse '(i z o y d s s b))
```


---

This README provides the necessary steps to run the Lisp implementations for Homework 5 in CSCI 330. If any issues arise, ensure that the files are in the correct directory and SBCL is properly installed.

