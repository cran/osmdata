% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get-osmdata-sf.R
\name{osmdata_sf}
\alias{osmdata_sf}
\title{Return an OSM Overpass query as an \link{osmdata} object in \pkg{sf}
format.}
\usage{
osmdata_sf(q, doc, quiet = TRUE, stringsAsFactors = FALSE)
}
\arguments{
\item{q}{An object of class \code{overpass_query} constructed with
\link{opq} and \link{add_osm_feature}. May be be omitted,
in which case the \link{osmdata} object will not include the
query.}

\item{doc}{If missing, \code{doc} is obtained by issuing the overpass query,
\code{q}, otherwise either the name of a file from which to read data,
or an object of class \pkg{xml2} returned from
\link{osmdata_xml}.}

\item{quiet}{suppress status messages.}

\item{stringsAsFactors}{Should character strings in 'sf' 'data.frame' be
coerced to factors?}
}
\value{
An object of class \code{osmdata} with the OSM components (points, lines,
and polygons) represented in \pkg{sf} format.
}
\description{
Return an OSM Overpass query as an \link{osmdata} object in \pkg{sf}
format.
}
\examples{
\dontrun{
hampi_sf <- opq ("hampi india") \%>\%
    add_osm_feature (key = "historic", value = "ruins") \%>\%
    osmdata_sf ()
}
}
\seealso{
Other extract: 
\code{\link{osmdata_data_frame}()},
\code{\link{osmdata_sc}()},
\code{\link{osmdata_sp}()},
\code{\link{osmdata_xml}()}
}
\concept{extract}
