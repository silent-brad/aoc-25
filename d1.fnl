;; Day 1: Secret Entrance

;; Safe modulo 100 -> always returns 0..99
(fn mod100 [n]
  (let [m (% n 100)]
    (if (< m 0) (+ m 100) m)))

(fn solve [filename]
  (var pos 50)
  (var part1 0)
  (var part2 0)
  (with-open [file (io.open filename "r")]
    (each [line (file:lines)]
      (when (and line (> (length line) 0))
        (let [dir (line:sub 1 1)
              dist (tonumber (line:sub 2))
              step (if (= dir "R") 1 -1)]
          ;; Simulate every single click
          (for [_ 1 dist]
            (set pos (mod100 (+ pos step)))
            (when (= pos 0)
              (set part2 (+ part2 1))))
          ;; Part 1: only count if we land on 0 after full rotation
          (when (= pos 0)
            (set part1 (+ part1 1)))))))
  (values part1 part2))

;; --- Run it ---
(local filename (. [...] 1))
(let [(p1 p2) (solve filename)]
  (print "Part 1:" p1)
  (print "Part 2:" p2))
