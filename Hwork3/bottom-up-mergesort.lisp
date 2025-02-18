(defun merge-lists (lst1 lst2)
  "Merges two sorted lists into one sorted list."
  (cond
    ((null lst1) lst2)
    ((null lst2) lst1)
    ((<= (car lst1) (car lst2)) (cons (car lst1) (merge-lists (cdr lst1) lst2)))
    (t (cons (car lst2) (merge-lists lst1 (cdr lst2))))))

(defun partition-into-pairs (lst)
  "Partitions the list into sorted pairs or singletons."
  (cond
    ((null lst) '())  ; Base case: empty list
    ((null (cdr lst)) (list lst))  ; Singleton if only one element left
    (t (cons (merge-lists (list (car lst)) (list (cadr lst))) 
             (partition-into-pairs (cddr lst))))))  ; Recursively pair elements

(defun merge-pass (lst)
  "Recursively performs one pass of merging adjacent sublists."
  (cond
    ((null lst) '())  ; If empty, return empty
    ((null (cdr lst)) lst) ; If only one sublist remains, return it
    (t (cons (merge-lists (car lst) (cadr lst)) (merge-pass (cddr lst)))))) ; Merge pairs

(defun merge-until-sorted (sublists)
  "Recursively merges sublists until only one sorted list remains."
  (if (null (cdr sublists))  ; Base case: if there's only one list, return it
      (car sublists)
      (merge-until-sorted (merge-pass sublists))))  ; Continue merging

(defun bottom-up-mergesort (lst)
  "Fully declarative bottom-up mergesort."
  (merge-until-sorted (partition-into-pairs lst)))  ; Start from sorted pairs and recursively merge

;; Example Usage
(bottom-up-mergesort '(1 7 2 1 8 6 5 3 7 9 4))
