## ---- eval = FALSE-------------------------------------------------------
#  install.packages("osmdata")

## ------------------------------------------------------------------------
library(osmdata)

## ----install, eval = FALSE-----------------------------------------------
#  devtools::install_github('osmdatar/osmdata')

## ---- message = FALSE----------------------------------------------------
require (magrittr)

## ----opq1----------------------------------------------------------------
q <- opq(bbox = c(51.1, 0.1, 51.2, 0.2))

## ----opq2, eval = FALSE--------------------------------------------------
#  q <- opq(bbox = 'Greater London, U.K.')
#  identical(opq(bbox = 'Greater London, U.K.'), opq(bbox = 'greater london uk'))

## ----echo = FALSE--------------------------------------------------------
TRUE

## ----opq3, eval = FALSE--------------------------------------------------
#  q <- opq(bbox = 'greater london uk') %>%
#      add_feature(key = 'highway', value = 'motorway')

## ---- echo = FALSE-------------------------------------------------------
q <- opq (bbox = c (51.2867602, -0.510375, 51.6918741, 0.3340155)) %>%
    add_feature(key = 'highway', value = 'motorway')

## ----features, eval = FALSE----------------------------------------------
#  head (available_features ())

## ---- echo = FALSE-------------------------------------------------------
c ("4wd only", "abandoned", "abutters", "access", "addr", "addr:city")

## ---- eval=TRUE----------------------------------------------------------
opq_string(q)

## ---- eval=TRUE----------------------------------------------------------
## [out:xml][timeout:25];
## (
##   node
##     ["highway"="motorway"]
##     (51.2867602,-0.510375,51.6918741,0.3340155);
##   way  
##     ["highway"="motorway"]
##     (51.2867602,-0.510375,51.6918741,0.3340155);
##   relation  
##     ["highway"="motorway"]
##     (51.2867602,-0.510375,51.6918741,0.3340155);
## );
## (._;>);out body;

## ---- eval = FALSE-------------------------------------------------------
#  set_overpass_url ('http://overpass.osm.rambler.ru/cgi/interpreter')

## ----kunming1, eval = FALSE----------------------------------------------
#  q <- opq(bbox = 'Kunming, China') %>%
#      add_feature(key = 'natural', value = 'water')

## ----kunming2, eval = FALSE----------------------------------------------
#  q <- opq(bbox = 'Kunming, China') %>%
#      add_feature(key = 'natural', value = 'water') %>%
#      add_feature(key = 'name:en', value = 'Dian', value_exact = FALSE)

## ---- echo = FALSE-------------------------------------------------------
q <- opq(bbox = c(102.5417638, 24.8915153, 102.8617638, 25.2115153)) %>%
    add_feature(key = 'natural', value = 'water') %>%
    add_feature(key = 'name:en', value = 'Dian', value_exact = FALSE)

## ----kunming3, eval = FALSE----------------------------------------------
#  dat1 <- opq(bbox = 'Kunming, China') %>%
#      add_feature(key = 'natural', value = 'water') %>%
#      osmdata_sf ()
#  dat2 <- opq(bbox = 'Kunming, China') %>%
#      add_feature(key = 'name:en', value = 'Dian', value_exact = FALSE) %>%
#      osmdata_sf ()
#  dat <- c (dat1, dat2)

## ---- eval = FALSE-------------------------------------------------------
#  unlist (lapply (dat1, nrow) [4:8])
#  unlist (lapply (dat2, nrow) [4:8])
#  unlist (lapply (dat, nrow) [4:8])

## ---- echo = FALSE-------------------------------------------------------
dat1 <- c (7373, 31, 118, 0, 10)
dat2 <- c (2254, 30, 2, 0, 1)
dat <- c (7590, 46, 119, 0, 10)
names (dat1) <- names (dat2) <- names (dat) <- c ('osm_points', 'osm_lines',
                                                  'osm_polygons',
                                                  'osm_multilines',
                                                  'osm_multipolygons')
dat <- dat [c (1:3, 5)]
dat1
dat2
dat

## ---- eval = FALSE-------------------------------------------------------
#  unlist (lapply (osmdata_sf (q), nrow) [4:8])

## ---- echo = FALSE-------------------------------------------------------
dat <- c (2029, 15, 1, 0, 1)
names (dat1) <- names (dat2) <- names (dat) <- c ('osm_points', 'osm_lines',
                                                  'osm_polygons',
                                                  'osm_multilines',
                                                  'osm_multipolygons')
dat

## ----kunming4, eval = FALSE----------------------------------------------
#  q <- opq(bbox = 'Kunming, China') %>%
#      add_feature(key = 'natural', value = 'water') %>%
#      add_feature(key = 'name:en', value = 'Dian', value_exact = FALSE)

## ---- eval = FALSE-------------------------------------------------------
#  q <- opq(bbox = 'Kunming, China') %>%
#      add_feature(key = 'natural', value = 'water') %>%
#      add_feature(key = 'name', value = 'dian', key_exact = FALSE,
#                  value_exact = FALSE, match_case = FALSE)

## ---- eval = FALSE-------------------------------------------------------
#  osmdata_sf(opq_string(q))

## ---- echo = FALSE-------------------------------------------------------
message (paste (
"Object of class 'osmdata' with:\n",
"                 $bbox :\n",
"        $overpass_call : The call submitted to the overpass API\n",
"            $timestamp : [ Thurs 5 May 2017 14:33:54 ]\n",
"           $osm_points : 'sf' Simple Features Collection with 360582 points\n",
"           ..."))

## ---- eval = FALSE-------------------------------------------------------
#  lots_of_data <- opq(bbox = 'City of London, U.K.') %>% osmdata_sf()

## ----opq-london, eval = FALSE--------------------------------------------
#  not_so_much_data <- opq(bbox = 'city of london uk') %>%
#      add_feature(key = 'highway') %>%
#      add_feature(key = 'name') %>%
#      osmdata_sf()

## ----opq-seville-plot, eval = FALSE--------------------------------------
#  q1 <- opq('Seville') %>%
#      add_feature(key = 'highway', value = 'cycleway')
#  cway_sev <- osmdata_sp(q1)
#  sp::plot(cway_sev$osm_lines)

## ----des-bike1, eval = FALSE---------------------------------------------
#  q2 <- add_feature(q1, key = 'bicycle', value = 'designated')
#  des_bike <- osmdata_sf(q2)
#  q3 <- add_feature(q2, key = 'bridge', value = 'yes')
#  des_bike_and_bridge <- osmdata_sf(q3)
#  nrow(des_bike_and_bridge$osm_points); nrow(des_bike_and_bridge$osm_lines)

## ---- echo = FALSE-------------------------------------------------------
7; 3

## ---- des-bike2, eval = FALSE--------------------------------------------
#  q4 <- add_feature(q1, key = 'bridge', value = 'yes')
#  bridge <- osmdata_sf(q4)
#  des_bike_or_bridge <- c(des_bike, bridge)
#  nrow(des_bike_or_bridge$osm_points); nrow(des_bike_or_bridge$osm_lines)

## ---- echo = FALSE-------------------------------------------------------
208; 40

## ---- eval = FALSE-------------------------------------------------------
#  bridge

## ---- echo = FALSE-------------------------------------------------------
message (paste (
"  Object of class 'osmdata' with:\n",
"                   $bbox : 37.3002036,-6.0329182,37.4529579,-5.819157\n",
"          $overpass_call : The call submitted to the overpass API\n",
"              $timestamp : [ Thurs 5 May 2017 14:41:19 ]\n",
"             $osm_points : 'sf' Simple Features Collection with 69 points\n",
"              $osm_lines : 'sf' Simple Features Collection with 25 linestrings\n", #nolint
"           $osm_polygons : 'sf' Simple Features Collection with 0 polygons\n",
"         $osm_multilines : 'sf' Simple Features Collection with 0 multilinestrings\n", #nolint
"      $osm_multipolygons : 'sf' Simple Features Collection with 0 multipolygons")) #nolint

## ----osmdata_with_files3a, eval = FALSE----------------------------------
#  class(osmdata_sf(q)$osm_lines)

## ---- echo = FALSE-------------------------------------------------------
c( "sf", "data.frame")

## ----osmdata_with_files3b, eval = FALSE----------------------------------
#  class(osmdata_sp(q)$osm_lines)

## ---- echo = FALSE-------------------------------------------------------
message (paste (
" [1] \"SpatialLinesDataFrame\"\n",
"attr(,\"package\")\n",
"[1] \"sp\""))

## ----osmdata_xml-london-buildings, eval = FALSE--------------------------
#  dat <- opq(bbox = c(-0.12, 51.51, -0.11, 51.52)) %>%
#      add_feature(key = 'building') %>%
#      osmdata_xml(file = 'buildings.osm')
#  class(dat)

## ---- echo = FALSE-------------------------------------------------------
c ("xml_document", "xml_node")

## ----osmdata_with_files, eval = FALSE------------------------------------
#  q <- opq(bbox = c(-0.12, 51.51, -0.11, 51.52)) %>%
#      add_feature(key = 'building')
#  doc <- osmdata_xml(q, 'buildings.osm')
#  dat1 <- osmdata_sf(q, doc)
#  dat2 <- osmdata_sf(q, 'buildings.osm')
#  identical(dat1, dat2)

## ---- echo = FALSE-------------------------------------------------------
TRUE

## ---- eval = FALSE-------------------------------------------------------
#  readLines('buildings.osm')[1:6]

## ---- echo = FALSE-------------------------------------------------------
message (paste (
' [1] "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"\n',
'[2] "<osm version=\"0.6\" generator=\"Overpass API\">"\n',
'[3] "  <note>The data included in this document is from www.openstreetmap.org. The data is made available under ODbL.</note>"\n', #nolint
'[4] "  <meta osm_base=\"2017-03-07T09:28:03Z\"/>"\n', #nolint
'[5] "  <node id=\"21593231\" lat=\"51.5149566\" lon=\"-0.1134203\"/>"\n', #nolint
'[6] "  <node id=\"25378129\" lat=\"51.5135870\" lon=\"-0.1115193\"/>"')) #nolint

## ---- eval = FALSE-------------------------------------------------------
#  dat_sp <- osmdata_sp(q, 'buildings.osm')
#  dat_sf <- osmdata_sf(q, 'buildings.osm')

## ----trentham, eval = FALSE----------------------------------------------
#  opq(bbox = 'Trentham, Australia') %>%
#      add_feature(key = 'name') %>%
#      osmdata_xml(filename = 'trentham.osm')

## ----sf1, eval = FALSE---------------------------------------------------
#  sf::st_read('trentham.osm', layer = 'points')

## ---- echo = FALSE-------------------------------------------------------
message (paste0 (
" Reading layer `points' from data source `trentham.osm' using driver `OSM'\n",
" Simple feature collection with 38 features and 10 fields\n",
" geometry type:  POINT\n",
" dimension:      XY\n",
" bbox:           xmin: 144.2894 ymin: -37.4846 xmax: 144.3893 ymax: -37.36012\n", #nolint
" epsg (SRID):    4326\n",
" proj4string:    +proj=longlat +datum=WGS84 +no_defs"))

## ----osmdata_sf2, eval = FALSE-------------------------------------------
#  osmdata_sf(q, 'trentham.osm')

## ---- echo = FALSE-------------------------------------------------------
message (paste0 (
" Object of class 'osmdata' with:\n",
"                  $bbox : -37.4300874,144.2863388,-37.3500874,144.3663388\n",
"         $overpass_call : The call submitted to the overpass API\n",
"             $timestamp : [ Wed 4 Jun 2017 11:57:39 ]\n",
"            $osm_points : 'sf' Simple Features Collection with 7106 points\n",
"             $osm_lines : 'sf' Simple Features Collection with 263 linestrings\n", #nolint
"          $osm_polygons : 'sf' Simple Features Collection with 38 polygons\n",
"        $osm_multilines : 'sf' Simple Features Collection with 1 multilinestrings\n", #nolint
"     $osm_multipolygons : 'sf' Simple Features Collection with 6 multipolygons")) #nolint

## ----object-sizes, eval = FALSE------------------------------------------
#  s1 <- object.size(osmdata_sf(q, 'trentham.osm')$osm_points)
#  s2 <- object.size(sf::st_read('trentham.osm', layer = 'points', quiet = TRUE))
#  as.numeric(s1 / s2)

## ---- echo = FALSE-------------------------------------------------------
507.1454

## ---- eval = FALSE-------------------------------------------------------
#  names(sf::st_read('trentham.osm', layer = 'points', quiet = TRUE)) # the keys

## ---- echo = FALSE-------------------------------------------------------
c ("osm_id", "name", "barrier", "highway", "ref", "address", "is_in", "place",
   "man_made", "other_tags", "geometry")

## ---- eval = FALSE-------------------------------------------------------
#  names(osmdata_sf(q, 'trentham.osm')$osm_points)

## ---- echo = FALSE-------------------------------------------------------
c ("osm_id", "name", "X_description_", "X_waypoint_", "addr.city",
   "addr.housenumber", "addr.postcode", "addr.street", "amenity", "barrier",
   "denomination", "foot", "ford", "highway", "leisure", "note_1", "phone",
   "place", "railway", "railway.historic", "ref", "religion", "shop", "source",
   "tourism", "waterway", "geometry")

## ---- eval = FALSE-------------------------------------------------------
#  addr <- sf::st_read('trentham.osm', layer = 'points', quiet = TRUE)$address
#  all(is.na(addr))

## ---- echo = FALSE-------------------------------------------------------
TRUE

## ----sf_sp, eval = FALSE-------------------------------------------------
#  dat <- sf::st_read('buildings.osm', layer = 'multipolygons', quiet = TRUE)
#  dat_sp <- as(dat, 'Spatial')
#  class(dat_sp)

## ---- echo = FALSE-------------------------------------------------------
message (paste (
" [1] \"SpatialPolygonsDataFrame\"\n",
"attr(,\"package\")\n",
"[1] \"sp\""))

## ---- eval = FALSE-------------------------------------------------------
#  dim(dat_sp)

## ---- echo = FALSE-------------------------------------------------------
c (560, 25)

## ---- eval = FALSE-------------------------------------------------------
#  dim(osmdata_sp(q, doc = 'buildings.osm')$osm_polygons)

## ---- echo = FALSE-------------------------------------------------------
c (566, 114)

## ---- eval = FALSE-------------------------------------------------------
#  dim(osmdata_sp(q, doc = 'buildings.osm')$osm_multipolygons)

## ---- echo = FALSE-------------------------------------------------------
c (15, 52)

## ---- eval = FALSE-------------------------------------------------------
#  tr <- opq(bbox = 'Trentham, Australia') %>%
#      add_feature(key = 'name') %>%
#      osmdata_sf()

## ---- eval = FALSE-------------------------------------------------------
#  coliban <- which(tr$osm_lines$name == 'Coliban River') %>%
#      tr$osm_lines[., ]
#  coliban[which(!is.na(coliban))]

## ---- echo = FALSE-------------------------------------------------------
message (paste0 (
" Simple feature collection with 1 feature and 3 fields\n",
" geometry type:  LINESTRING\n",
" dimension:      XY\n",
" bbox:           xmin: 144.3235 ymin: -37.37162 xmax: 144.3335 ymax: 37.36366\n", #nolint
" epsg (SRID):    4326\n",
" proj4string:    +proj=longlat +datum=WGS84 +no_defs\n",
"            osm_id          name waterway                       geometry\n",
" 87104907 87104907 Coliban River    river LINESTRING(144.323471069336..."))

## ---- eval = FALSE-------------------------------------------------------
#  coliban$geometry[[1]]

## ---- echo = FALSE-------------------------------------------------------
message ("LINESTRING(144.323471069336 -37.3716201782227, 144.323944091797 -37.3714790344238, 144.324356079102 -37.3709754943848, 144.324493408203 -37.3704833984375, 144.324600219727 -37.370174407959, 144.324981689453 -37.3697204589844, 144.325149536133 -37.369441986084, 144.325393676758 -37.3690567016602, 144.325714111328 -37.3686943054199, 144.326080322266 -37.3682441711426)") #nolint

## ---- eval = FALSE-------------------------------------------------------
#  pts <- osm_points(tr, rownames(coliban))
#  wf <- pts[which(pts$waterway == 'waterfall'), ]
#  wf[which(!is.na(wf))]

## ---- echo = FALSE-------------------------------------------------------
message (paste0 (
" Simple feature collection with 1 feature and 4 fields\n",
" geometry type:  POINT\n",
" dimension:      XY\n",
" bbox:           xmin: 144.3246 ymin: -37.37017 xmax: 144.3246 ymax: -37.37017\n", #nolint
" epsg (SRID):    4326\n",
" proj4string:    +proj=longlat +datum=WGS84 +no_defs\n",
"                osm_id           name    tourism  waterway\n",
" 1013064837 1013064837 Trentham Falls attraction waterfall\n",
"                                  geometry\n",
" 1013064837 POINT(144.324600219727 -37...."))

## ---- eval = FALSE-------------------------------------------------------
#  mp <- osm_multipolygons(tr, rownames(wf))

## ---- echo = FALSE-------------------------------------------------------
for (f in list.files(pattern = "\\.osm"))
    if (file.exists(f)) file.remove(f)

## ---- eval = FALSE-------------------------------------------------------
#  lcnr9 <- opq ('greater london uk') %>%
#      add_feature (key = "name", value = "London.Cycle.Network.Route.9",
#                   value_exact = FALSE) %>%
#      osmdata_sp()
#  sp::plot(lcnr9$osm_lines)

