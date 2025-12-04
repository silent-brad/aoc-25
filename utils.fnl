{:run-solution (fn [function]
                `(let [filename# (. [...] 1)
                       file# (io.open filename# "r")]
                  (var p1# 0)
                  (var p2# 0)
                  (if file#
                      (let [text# (file#:read "*a")]
                        (file#:close)
                        (let [(sum1# sum2#) (,function text#)]
                          (set p1# (+ p1# sum1#))
                          (set p2# (+ p2# sum2#))))
                      (error "Could not open file"))
                   (print "Part 1:" (string.format "%.16g" p1#))
                   (print "Part 2:" (string.format "%.16g" p2#))))}
