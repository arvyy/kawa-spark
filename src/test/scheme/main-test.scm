(import (scheme base)
        (arvyy kawa-spark)
        (srfi 64))

(define success #t)
(test-begin "Kawa-Spark test")

(test-group 
  "Mapping test"
  (include "mapping-test.scm"))

(test-group
  "Request method test"
  (include "request-test.scm"))

;; these are needed for the application to return non-0 on test failures
;; so that on maven side we can abort execution.
(set! success (= 0 (test-runner-fail-count (test-runner-get))))
(test-end)
(exit success)
