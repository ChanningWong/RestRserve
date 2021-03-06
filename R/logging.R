#' @name Logger
#' @title simple logging utility
#' @description creates Logger object which can be used for logging with different level of verbosity.
#' Log messages are in JSON format
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'   \item{\code{$new(level = INFO, name = "ROOT", printer = NULL)}}{Logger with sink defined by \code{printer}
#'   function. It should have signature \code{function(timestamp, level, logger_name, pid, message)}.
#'   By default when \code{printer = NULL} logger writes message in JSON format to \code{stdout}}
#'   \item{\code{$set_name(name = "ROOT")}}{ sets logger name}
#'   \item{\code{$set_log_level(level = INFO)}}{ sets log level}
#'   \item{\code{$set_printer(FUN = NULL)}}{ sets function which defines how to print logs}
#'   \item{\code{$trace(msg, ...)}}{ write trace message}
#'   \item{\code{$debug(msg, ...)}}{ write debug message}
#'   \item{\code{$info(msg, ...)}}{ write info message}
#'   \item{\code{$warning(msg, ...)}}{ write warning message}
#'   \item{\code{$error(msg, ...)}}{ write error message}
#' }
#' @export
#' @examples
#' logger = Logger$new(INFO)
#' logger$info("hello world")
#' logger$info(list(message = "hello world", code = 0L))
Logger = R6::R6Class(
  classname = "Logger",
  public = list(
    printer = NULL,
    #----------------------------------------
    set_name = function(name = "ROOT") {
      private$name = as.character(name)
    },
    #----------------------------------------
    set_log_level = function(level = INFO) {
      private$level = level
    },
    #----------------------------------------
    set_printer = function(FUN = NULL) {
      if(is.null(FUN)) {
        FUN = function(timestamp, level, logger_name, pid, message) {
          x = to_json(
            list(
              timestamp = format(timestamp, "%Y-%m-%d %H:%M:%OS6"),
              level = as.character(level),
              name = as.character(logger_name),
              pid = as.integer(pid),
              message = message
            )
          )
          cat(x, file = "", append = TRUE, sep = "\n")
        }
      }
      if(!is.function(FUN))
        stop("'FUN' should function or NULL")
      if( length(formals(FUN)) != 5L )
        stop("FUN should be a function with 5 formal arguments - (timestamp, level, logger_name, pid, message)")
      self$printer = FUN
    },
    #----------------------------------------
    initialize = function(level = INFO, name = "ROOT", FUN = NULL) {
      self$set_log_level(level)
      self$set_name(name)
      self$set_printer(FUN)
    },
    #----------------------------------------
    trace = function(msg, ...) {
      private$log_base(msg, ..., log_level = TRACE, log_level_tag = "TRACE")
    },
    #----------------------------------------
    debug = function(msg, ...) {
      private$log_base(msg, ..., log_level = DEBUG, log_level_tag = "DEBUG")
    },

    info = function(msg, ...) {
      private$log_base(msg, ..., log_level = INFO, log_level_tag = "INFO")
    },
    #----------------------------------------
    warning = function(msg, ...) {
      private$log_base(msg, ..., log_level = WARN, log_level_tag = "WARN")
    },
    #----------------------------------------
    error = function(msg, ...) {
      private$log_base(msg, ..., log_level = ERROR, log_level_tag = "ERROR")
    },
    #----------------------------------------
    fatal = function(msg, ...) {
      private$log_base(msg, ..., log_level = FATAL, log_level_tag = "FATAL")
    }
  ),
  private = list(
    level = NULL,
    name = NULL,
    log_base = function(msg, ..., log_level, log_level_tag) {
      if(isTRUE(private$level >= log_level)) {
        self$printer(Sys.time(), log_level_tag, private$name, Sys.getpid(), msg)
      }
      invisible(msg)
    }
  )
)

#' @name logging_constants
#' @title log level constants
#' @description log level constants
NULL

#' @rdname logging_constants
#' @export
OFF = 0L

#' @rdname logging_constants
#' @export
FATAL = 1L

#' @rdname logging_constants
#' @export
ERROR = 2L

#' @rdname logging_constants
#' @export
WARN = 4L

#' @rdname logging_constants
#' @export
INFO = 6L

#' @rdname logging_constants
#' @export
DEBUG = 8L

#' @rdname logging_constants
#' @export
TRACE = 9L
