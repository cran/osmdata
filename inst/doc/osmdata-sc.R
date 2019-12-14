## ----omaha, eval = FALSE------------------------------------------------------
#  dat <- opq ("omaha nebraska") %>%
#      add_osm_feature (key = "highway") %>%
#      osmdata_sc ()

## ----dat_vertex, eval = FALSE-------------------------------------------------
#  dat$vertex

## ----dat_vertex_dat, echo = FALSE---------------------------------------------
n <- 345239
x_ <- c (-95.9, -95.9, -95.9, -95.9, -95.9, -95.9, -96.2, -96.2, -96.3, -96.3)
y_ <- c (41.2, 41.2, 41.2, 41.2, 41.2, 41.2, 41.3, 41.3, 41.3, 41.3)
z_ <- c (291.0, 295.0, 297.0, 301.0, 295.0, 300.0, 359.0, 359.0, 358.0, 358.0)
vertex_ <- paste0 (c (31536366, 31536367, 31536368, 31536370, 31536378, 31536379,
                      133898322, 133898328, 133898340, 133898342))

tibble::tibble (x_ = c (x_, rep (NA, n - 10)),
                y_ = c (y_, rep (NA, n - 10)),
                vertex_ = c (vertex_, rep (NA, n - 10)))

## ----osm_elevation, eval = FALSE----------------------------------------------
#  dat <- osm_elevation (dat, elev_file = "/path/to/elevation/data/filename.tiff")

## ----osm_elevation2, echo = FALSE---------------------------------------------
message ("Loading required namespace: raster\n",
         "Elevation data from Consortium for Spatial Information; see ",
         "http://srtm.csi.cgiar.org/srtmdata/")

## ----dat_vertex2, eval = FALSE------------------------------------------------
#  dat$vertex_

## ---- dat_vertex_dat2, echo = FALSE-------------------------------------------
tibble::tibble (x_ = c (x_, rep (NA, n - 10)),
                y_ = c (y_, rep (NA, n - 10)),
                z_ = c (z_, rep (NA, n - 10)),
                vertex_ = c (vertex_, rep (NA, n - 10)))

## ----edges, eval = FALSE------------------------------------------------------
#  edges <- dplyr::left_join (dat$edge, dat$vertex, by = c (".vx0" = "vertex_")) %>%
#      dplyr::rename (".vx0_x" = x_, ".vx0_y" = y_, ".vx0_z" = z_) %>%
#      dplyr::left_join (dat$vertex, by = c (".vx1" = "vertex_")) %>%
#      dplyr::rename (".vx1_x" = x_, ".vx1_y" = y_, ".vx1_z" = z_) %>%
#      dplyr::mutate ("zmn" = (.vx0_z + .vx1_z) / 2) %>%
#      dplyr::select (-c (.vx0_z, .vx1_z))
#  edges

## ----edges-dat, echo = FALSE--------------------------------------------------
n <- 376370
x <- paste0 (c (1903265686, 1903265664, 1903265638, 1903265710, 1903265636,
                 1903265685, 1903265678, 1903265646, 1903265714, 1903265659))
y <- paste0 (c (1903265664, 1903265638, 1903265710, 1903265636, 1903265685,
                1903265678, 1903265646, 1903265714, 1903265659, 1903265702))
edge <- c ("V6kgqvWjtM", "mX4HQkykiD", "26e5NHT8nI", "9TOmVAvGH4", "hYbpf832vX",
           "ctvd1FWGEw", "mvaAOdSOKA", "dSVFPNDFty", "uc8L3jGR87", "MpjXnvIvcF")
x0_x <- c (-96.2, -96.2, -96.2, -96.2, -96.2, -96.2, -96.2, -96.2, -96.2, -96.2)
x0_y <- c (41.3, 41.3, 41.3, 41.3, 41.3, 41.3, 41.3, 41.3, 41.3, 41.3)
x1_x <- c (-96.2, -96.2, -96.2, -96.2, -96.2, -96.2, -96.2, -96.2, -96.2, -96.2)
x1_y <- c (41.3, 41.3, 41.3, 41.3, 41.3, 41.3, 41.3, 41.3, 41.3, 41.3)
z <- c (351.0, 352.0, 352.0, 352.0, 352.0, 352.0, 352.0, 352.0, 352.0, 352.0)

tibble::tibble (".vx0" = c (x, rep (NA, n - 10)),
                ".vx1" = c (y, rep (NA, n - 10)),
                "edge_" = c (edge, rep (NA, n - 10)),
                ".vx0_x" = c (x0_x, rep (NA, n - 10)),
                ".vx0_y" = c (x0_y, rep (NA, n - 10)),
                ".vx1_x" = c (x1_x, rep (NA, n - 10)),
                ".vx1_y" = c (x1_y, rep (NA, n - 10)),
                "zmn" = c (z, rep (NA, n - 10)))

## ---- eval = FALSE------------------------------------------------------------
#  library (mapdeck)
#  set_token (Sys.getenv ("MAPBOX_TOKEN")) # load local token for MapBox
#  mapdeck (style = mapdeck_style ("dark")) %>%
#      add_line (edges,
#                origin = c (".vx0_x", ".vx0_y"),
#                destination = c (".vx1_x", ".vx1_y"),
#                stroke_colour = "z",
#                legend = TRUE)

