(import (scheme base)
        (mapping-test)
        (request-test)
        (response-test)
        (srfi 64))

(define success #t)
(test-begin "Kawa-Spark test")

(test-group 
  "Mapping test"
  (do-mapping-test))

(test-group
  "Request methods test"
  (do-request-test))

(test-group
  "Response methods test"
  (do-response-test))

;; these are needed for the application to return non-0 on test failures
;; so that on maven side we can abort execution.
(set! success (= 0 (test-runner-fail-count (test-runner-get))))
(test-end)
(exit success)
