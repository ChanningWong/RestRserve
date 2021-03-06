% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RestRserveApplication.R
\docType{data}
\name{RestRserveApplication}
\alias{RestRserveApplication}
\title{Creates RestRserveApplication.}
\format{\code{\link{R6Class}} object.}
\usage{
RestRserveApplication
}
\description{
Creates RestRserveApplication object.
RestRserveApplication converts user-supplied R code into high-performance REST API by
allowing to easily register R functions for handling http-requests.
}
\section{Fields}{

\describe{
\item{\code{logger}}{\link{Logger} instance. Can be replaced/manipulated with corresponding
\link{Logger} methods.}
}}

\section{Usage}{


\bold{For usage details see Methods, Arguments and Examples sections.}

\itemize{
\item \code{app = RestRserveApplication$new()}
\item \code{app$add_route(path = "/echo", method = "GET", FUN =  function(request, response) {
  response$body = request$query[[1]]
  response$content_type = "text/plain"
  forward()
  })}
\item \code{app$routes()}
}
}

\section{Methods}{

\describe{
  \item{\code{$new(middleware = list(),content_type = "application/json", ...)}}{
    Constructor for RestRserveApplication. Sets \code{middleware} ( list of \link{RestRserveMiddleware})
    and \code{content_type} - default response format.}
  \item{\code{$add_route(path, method, FUN, ...)}}{ Adds endpoint
  and register user-supplied R function as a handler.
  User function \code{FUN} \bold{must} take two arguments: first is \code{request} and second is \code{response}.
  The goal of the user function is to \bold{modify} \code{response} and call \code{RestRserve::forward()} at the end.
  (which means return \code{RestRserveForward} object).
  Both \code{response} and \code{request} objects modified in-place and internally passed further to
  RestRserve execution pipeline.}
  \item{\code{$add_get(path, FUN, ...)}}{shorthand to \code{add_route} with \code{GET} method }
  \item{\code{$add_post(path, FUN, ...)}}{shorthand to \code{add_route} with \code{POST} method }
  \item{\code{$add_static(path, file_path, content_type = NULL, ...)}}{ adds GET method to serve
  file or directory at \code{file_path}. If \code{content_type = NULL}
  then MIME code \code{content_type}  will be inferred automatically (from file extension).
  If it will be impossible to guess about file type then \code{content_type} will be set to
  \code{"application/octet-stream"}}
  \item{\code{$run(http_port = 8001L, ..., background = FALSE)}}{starts RestRserve application from current R session.
     \code{http_port} - http port for application. Negative values (such as -1) means not to expose plain http.
     \code{...} - key-value pairs of the Rserve configuration. If contains \code{"http.port"} then
       \code{http_port} will be silently replaced with its value.
     \code{background} - whether to try to launch in background process on UNIX systems. Ignored on windows.}
  \item{\code{$call_handler(request)}}{Used internally, usually \bold{users don't need to call it}.
  Calls handler function for a given request.}
  \item{\code{$routes()}}{Lists all registered routes}
  \item{\code{$print_endpoints_summary()}}{Prints all the registered routes with allowed methods}
  \item{\code{$add_openapi(path = "/openapi.yaml", openapi = openapi_create())}}{Adds endpoint
  to serve \href{https://www.openapis.org/}{OpenAPI} description of available methods.}
  \item{\code{$add_swagger_ui(path = "/swagger", path_openapi = "/openapi.yaml",
                              path_swagger_assets = "/__swagger__/",
                              file_path = tempfile(fileext = ".html"))}}{Adds endpoint to show swagger-ui.}
}
}

\section{Arguments}{

\describe{
 \item{app}{A \code{RestRserveApplication} object}
 \item{path}{\code{character} of length 1. Should be valid path for example \code{'/a/b/c'}.
 If it is named character vector with name equal to \code{"prefix"} then all the endopoints which
 begin with the path will call corresponding handler.}
 \item{method}{\code{character} of length 1. At the moment one of
   \code{("GET", "HEAD", "POST", "PUT", "DELETE", "OPTIONS", "PATCH")}}
 \item{FUN}{\code{function} which \strong{must take 2 arguments - \code{request}, \code{response} objects}.
   See \link{RestRserveRequest} and \link{RestRserveResponse} for details.
 }
}
}

\keyword{datasets}
