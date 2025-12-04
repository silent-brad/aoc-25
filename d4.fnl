;; Day 4: Printing Department
(import-macros {: run-solution} :utils)

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
  (let [matrix (convert-to-matrix text)]
    (each [a aisle (ipairs matrix)]
      (each [b tile (ipairs aisle)]
        (if (= tile "@")
          (if (is-forklift-accessable? matrix a b)
              (set part1 (+ part1 1)))))))
  (values part1 part2))

(run-solution parse-line)
