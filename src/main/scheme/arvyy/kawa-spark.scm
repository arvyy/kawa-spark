(define-library
  (arvyy kawa-spark)
  (import (scheme base)
          (class spark Spark Request Response Session Filter))
  (export 
    ;; path mappings
    get
    post
    put
    delete
    options
    before
    before-all
    after
    after-all
    after-after
    after-after-all
    redirect/get
    redirect/post
    redirect
    path
    
    ;; request
    req/attributes
    req/attribute
    req/set-attribute!
    req/body
    req/body-as-bytes
    req/content-length
    req/content-type
    req/context-path
    req/cookies
    req/cookie
    req/headers
    req/header
    req/host
    req/ip
    req/params
    req/param
    req/path-info
    req/port
    req/protocol
    req/query-params
    req/query-param
    req/query-param-values
    req/raw
    req/request-method
    req/scheme
    req/session
    req/create-session!
    req/splat
    req/uri
    req/url
    req/user-agent
    
    ;; response
    resp/body
    resp/set-body!
    resp/set-header!
    resp/raw
    resp/redirect
    resp/status
    resp/set-status!
    resp/type
    resp/set-type!
    resp/set-cookie!
    resp/remove-cookie!
    
    ;; session
    session/attribute
    session/set-attribute!
    session/remove-attribute!
    session/attributes
    session/id
    session/new?
    session/raw
    
    ;; halt
    halt!
    
    ;; error handling
    not-found
    internal-server-error
    exception
    
    ;; static files
    static-files/location
    static-files/external-location
    static-files/expire-time
    static-files/header
    
    ;; other
    init
    stop
    port
    secure
    thread-pool
    await-initialization
    await-stop)
  
  (begin
    ;; path mappings
    (define get Spark:get)
    (define post Spark:post)
    (define put Spark:put)
    (define delete Spark:delete)
    (define options Spark:options)
    (define (before path ::String handler ::Filter)
      (Spark:before path handler))
    (define (before-all handler ::Filter)
      (Spark:before handler))
    (define (after path ::String handler ::Filter)
      (Spark:after path handler))
    (define (after-all handler ::Filter)
      (Spark:after handler))
    (define (after-after path ::String handler ::Filter)
      (Spark:after-after path handler))
    (define (after-after-all handler ::Filter)
      (Spark:after-after handler))
    (define redirect/get Spark:redirect:get)
    (define redirect/post Spark:redirect:post)
    (define redirect Spark:redirect:any)
    (define-syntax path
      (syntax-rules ()
        ((_ p body ...)
         (Spark:path p (lambda () body ...)))))
    
    ;; request
    (define req/attributes Request:attributes)
    (define (req/attribute req ::Request attr)
      (Request:attribute req attr))
    (define (req/set-attribute! req ::Request attr value)
      (Request:attribute req attr value))
    (define req/body Request:body)
    (define req/body-as-bytes Request:bodyAsBytes)
    (define req/content-length Request:contentLength)
    (define req/content-type Request:contentType)
    (define req/context-path Request:contextPath)
    (define req/cookies Request:cookies)
    (define req/cookie Request:cookie)
    (define (req/headers req ::Request)
      (Request:headers req))
    (define (req/header req ::Request header)
      (Request:headers req header))
    (define req/host Request:host)
    (define req/ip Request:ip)
    (define (req/params req ::Request)
      (Request:params req))
    (define (req/param req ::Request param)
      (Request:params req param))
    (define req/path-info Request:pathInfo)
    (define req/port Request:port)
    (define req/protocol Request:protocol)
    (define (req/query-params req ::Request)
      (Request:queryParams req))
    (define (req/query-param req ::Request param)
      (Request:queryParams req param))
    (define req/query-param-values Request:queryParamsValues)
    (define req/raw Request:raw)
    (define req/request-method Request:requestMethod)
    (define req/scheme Request:scheme)
    (define (req/session req ::Request)
      (Request:session req))
    (define (req/create-session! req ::Request)
      (Request:session req #t))
    (define req/splat Request:splat)
    (define req/uri Request:uri)
    (define req/url Request:url)
    (define req/user-agent Request:userAgent)
    
    ;; response
    (define (resp/body resp ::Response)
      (Response:body resp))
    (define (resp/set-body! resp ::Response body)
      (Response:body resp body))
    (define resp/set-header! Response:header)
    (define resp/raw Response:raw)
    (define resp/redirect Response:redirect)
    (define (resp/status resp ::Response)
      (Response:status resp))
    (define (resp/set-status! resp ::Response status)
      (Response:status resp status))
    (define (resp/type resp ::Response)
      (Response:type resp))
    (define (resp/set-type! resp ::Response type)
      (Response:type resp type))
    (define resp/set-cookie! Response:cookie)
    (define resp/remove-cookie! Response:removeCookie)
    
    ;; session
    (define (session/attribute s ::Session attr)
      (Session:attribute s attr))
    (define (session/set-attribute! s ::Session attr value)
      (Session:attribute s attr value))
    (define session/remove-attribute! Session:removeAttribute)
    (define session/attributes Session:attributes)
    (define session/id Session:id)
    (define session/new? Session:isNew)
    (define session/raw Session:raw)
    
    ;; halt
    (define (halt! code message)
      (Spark:halt code message))

    ;; error handling
    (define not-found Spark:notFound)
    (define internal-server-error Spark:internalServerError)
    (define exception Spark:exception)
    
    ;; static files
    (define static-files/location Spark:staticFiles:location)
    (define static-files/external-location Spark:staticFiles:externalLocation)
    (define static-files/expire-time Spark:staticFiles:expireTime)
    (define static-files/header Spark:staticFiles:header)
    
    ;; other
    (define init Spark:init)
    (define stop Spark:stop)
    (define port Spark:port)
    (define secure Spark:secure)
    (define thread-pool Spark:threadPool)
    (define await-initialization Spark:awaitInitialization)
    (define await-stop Spark:awaitStop)))


