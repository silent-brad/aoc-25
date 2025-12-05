;; Day 3: Lobby
(import-macros {: run-solution} :utils)

(fn get-joltage [bank digits]
  (var joltage "")
  (var highest 0)
  (var j 0)

  (for [a 1 digits]
    (set highest 0)
    (for [i (+ j 1) (- (length bank) (- digits a))]
      (let [n (tonumber (bank:sub i i))]
        (if (> n highest)
            (do (set highest n)
                (set j i)))))
    (set joltage (.. joltage (tostring highest))))
  joltage)

(fn parse-text [text]
  (var part1 0)
  (var part2 0)
  (each [line (text:gmatch "[^\n]+")]
    (set part1 (+ part1 (get-joltage line 2)))
    (set part2 (+ part2 (get-joltage line 12))))
  (values part1 part2))

(run-solution parse-text)
