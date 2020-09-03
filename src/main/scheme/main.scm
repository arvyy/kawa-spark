; delete this file if this artifact should be a library and not final application
(import (scheme base)
        (scheme write)
        (arvyy kawa-spark))

(get "/hello" (lambda (req res) (string-append "Hello ," (string-join 
                                                           (map 
                                                           Object:toString
                                                           (req/attributes req)
                                                           )
                                                           ))))
