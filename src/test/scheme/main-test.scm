(import (scheme base)
        (mapping-test)
        (request-test)
        (response-test)
        (session-test)
        (srfi 64))

(test-begin "Kawa-Spark test")

;; on test end exit with non-zero status if there were failures
(let* ((runner (test-runner-current))
       (callback (test-runner-on-final runner)))
  (test-runner-on-final!
    runner
    (lambda (r)
      (callback r)
      (exit (= 0 (test-runner-fail-count r))))))

(test-group 
  "Mapping test"
  (do-mapping-test))

(test-group
  "Request methods test"
  (do-request-test))

(test-group
  "Response methods test"
  (do-response-test))

(test-group
  "Session methods test"
  (do-session-test))

(test-end)
