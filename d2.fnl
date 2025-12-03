;; Day 2: Gift Shop

;; For part 1
(fn is-double? [n]
  (let [n (tostring n)
        len (length n)]
    (and (= 0 (% len 2))
         (let [half (/ len 2)]
           (= (string.sub n 1 half)
              (string.sub n (+ half 1) len))))))

;; For part 2
(fn is-repeated? [n]
  (let [n (tostring n)
        len (length n)]
    (var found false)
    (for [pattern-len 1 (/ len 2)]
      (when (= 0 (% len pattern-len))
        (let [pattern (string.sub n 1 pattern-len)
              repetitions (/ len pattern-len)]
          (when (>= repetitions 2)
            (var matches true)
            (for [i 2 repetitions]
              (let [start (+ (* (- i 1) pattern-len) 1)
                    end (* i pattern-len)
                    segment (string.sub n start end)]
                (when (not= pattern segment)
                  (set matches false))))
            (when matches
              (set found true))))))
    found))

(fn sum-invalid-ids [text]
  (var sum 0)
  (each [range (string.gmatch text "([^,]+)")]
    (let [ids (string.gmatch range "([^-]+)")
          head (tonumber (ids))
          tail (tonumber (ids))]
      (for [i head tail]
        (if (is-repeated? i)
            (set sum (+ sum i))))))
  sum)

(fn solve [filename]
  (let [file (io.open filename "r")]
    (if file
        (let [text (file:read "*a")]
          (file:close)
          (sum-invalid-ids text))
        (error "Could not open file"))))

(local filename (. [...] 1))
(print (solve filename))
