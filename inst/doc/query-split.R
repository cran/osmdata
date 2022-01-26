## ----get-bbox, eval = FALSE---------------------------------------------------
#  library(osmdata)
#  
#  bb <- getbb("Southeastern Connecticut COG", featuretype = "boundary")
#  bb

## ----out1, eval = FALSE-------------------------------------------------------
#          min       max
#  x -72.46677 -71.79315
#  y  41.27591  41.75617

## ----bbox-split, eval = FALSE-------------------------------------------------
#  dx <- (bb["x", "max"] - bb["x", "min"]) / 2
#  
#  bbs <- list(bb, bb)
#  
#  bbs[[1]]["x", "max"] <- bb["x", "max"] - dx
#  bbs[[2]]["x", "min"] <- bb["x", "min"] + dx
#  
#  bbs

## ----out2, eval = FALSE-------------------------------------------------------
#  [[1]]
#          min       max
#  x -72.46677 -72.12996
#  y  41.27591  41.75617
#  
#  [[2]]
#          min       max
#  x -72.12996 -71.79315
#  y  41.27591  41.75617

## ----opq-2x, eval = FALSE-----------------------------------------------------
#  res <- list()
#  
#  res[[1]] <- opq(bbox = bbs[[1]]) |>
#          add_osm_feature(key="admin_level", value="8") |>
#          osmdata_sf()
#  res[[2]] <- opq(bbox = bbs[[2]]) |>
#          add_osm_feature(key="admin_level", value="8") |>
#          osmdata_sf()

## ----opq-merge, eval = FALSE--------------------------------------------------
#  res <- c(res[[1]], res[[2]])

## ----bbox-auto-split, eval = FALSE--------------------------------------------
#  split_bbox <- function(bbox, grid = 2) {
#      xmin <- bbox["x", "min"]
#      ymin <- bbox["y", "min"]
#      dx <- (bbox["x", "max"] - bbox["x", "min"]) / grid
#      dy <- (bbox["y", "max"] - bbox["y", "min"]) / grid
#  
#      bboxl <- list()
#  
#      for (i in 1:grid) {
#          for (j in 1:grid) {
#              b <- matrix(c(xmin + ((i-1) * dx),
#                            ymin + ((j-1) * dy),
#                            xmin + (i * dx),
#                            ymin + (j * dy)),
#                          nrow = 2,
#                          dimnames = dimnames(bbox))
#  
#              bboxl <- append(bboxl, list(b))
#          }
#      }
#      bboxl
#  }

## ----bbox-pre-split, eval = FALSE---------------------------------------------
#  bb <- getbb("Connecticut", featuretype = NULL)
#  queue <- split_bbox(bb)
#  result <- list()

## ----auto-query, eval = FALSE-------------------------------------------------
#  while (length(queue) > 0) {
#  
#      print(queue[[1]])
#  
#      opres <- NULL
#      opres <- try({
#                  opq(bbox = queue[[1]], timeout = 25) |>
#                      add_osm_feature(key="natural", value="tree") |>
#                      osmdata_sf()
#                })
#  
#      if (class(opres)[1] != "try-error") {
#          result <- append(result, list(opres))
#          queue <- queue[-1]
#      } else {
#          bboxnew <- split_bbox(queue[[1]])
#          queue <- append(bboxnew, queue[-1])
#      }
#  }

## ----merge-result-list, eval = FALSE------------------------------------------
#  final <- do.call(c, result)

