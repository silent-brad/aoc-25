;; Part 5: Cafeteria
(import-macros {: run-solution} :utils)

(fn parse-range [line]
  (let [(a b) (string.match line "(%d+)-(%d+)")]
    [(tonumber a) (tonumber b)]))

(fn covered-by-any? [ranges id]
  (var yes? false)
  (each [_ [lo hi] (pairs ranges) :until yes?]
    (when (and (<= lo id) (<= id hi))
      (set yes? true)))
  yes?)

(macro copy-table [t]
  `(let [copy# []]
    (each [i# val# (ipairs ,t)]
      (table.insert copy# val#))
    copy#))

(fn merge-ranges [ranges]
  (when (= 0 (# ranges)) (lua "return {}"))
  (var sorted (copy-table ranges))
  (table.sort sorted (fn [a b]
                        (if (< (. a 1) (. b 1)) true
                            (> (. a 1) (. b 1)) false
                            (< (. a 2) (. b 2)))))

  (var merged [])
  (var curr-lo (. sorted 1 1))
  (var curr-hi (. sorted 1 2))

  (for [i 2 (# sorted)]
    (let [[lo hi] (. sorted i)]
      (if (<= lo (+ curr-hi 1))
          (set curr-hi (math.max curr-hi hi))
          (do
            (table.insert merged [curr-lo curr-hi])
            (set curr-lo lo)
            (set curr-hi hi)))))

  (table.insert merged [curr-lo curr-hi])
  merged)

(fn count-unique-ids [merged]
  (accumulate [total 0
               _ [lo hi] (ipairs merged)]
    (+ total (- hi lo -1))))

(fn parse-text [text]
  (var fresh-ranges [])
  (var available-ids [])
  (var reading-ranges? true)

  (each [line (text:gmatch "(.-)\n")]
    (when (not= line "")
      (if reading-ranges?
          (if (string.find line "-")
              (table.insert fresh-ranges (parse-range line))
              (do (set reading-ranges? false)
                  (table.insert available-ids (tonumber line))))
          (table.insert available-ids (tonumber line)))))

  (let [part1 (accumulate [cnt 0
                           id (ipairs available-ids)]
                (if (covered-by-any? fresh-ranges (. available-ids id))
                    (+ cnt 1) cnt))
        merged (merge-ranges fresh-ranges)
        part2 (count-unique-ids merged)]
    (values part1 part2)))

(run-solution parse-text)
