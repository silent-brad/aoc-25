;; Part 5: Cafeteria
(import-macros {: run-solution} :utils)

(fn get-range [line]
  (let [range (string.gmatch line "([^-]+)")]
    [(tonumber (range)) (tonumber (range))]))

(fn is-in-range? [ranges id]
  (var found? false)
  (var range (. ranges 1))
  (var i 1)
  (while (and (not found?) (<= i (length ranges)))
    (if (and (<= id (. range 2)) (> id (. range 1)))
        (set found? true))
    (set i (+ i 1))
    (set range (. ranges i)))
  found?)

(fn parse-text [text]
  (var part1 0)
  (var part2 0)
  (var ranges [])
  (var range-i 1)
  (var first-half? true)
  (each [line (text:gmatch "(.-)\n")]
    (if (= line "")
        (set first-half? false)
        first-half?
        (let [range (get-range line)
              start (. range 1)
              finish (. range 2)]

          (for [id start finish]
            (var overlaps? false)
            (each [_ [prev-start prev-finish] (pairs ranges)]
              (if (and (<= id prev-finish) (>= id prev-start))
                  (set overlaps? true)))
            (if (not overlaps?)
                (set part2 (+ part2 1))))

          (table.insert ranges range)
          (set range-i (+ range-i 1)))
        (if (is-in-range? ranges (tonumber line))
            (set part1 (+ part1 1)))))

  (values part1 part2))

(run-solution parse-text)
