(defun insert-sorted (x sorted)
  "Inserts element x into the sorted list in ascending order."
  (cond
    ((null sorted) (list x))  ; Base case: inserting into empty list
    ((<= x (car sorted)) (cons x sorted))  ; Insert x before first larger element
    (t (cons (car sorted) (insert-sorted x (cdr sorted))))))  ; Recurse to find position

(defun insertion-sort-helper (sorted unsorted)
  "Recursively moves elements from unsorted to sorted list."
  (if (null unsorted)  ; Base case: when unsorted is empty, return sorted list
      sorted
      (insertion-sort-helper (insert-sorted (car unsorted) sorted) (cdr unsorted))))  ; Insert first item and recurse

(defun insertion-sort (lst)
  "Fully declarative insertion sort."
  (insertion-sort-helper '() lst))  ; Start with empty sorted list

;; Example Usage
(insertion-sort '(7 3 5 2 9 1 4))
