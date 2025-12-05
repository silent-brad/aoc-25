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
  (var ids [])
  (var first-half? true)
  (each [line (text:gmatch "(.-)\n")]
    (if (= line "")
        (set first-half? false)
        first-half?
        (table.insert ranges (get-range line))
        (if (is-in-range? ranges (tonumber line))
            (set part1 (+ part1 1)))))

  (values part1 part2))

(run-solution parse-text)
