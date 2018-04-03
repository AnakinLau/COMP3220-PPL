#lang plai

(require racket/path)

;;creates global list variable called tokens
;;reads in every line from tokens file and saves
;;each token/lexeme pair as a separate list item
;(define tokens (file->lines (string->path "D:\\Dropbox\\auburn_faculty\\RacketPrograms\\tokens")));;school computer
;(define tokens (file->lines (string->path "F:\\Dropbox\\auburn_faculty\\RacketPrograms\\tokens")));;home computer
(define tokens (file->lines (string->path "E:\\School\\Comp Principles of Programming Languages\\Assignment3\\tokens.txt")));;home computer

;;helper function
;;retrieves the first token from the list of tokens
(define current_token
  (lambda ()
    (regexp-split #px" " (car tokens))
    );end lambda
  );end current_token

;;helper function
;;removes one token from the tokens list
;;so that current_token function always extracts
;;the next available token
(define next_token
  (lambda ()
    (set! tokens (cdr tokens))
    (cond
      ((null? tokens)
       (display "No more tokens to parse!")
       (newline)
       (display "Exiting prematurely, no eof found")
       (newline)
       (exit));end null tokens
      (else
       (cond
         ((equal? (car (current_token)) "eof")
          (display "eof found. Exiting program now.");Exit program
          (newline)
          ;(exit);Exit program safely ;Commented out so the results of the program can be shown!
          )     
         );end cond
       (cond
         ((equal? (car (current_token)) "whitespace")
          (next_token);call yourself again
          )     
         );end cond
       );end else
      );end cond
    );end lambda
  );end next_token
    

;;checks ID rule
;;if current_token is an id token
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
;;if current_token is not id, displays an error message
(define id
  (lambda ()
    (display "Entering <id>")
    (newline)
    (cond
      ((equal? (car (current_token)) "id")
       (display "Found ")
       (display (second (current_token)))
       (newline)
       (next_token)
       (display "Leaving <id>")
       (newline)
       );end first equality check in condition
      (else
       (display "Not an id token: Error")
       (newline)
       (set! errorCount (+ 1 errorCount));increment errorCount
       (display "Instead found ")
       (display (current_token))
       (newline)
       );end else statement
      );end condition block
    );end lambda
  );end id

;;checks int rule
;;if current_token is an int token
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
;;if current_token is not int, displays an error message
(define int
  (lambda ()
    (display "Entering <int>")
    (newline)
    (cond
      ((equal? (car (current_token)) "int")
       (display "Found ")
       (display (second (current_token)))
       (newline)
       (next_token)
       (display "Leaving <int>")
       (newline)
       );end first equality check in condition
      (else
       (display "Not an int token: Error")
       (newline)
       (set! errorCount (+ 1 errorCount));increment errorCount
       (display "Instead found ")
       (display (current_token))
       (newline)
       );end else statement
      );end condition block
    );end lambda
  );end int

;;checks factor rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define factor
    (lambda ()
      (display "Entering <factor>")
      (newline)
      (cond
        ((equal? (car (current_token)) "int" )
         (int)
         );end first equality check in condition (int)

        ((equal? (car (current_token)) "id" )
         (id)
         );end second equality check in condition (id)

        ((equal? (car (current_token)) "(" )
         (display "Found ")
         (display (second (current_token)))
         (newline)
         (next_token)
         (exp)
         
         (cond
           ((not (equal? (car (current_token)) ")" ))
            (display "closing parathesis not found in <factor>")
            (set! errorCount (+ 1 errorCount));increment errorCount
            (newline)
            (display "Instead found ")
            (display (current_token))
            (newline)
            );end closing parenthesis check
           (else
            (display "Found ")
            (display (second (current_token)))
            (newline)
            );display found message if found closing parenthesis
           );end inner cond block (parenthesis)

         (next_token)
         );end third equality check in condition ((<exp>))
        
        (else
         (display "Not an <factor> token: int, id, or (. Error")
         (set! errorCount (+ 1 errorCount));increment error count
         (newline)
         (display "Instead found ")
         (display (current_token))
         (newline)
         (next_token);;;NOT SURE IF CORRECT ORDER?
         );end else statement
        );end condition block
      (display "Leaving <factor>")
       (newline)
      );end lambda
  );end define factor



;;checks term rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define term
  (lambda ()
    (display "Entering <term>")
    (newline)
    (factor)
    (ttail)
    (display "Leaving <term>")
    (newline)
    );end lambda
  );end define term




;;checks etail rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define etail
  (lambda ()
    (display "Entering <etail>")
      (newline)
      (cond
        ((equal? (car (current_token)) "+" )
         (display "Found ")
         (display (second (current_token)))
         (newline)
         (next_token)
         (term)
         (etail)
         );end first equality check in condition (+)

        ((equal? (car (current_token)) "-" )
         (display "Found ")
         (display (second (current_token)))
         (newline)
         (next_token)
         (term)
         (etail)
         );end first equality check in condition (-)

        (else
         (display "Next token is not + or -, choosing EPSILON production")
         (newline)
         ;(next_token);;;NOT SURE IF CORRECT ORDER?
         );end else statement
        );end condition block
      (display "Leaving <etail>")
       (newline)
    );end lambda
  );end define etail




;;checks ttail rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define ttail
  (lambda ()
    (display "Entering <ttail>")
      (newline)
      (cond
        ((equal? (car (current_token)) "*" )
         (display "Found ")
         (display (second (current_token)))
         (newline)
         (next_token)
         (factor)
         (ttail)
         );end first equality check in condition (*)

        ((equal? (car (current_token)) "/" )
         (display "Found ")
         (display (second (current_token)))
         (newline)
         (next_token)
         (factor)
         (ttail)
         );end first equality check in condition (/)

        (else
         (display "Next token is not * or /, choosing EPSILON production")
         (newline)
         ;(next_token);;;NOT SURE IF CORRECT ORDER?
         );end else statement
        );end condition block
      (display "Leaving <ttail>")
       (newline)
    );end lambda
  );end define ttail




;;checks exp rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define exp
  (lambda ()
    (display "Entering <exp>")
    (newline)
    (term)
    (etail)    
    (display "Leaving <exp>")
    (newline)
    );end lambda
  );end define exp




;;checks assign rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define assign
    (lambda ()
      (display "Entering <assign>")
      (newline)
      (id)
      (cond
        ((not (equal? (car (current_token)) "=" ))
         (display "Equal sign expected but not found in <assign>")
         (newline)
         (display "Instead found ")
         (display (current_token))
         (set! errorCount (+ 1 errorCount))
         (newline)
         );end equal sign check
        (else
         (display "Found ")
         (display (second (current_token)))
         (newline)
         );display found message if found equal sign
        );end cond block (equal)      
      (next_token)
      (exp)
      (display "Leaving <assign>")
      (newline)
      );end lambda
  );end define assign




;;checks stmt rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define stmt
    (lambda ()
      (display "Entering <stmt>")
      (newline)
      (cond
        ((equal? (car (current_token)) "print" )
         (display "Found ")
         (display (second (current_token)))
         (newline)
         (next_token)
         (exp)
         );end closing parenthesis check
        (else
         (assign)
         );display found message if found closing parenthesis
        );end inner cond block (parenthesis)      
      (display "Leaving <stmt>")
      (newline)
      (cond
        ((not(equal? (car (current_token)) "eof" ))
         (stmt)
         )
        )
      );end lambda
  );end define stmt

(define errorCount 0)


;;checks pgm rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define pgm
    (lambda ()
      
      (display "Entering <pgm>")
      (newline)
      (stmt)
      (display "Leaving <pgm>")
      (newline)
      (display "Reached end of file. Parse complete...")
      (newline)
      (cond
        ((equal? errorCount 0)
         (display "Parse was completely successful ")
         (newline)
         );Parse success
        (else
         (display "Parse had some errors")
         (newline)
         );Parse error
        )

      
      (display "Parse completed with ")
      (display errorCount)
      (display " errors.")
      (newline)
      (display "Program will now exit.")
      (exit);exits program safely
      );end lambda
  );end define pgm





;;test function to test whether or not next_token
;;will actually terminate program when it encounters
;;eof
(define tt
  (lambda ()
    (display (current_token))
    (newline)
    (next_token)
    (tt)
    )
  )