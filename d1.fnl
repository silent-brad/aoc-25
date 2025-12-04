;; Day 1: Secret Entrance
(import-macros {: run-solution} :utils)

;; Safe modulo 100 -> always returns 0..99
(fn mod100 [n]
  (let [m (% n 100)]
    (if (< m 0) (+ m 100) m)))

(fn parse-line [text]
  (var pos 50)
  (var part1 0)
  (var part2 0)
  (each [line (text:gmatch "[^\n]+")]
    (when (and line (> (length line) 0))
      (let [dir (line:sub 1 1)
            dist (tonumber (line:sub 2))
            step (if (= dir "R") 1 -1)]
        ;; Simulate every single click (part 2)
        (for [_ 1 dist]
          (set pos (mod100 (+ pos step)))
          (when (= pos 0)
            (set part2 (+ part2 1))))
        ;; Only count if we land on 0 after full rotation (part 1)
        (when (= pos 0)
          (set part1 (+ part1 1))))))
  (values part1 part2))

(run-solution parse-line)
