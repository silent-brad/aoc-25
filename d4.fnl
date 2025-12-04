;; Day 4: Printing Department
(import-macros {: run-solution} :utils)

;; Copies a 2x2 table matrix
(macro copy-matrix [m]
  `(let [copy# []]
    (each [i# row# (ipairs ,m)]
      (let [new-row# []]
        (each [j# val# (ipairs row#)]
          (table.insert new-row# val#))
        (table.insert copy# new-row#)))
    copy#))

;; Converts text to a 2x2 table matrix
(macro convert-to-matrix [text]
  `(let [matrix# []]
    (each [line# (text:gmatch "[^\n]+")]
      (var inner-table# [])
      (each [tile# (line#:gmatch "(.)")]
        (table.insert inner-table# tile#))
      (table.insert matrix# inner-table#))
    matrix#))

(fn is-forklift-accessable? [matrix a b]
  ;; Check if more than 4 of the surronding eight tiles are "@"
  (var rolls 0)
  ;; x x x
  ;; x a x
  ;; x x x
  (let [rows (length matrix)
        cols (length (. matrix 1))]
    ;; Check all 8 surrounding positions
    (for [da -1 1]
      (for [db -1 1]
        (when (not (and (= da 0) (= db 0))) ;; Skip center position
          (let [na (+ a da)
                nb (+ b db)]
            ;; Check bounds and if tile is "@"
            (when (and (>= na 1) (<= na rows)
                       (>= nb 1) (<= nb cols)
                       (= (. matrix na nb) "@"))
              (set rolls (+ rolls 1))))))))
    (< rolls 4))

(fn parse-line [text]
  (var part1 0)
  (var part2 0)
  (var matrix (convert-to-matrix text))

  ;; Part 1
  (each [a aisle (ipairs matrix)]
    (each [b tile (ipairs aisle)]
      (if (= tile "@")
        (if (is-forklift-accessable? matrix a b)
            (set part1 (+ part1 1))))))

  ;; Part 2
  (var new-matrix (copy-matrix matrix))
  (var rolls-per-pass 0)
  (var accessable-rolls-left? true)
  (while accessable-rolls-left?
    (each [a aisle (ipairs matrix)]
      (each [b tile (ipairs aisle)]
        (if (= tile "@")
          (if (is-forklift-accessable? matrix a b)
              (do (set rolls-per-pass (+ rolls-per-pass 1))
                  ;; Remove the roll from the new matrix
                  (set (. new-matrix a b) "."))))))
    (set part2 (+ part2 rolls-per-pass))
    (if (= rolls-per-pass 0)
        (set accessable-rolls-left? false)
        (set matrix (copy-matrix new-matrix)))
    (set rolls-per-pass 0))

  (values part1 part2))

(run-solution parse-line)
