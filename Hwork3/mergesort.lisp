(defun partition (lst left right)
  "Splits lst into two."
  (cond
    ((null lst) (values (reverse left) (reverse right)))  ; Base case: return reversed halves
    ((null (cdr lst)) (values (reverse (cons (car lst) left)) (reverse right))) ; One item left, add to left
    (t (partition (cddr lst) (cons (car lst) left) (cons (cadr lst) right)))))  ; Split into two lists

(defun merge-lists (lst1 lst2)
  "Merges two sorted lists into one sorted list."
  (cond
    ((null lst1) lst2)  ; If lst1 is empty, return lst2
    ((null lst2) lst1)  ; If lst2 is empty, return lst1
    ((<= (car lst1) (car lst2)) (cons (car lst1) (merge-lists (cdr lst1) lst2)))  ; Take from lst1
    (t (cons (car lst2) (merge-lists lst1 (cdr lst2))))))  ; Take from lst2

(defun mergesort (lst)
  "Sorts lst using the Mergesort algorithm recursively."
  (if (or (null lst) (null (cdr lst)))  ; Base case: empty or single element list
      lst
      (multiple-value-bind (left right) (partition lst '() '())  ; Partition into two halves
        (merge-lists (mergesort left) (mergesort right)))))  ; Recursively sort and merge


;; Run the sorting function and print the result
(format t "Sorted list: ~a~%" (mergesort '(3 1 4 1 5 9 2 6 5 3 5)))