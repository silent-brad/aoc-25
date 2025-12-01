;; Day 1

(fn rotate [num]
  (if (> num 99)
    (- num 99)
    (if (< num 0)
      (+ num 99)
      num)))

(fn get-new-num [num cmd]
  (let [turn (tonumber (string.sub cmd 2))]
    (rotate (if (= (string.sub cmd 1 1) "L")
      (- num turn)
      (+ num turn)))))

(fn turn-dial [zeros num lines]
  (let [cmd (lines)]
    (if cmd
      (let [new-num (get-new-num num cmd)]
        (if (= new-num 0)
          (turn-dial (+ zeros 1) new-num lines)
          (turn-dial zeros new-num lines)))
      zeros)))

(print (turn-dial 0 0 (io.lines :data.txt)))
