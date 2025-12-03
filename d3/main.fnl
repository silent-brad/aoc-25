;; Day 3: Lobby

(fn get-joltage [line]
  (let [bank (tostring line)]
    (var highest 0)
    (var i 1)
    (var j 1)
    (each [c (bank:gmatch ".")]
      (let [n (tonumber c)]
        (if (and (> n highest) (< i (length bank)))
            (do (set highest n)
            (set j i))))
      (set i (+ i 1)))
    (var joltage (tostring highest))
    (set highest 0)
    (for [k (+ j 1) (length bank)]
      (let [c (bank:sub k k)
            n (tonumber c)]
        (if (> n highest)
            (set highest n))))
    (set joltage (.. joltage (tostring highest)))
    (tonumber joltage)))

(fn solve [filename]
  (var total 0)
  (with-open [file (io.open filename "r")]
    (each [line (file:lines)]
      (set total (+ total (get-joltage line)))))
  total)

;; (print (solve :test.txt))
(print (solve :data.txt))
