;; Day 2: Gift Shop

(fn sum-invalid-ids [text]
  (var sum 0)
  (each [range (string.gmatch text "([^,]+)")]
    (let [ids (string.gmatch range "([^-]+)")
          head (tonumber (ids))
          tail (tonumber (ids))]
      (print (.. "head: " head " tail: " tail))))
  100)

(fn solve [filename]
  (let [file (io.open filename "r")]
    (if file
        (let [text (file:read "*a")]
          (file:close)
          (sum-invalid-ids text))
        (error "Could not open file"))))

(print (solve :test.txt))
