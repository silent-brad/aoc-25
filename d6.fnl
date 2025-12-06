;; Day 6: Trash Compactor
(import-macros {: run-solution} :utils)

(fn parse-text [text]
  (var part1 0)
  (var part2 0)

  (var matrix [])
  (var operations [])
  (var (_ line-count) (text:gsub "\n" ""))
  (var first-line (text:match "[^\n]+"))
  ;; (var (_ number-count) (first-line:gsub "%S+" ""))
  (var i 1)
  (each [line (text:gmatch "[^\n]+")]
    (var j 1)
    (each [number (line:gmatch "%S+")]
      (if (= i line-count)
          (table.insert operations number)
          (= i 1)
          (table.insert matrix [(tonumber number)])
          (tset matrix j i (tonumber number)))
      (set j (+ j 1)))
    (set i (+ i 1)))
 
    (each [k numbers (pairs matrix)]
      (var total 0)
      ;; Use accumulate
      (if (= (. operations k) "+")
        (each [_ number (pairs numbers)]
          (set total (+ total number)))
        (do
          (set total 1)
          (each [_ number (pairs numbers)]
            (set total (* total number)))))
      (set part1 (+ part1 total)))

  (values part1 part2))

(run-solution parse-text)
