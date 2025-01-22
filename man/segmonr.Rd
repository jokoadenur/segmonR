\name{segmonr}
\alias{segmonr}
\title{Create a Segmented Motion Pie Chart}
\description{
Generates a segmented motion pie chart plot with customizable labels, percentages, and colors.
}
\usage{
segmonr(data, color = NULL)
}
\arguments{
  \item{data}{
  A \code{data.frame} containing at least two columns:
  \itemize{
    \item \code{text}: Labels for the segments.
    \item \code{value}: Numerical values representing the size of each segment.
  }
  Optionally, the \code{data} can include a \code{color} column to specify custom colors for each segment.
  }

  \item{color}{
  An optional vector of colors for the segments. If \code{NULL}, colors will be automatically generated or taken from the \code{color} column in \code{data} (if available).
  }
}
\value{
A \code{ggplot} object representing the segmented radial plot.
}

\author{
Joko Ade Nursiyono
}
\keyword{visualization}
\keyword{plot}
