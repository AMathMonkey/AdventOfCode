(require "asdf")

(defparameter elves
    (loop for remaining-lines on (uiop:read-file-lines "input.txt")
        collect (loop for line = (car remaining-lines)
            until (or (null line) (equal line ""))
            collect (parse-integer line)
            do (setf remaining-lines (cdr remaining-lines)))))

(format t "Part 1: ~a~%Part 2: ~a~%"
    (loop for elf in elves maximize (apply '+ elf))
    (apply '+ (subseq (sort (loop for elf in elves collect (apply '+ elf)) '>) 0 3)))