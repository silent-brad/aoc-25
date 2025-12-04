;; Day 4: Printing Department

(fn solve [filename]
  )

;; --- Run it ---
(local filename (. [...] 1))
(let [(p1 p2) (solve filename)]
  (print "Part 1:" p1)
  ;; string.format needed to not output as scientific notation
  (print "Part 2:" (string.format "%.16g" p2)))
