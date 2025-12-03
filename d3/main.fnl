;; Day 3: Lobby

(fn get-joltage [line digits]
  (let [bank (tostring line)]
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
    joltage))

(fn solve [filename]
  (var part1 0)
  (var part2 0)
  (with-open [file (io.open filename "r")]
    (each [line (file:lines)]
      (set part1 (+ part1 (get-joltage line 2)))
      (set part2 (+ part2 (get-joltage line 12)))))
  (values part1 part2))

;; --- Run it ---
;; (local filename :test.txt)
(local filename :data.txt)
(let [(p1 p2) (solve filename)]
  (print "Part 1:" p1)
  ;; string.format needed to not output as scientific notation
  (print "Part 2:" (string.format "%.16g" p2)))
