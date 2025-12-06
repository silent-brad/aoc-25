;; Day 6: Trash Compactor
(import-macros {: run-solution} :utils)

(fn parse-text [text]
  (var part1 0)
  (var part2 0)

  (let [lines (icollect [line (text:gmatch "[^\n]+")]
                 line)]
    
    ;; Split input into columns by finding space-separated blocks
    (var tokens [])
    (each [row line (ipairs lines)]
      (table.insert tokens [])
      (each [token (string.gmatch line "%S+")]
        (table.insert (. tokens row) token)))
    
    ;; Find number of columns by checking the operations row (last row)
    (let [ops-row (. tokens (length tokens))
          num-cols (length ops-row)]
      
      ;; Process each column
      (for [col 1 num-cols]
        (var numbers [])
        (var operation nil)
        
        ;; Extract numbers and operation from this column
        (for [row 1 (length tokens)]
          (let [token-row (. tokens row)
                token (. token-row col)]
            (when token
              (if (or (= token "+") (= token "*"))
                  (set operation token)
                  (let [num (tonumber token)]
                    (when num
                      (table.insert numbers num)))))))
        
        ;; Calculate result for this column
        (when (and (> (length numbers) 0) operation)
          (var result (. numbers 1))
          (for [i 2 (length numbers)]
            (let [num (. numbers i)]
              (set result (if (= operation "+")
                            (+ result num)
                            (* result num)))))
          (set part1 (+ part1 result))))))

  (values part1 part2))

(run-solution parse-text)
