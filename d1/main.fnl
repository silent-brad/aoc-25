(fn solve [filename count-pass?]
  (var dial 50)
  (var zeros 0)

  (with-open [f (io.open filename)]
    (each [line (f:lines)]
      (when (and line (not (line:find "^%s*$")))
        (let [dir (line:sub 1 1)
              dist (tonumber (line:sub 2))
              delta (if (= dir :L) (- dist) dist)]

          ;; Full circles: every 100 clicks passes 0 once
          (when (and count-pass? (>= (math.abs delta) 100))
            (set zeros (+ zeros (math.floor (/ (math.abs delta) 100)))))

          ;; Effective move within 0..99
          (local effective (% delta 100))
          (local new-dial (% (+ dial effective 10000) 100))

          ;; Count crossing 0 on partial move
          (when count-pass?
            (if (> effective 0)
                (when (>= (+ dial effective) 100)
                  (set zeros (+ zeros 1)))
                (< effective 0)
                (when (< (+ dial effective) 0)
                  (set zeros (+ zeros 1)))))

          (set dial new-dial)

          ;; Landed on 0?
          (when (= dial 0)
            (set zeros (+ zeros 1))))))

  zeros))

(print "Part 1:" (solve :data.txt false))
(print "Part 2:" (solve :data.txt true))
