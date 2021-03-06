% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/start.R
\name{restrserve_start}
\alias{restrserve_start}
\title{starts RestRserve application}
\usage{
restrserve_start(dir, debug = FALSE, ...)
}
\arguments{
\item{dir}{character, path to the directory where application was deployed}

\item{debug}{logical, \code{FALSE} by default. Whether to start \link{Rserve} in debug mode.}

\item{...}{other parameters to \link{Rserve} call}
}
\value{
named integer. Value is a PID of the Rserve daemon. Name is a path to a file where PID is stored.
After start Rserve creates a file with its PID. By default tt is called "Rserve.pid" and created inside \code{dir}.
This could be specified in \link{restrserve_deploy} during application deployment.
}
\description{
Assuming that RserveApplication is deployed to a \code{dir},
\code{restrserve_start} starts Rserve from it. Application "deployed" means that
directory contains \code{Rserve.conf} file which has been generated with
\link{restrserve_deploy} function
}
