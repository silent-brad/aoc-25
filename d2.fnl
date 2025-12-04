;; Day 2: Gift Shop
(import-macros {: run-solution} :utils)

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
  (var sum1 0)
  (var sum2 0)
  (each [range (text:gmatch "([^,]+)")]
    (let [ids (string.gmatch range "([^-]+)")
          head (tonumber (ids))
          tail (tonumber (ids))]
      (for [i head tail]
        (if (is-double? i)
            (set sum1 (+ sum1 i)))
        (if (is-repeated? i)
            (set sum2 (+ sum2 i))))))
  (values sum1 sum2))

(run-solution sum-invalid-ids)
