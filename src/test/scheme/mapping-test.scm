(define-library
  (mapping-test)
  (import 
    (scheme base)
    (scheme write)
    (srfi 64)
    (test-util)
    (arvyy kawa-spark)
    (class org.apache.http.client.fluent Request Response Content Form)
    (class org.apache.http.entity ContentType))
  (export do-mapping-test)
  
  (begin
    (define (do-mapping-test)

      (port 8080)

      (get "/a" (lambda (req resp) 
                  (resp/set-type! resp "text/plain; charset=utf-8")
                  "a-get"))

      (put "/a" (lambda (req resp)
                  (resp/set-type! resp "text/plain; charset=utf-8")
                  "a-put"))

      (post "/a" (lambda (req resp)
                   (resp/set-type! resp "text/plain; charset=utf-8")
                   "a-post"))

      (delete "/a" (lambda (req resp)
                     (resp/set-type! resp "text/plain; charset=utf-8")
                     "a-delete"))

      (options "/a" (lambda (req resp)
                      (resp/set-type! resp "text/plain; charset=utf-8")
                      "a-options"))

      (path "/a"
            (get "/subpath" (lambda (req resp)
                              (resp/set-type! resp "text/plain; charset=utf-8")
                              "a-subpath-get")))

      (get "/a-before1" (lambda (req resp)
                          (resp/set-type! resp "text/plain; charset=utf-8")
                          ""))

      (get "/a-before2" (lambda (req resp)
                          (resp/set-type! resp "text/plain; charset=utf-8")
                          ""))

      (get "/a-after1" (lambda (req resp)
                         (resp/set-type! resp "text/plain; charset=utf-8")
                         ""))

      (get "/a-after2" (lambda (req resp)
                         (resp/set-type! resp "text/plain; charset=utf-8")
                         ""))

      (get "/a-after3" (lambda (req resp)
                         (resp/set-type! resp "text/plain; charset=utf-8")
                         ""))

      (get "/a-after4" (lambda (req resp)
                         (resp/set-type! resp "text/plain; charset=utf-8")
                         ""))

      (redirect/get "/a-redirect-get" "/a")
      (redirect/post "/a-redirect-post" "/a")
      (redirect "/a-redirect-any" "/a")

      (before "/a-before1" (lambda (req resp)
                             (resp/set-type! resp "text/plain; charset=utf-8")
                             (halt! 200 "a-before1")))

      (before-all (lambda (req resp)
                    (when (equal? (req/url req) "http://localhost:8080/a-before2")
                      (resp/set-type! resp "text/plain; charset=utf-8")
                      (halt! 200 "a-before2"))))

      (after "/a-after1" (lambda (req resp)
                           (resp/set-type! resp "text/plain; charset=utf-8")
                           (resp/set-body! resp "a-after1")))

      (after-all (lambda (req resp)
                   (when (equal? (req/url req) "http://localhost:8080/a-after2")
                     (resp/set-type! resp "text/plain; charset=utf-8")
                     (resp/set-body! resp "a-after2"))))

      (after-after "/a-after3" (lambda (req resp)
                                 (resp/set-type! resp "text/plain; charset=utf-8")
                                 (resp/set-body! resp "a-after3")))

      (after-after-all (lambda (req resp)
                         (when (equal? (req/url req) "http://localhost:8080/a-after4")
                           (resp/set-type! resp "text/plain; charset=utf-8")
                           (resp/set-body! resp "a-after4"))))

      (await-initialization)

      (test-req (Request:Get "http://localhost:8080/a") "a-get")
      (test-req (Request:Put "http://localhost:8080/a") "a-put")
      (test-req (Request:Post "http://localhost:8080/a") "a-post")
      (test-req (Request:Delete "http://localhost:8080/a") "a-delete")
      (test-req (Request:Options "http://localhost:8080/a") "a-options")
      (test-req (Request:Get "http://localhost:8080/a/subpath") "a-subpath-get")
      (test-req (Request:Get "http://localhost:8080/a-before1") "a-before1")
      (test-req (Request:Get "http://localhost:8080/a-before2") "a-before2")
      (test-req (Request:Get "http://localhost:8080/a-after1") "a-after1")
      (test-req (Request:Get "http://localhost:8080/a-after2") "a-after2")
      (test-req (Request:Get "http://localhost:8080/a-after3") "a-after3")
      (test-req (Request:Get "http://localhost:8080/a-after4") "a-after4")
      (test-req (Request:Get "http://localhost:8080/a-redirect-get") "a-get")
      ;TODO returns 302 and throws exception
      ;(test-req (Request:Post "http://localhost:8080/a-redirect-post") "a-post")
      (test-req (Request:Get "http://localhost:8080/a-redirect-any") "a-get")


      (stop)
      (await-stop))))

