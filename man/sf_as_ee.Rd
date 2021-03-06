% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sf_as_ee.R
\name{sf_as_ee}
\alias{sf_as_ee}
\alias{sf_as_ee.character}
\alias{sf_as_ee.sf}
\alias{sf_as_ee.sfc}
\alias{sf_as_ee.sfg}
\title{Convert an sf object to EE object}
\usage{
sf_as_ee(x, check_ring_dir)

\method{sf_as_ee}{character}(x, check_ring_dir = FALSE, ...)

\method{sf_as_ee}{sf}(x, check_ring_dir = FALSE)

\method{sf_as_ee}{sfc}(x, check_ring_dir = FALSE)

\method{sf_as_ee}{sfg}(x, check_ring_dir = FALSE)
}
\arguments{
\item{x}{sf object to be converted into a EE object.}

\item{check_ring_dir}{logical. See \link[sf]{st_read} and details.}

\item{...}{\link[sf]{st_read} arguments might be included.}
}
\description{
Convert an sf object to EE object
}
\details{
The conversion from sf to EE is a two-step process. First,
\code{sf_as_ee} transform sf objects into a GeoJSON format using
\link[geojsonio]{geojson_json}. Second, the GeoJSON generated will be
encrusted in an HTTP request using the server-side objects (ee$Geometry$*).
If the sf object is a large spatial object (>1Mb) it is likely to cause
bottlenecks and plodding connections. See
\href{https://developers.google.com/earth-engine/client_server}{Client
vs Server} documentation for more details. For dealing with very large spatial
objects, it is recommended to import it into the GEE asset. See
\link[rgee]{ee_upload} for creating uploaded pipelines.

Earth Engine is strict on polygon ring directions (outer ring
counter-clockwise, and the inner one clockwise). If \code{check_ring_dir} is TRUE,
it check every ring, and revert them if necessary, to counter clockwise for outer,
and clockwise for inner (hole) ones. By default this is FALSE because
it is an expensive operation.
}
\examples{
library(rgee)
library(sf)

ee_reattach() # reattach ee as a reserved word
ee_Initialize()

# sf
x <- st_read(system.file("shape/nc.shp", package = "sf")) \%>\%
  st_transform(4326)
ee_x <- sf_as_ee(x, check_ring_dir = TRUE)
ee_map(ee_x)
}
