;; Recursive Descent Parser

;; Define a global variable to store tokenized input
(defvar *tokens* '())  

;; Function to parse G -> x | y | z | w
(defun Gfn (str)
  (print '(in Gfn)) (print str)  ;; Print debug information
  (if (and str (member (car str) '(x y z w)))  
      (cdr str)  ;; Consume a valid G terminal and return the remaining tokens
      (append str (list 'err))))  ;; Return error if G is not valid

;; Function to parse E' -> oG E' | ε (empty production)
(defun E1fn (str)
  (print '(in E1fn)) (print str)
  (if (and str (eql (car str) 'o))  ;; If the next token is 'o', apply rule E' -> oG E'
      (let ((x (Gfn (cdr str))))  ;; Parse G and get remaining tokens
        (if (or (null x) (equal x '()))  ;; If parsing G fails, return error
            (append str (list 'err))
            (E1fn x)))  ;; Recursively parse E'
      str))  ;; Return remaining tokens when E' -> ε

;; Function to parse E -> G E'
(defun Efn (str)
  (print '(in Efn)) (print str)
  (let ((x (Gfn str)))  ;; Parse G first
    (if (or (null x) (equal x '()))  ;; If G parsing fails, return error
        (append str (list 'err))
        (E1fn x))))  ;; Continue parsing with E'

;; Function to parse L' -> s L' | ε (empty production)
(defun L1fn (str)
  (print '(in L1fn)) (print str)
  (if (and str (eql (car str) 's))  ;; If next token is 's', apply L' -> s L'
      (L1fn (cdr str))  ;; Recursively parse L'
      str))  ;; Return remaining tokens when L' -> ε

;; Function to parse L -> s L'
(defun Lfn (str)
  (print '(in Lfn)) (print str)
  (if (and str (eql (car str) 's))  ;; If the next token is 's', parse L'
      (let ((x (L1fn (cdr str))))  ;; Parse L'
        (if (or (null x) (equal x '()))
            nil  ;; If L' parsing is successful, return nil (fully consumed)
            x))  ;; Return remaining tokens
      (append str (list 'err))))  ;; Return error if L -> s L' is not matched

;; Function to parse S -> s | d L b
(defun Sfn (str)
  (print '(in Sfn)) (print str)
  (cond
    ((and str (eql (car str) 's)) (cdr str))  ;; If 's', return remaining tokens (fully consumed)
    ((and str (eql (car str) 'd))  ;; If 'd', expect L b
     (let ((x (Lfn (cdr str))))  ;; Parse L
       (if (and x (not (null x)) (eql (car x) 'b))  ;; If L is followed by 'b', consume 'b'
           (cdr x)  ;; Return remaining tokens
           (append str (list 'err)))))  ;; Return error if L b is not matched
    (t (append str (list 'err)))))  ;; Return error for invalid S

;; Function to parse I -> i E S | i E S e S
(defun Ifn (str)
  (print '(in Ifn)) (print str)
  (cond
    ((and str (eql (car str) 'i))  ;; If 'i' is the first token, proceed with E S
     (let ((x (Efn (cdr str))))  ;; Parse E
       (cond
         ((null x) nil)  ;; If Efn fully consumed, return nil
         ((member (car x) '(s d))  ;; If next token is S (either 's' or 'd'), parse S
          (let ((y (Sfn x)))
            (cond
              ((null y) nil)  ;; If S is fully consumed, return nil
              ((and y (eql (car y) 'e))  ;;  If 'e' follws S, expect another E S
               (let ((z (Efn (cdr y))))  ;; Parse second E
                 (cond
                   ((null z) nil)  ;; If E is fully consumed, return nil
                   ((member (car z) '(s d)) (Sfn z))  ;; Parse the second S
                   (t (append (cdr y) (list 'err))))))  ;; Return error if second S is invalid
              (t y))))  ;; Return remaining tokens
         (t (append (cdr str) (list 'err))))))  ;; Return error if second S is invalid
    (t (append (cdr str) (list 'err)))))  ;; Return error if I does not start with 'i'

;; Entry point: Parses the given input list
(defun parse (input)
  (setq *tokens* input)  ;; Store input in the global token list
  (let ((result (Ifn *tokens*)))  ;; Start parsing from the I non-terminal
    (if (or (null result) (equal result '()))
        (format t "Parsing successful!~%")  ;; Print success if parsing is complete
        (format t "Parsing error: Remaining tokens: ~A~%" result))))  ;; Print error if parsing failed
