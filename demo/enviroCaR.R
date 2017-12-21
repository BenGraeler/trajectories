## Shows how to use the enviroCaR R package to import enviroCar tracks.
if (!require(enviroCaR)) {
  if (!require(devtools))
    stop("install devtools first")
  devtools::install_github("enviroCar/enviroCaR"); 
  library(enviroCaR)
}

serverUrl = "https://envirocar.org/api/stable"
boundingbox = matrix(c(7.5,51.9,7.7,52.1),
                     ncol=2,
                     dimnames=list(c("x","y"), c("min","max")))
interval = xts::.parseISO8601('2017-01-01T00:00/2017-05-31T23:59')

trackIDs = getTrackIDs(serverUrl,bbox = boundingbox, timeInterval = interval)

# how many tracks intersect with the space-time window?
length(trackIDs)

# fetch all these tracks from the enviroCar server
trCol = importEnviroCar(serverUrl, trackIDs = trackIDs)

summary(trCol)

# what is the length of the collection
length(trCol@tracksCollection)

# importing a single track returns a Tracks object
track <- importSingleTrack("https://envirocar.org/api/stable", trackIDs[1])

plot(track)