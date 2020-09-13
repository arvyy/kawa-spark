(define-library
  (test-util)
  (import 
    (scheme base)
    (srfi 64)
    (class org.apache.http.client.fluent Request Response Content Form)
    (class org.apache.http.entity ContentType))
  (export test-req)
  (begin
    (define (test-req req ::Request expected-result)
      (let* ((resp (req:execute))
             (content (resp:returnContent))
             (response-string (content:asString)))
        (cond
          ((string? expected-result)
           (test-equal expected-result response-string))
          ((procedure? expected-result)
           (expected-result response-string))
          (else (error "Bad expected-result type")))))))
