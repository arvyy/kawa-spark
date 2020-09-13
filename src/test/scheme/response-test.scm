(define-library
  (response-test)
  (export do-response-test)
  (import 
    (scheme base)
    (scheme write)
    (srfi 64)
    (srfi 95) ;sort
    (arvyy kawa-spark)
    (test-util)
    (class org.apache.http.client.fluent Request Response Content Form)
    (class org.apache.http.entity ContentType))
  (begin
    (define (do-response-test)
      (port 8080)
     
      (before "/body"
              (lambda (req resp)
                (resp/set-body! resp "foo")))
      (get "/body"
           (lambda (req resp)
             (resp/body resp)))
      
      (test-req (Request:Get "http://localhost:8080/body") "foo")
      
      (stop)
      (await-stop))))
