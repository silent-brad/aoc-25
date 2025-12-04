;; Day 4: Printing Department
(import-macros {: run-solution} :utils)

(fn is-forklift-accessable? [text a b]
  (let [aisles (text:match "[^\n]+")
        ;;tiles (aisles)]
        ]
    (print aisles)))
    ;;(each [aisle (ipairs aisles)]
    ;;  (print aisle))))

;; Converts text to a 2x2 table matrix
;; [["." "@" "." ...] ["@" "@" "."] ...]
(macro convert-to-matrix [text]
  `(let [matrix# []]
     (each [line# (text:gmatch "[^\n]+")]
       (var inner-table# [])
       (each [tile# (line#:gmatch "(.)")]
         (print tile#)
         ;(table.insert inner-table# tile#)
         (table.insert matrix# (string.sub tile# 1))))
     matrix#))

(fn parse-line [text]
  (var part1 0)
  (var part2 0)
  (var a 0)
  (var b 0)
  
  (let [matrix (convert-to-matrix text)]
    (print (length matrix)))

  ;;(each [aisle (text:gmatch "[^\n]+")]
  ;;  (each [tile (aisle:gmatch "(.)")]
   ;;   ;;(print tile a b)
    ;;  (print (is-forklift-accessable? text a b))
     ;; (set b (+ b 1)))
    ;;(set a (+ a 1)))
  (values part1 part2))

(run-solution parse-line)
