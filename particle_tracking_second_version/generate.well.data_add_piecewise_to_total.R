rm(list = ls())
library(rhdf5)
#library(RCurl) #for merage list


#wells = c("1-10A","2-1","2-2","2-32","1-21A")
wells = c(
    "2-1",
    "2-2",
    "1-21A",
    "3-19",
    "2-3",
    "2-32",
    "2-33",
    "2-7",
    "2-23",
    "2-5",
    "1-10A",
    "3-9",
    "4-9")

wells = paste("Well_399-",wells,sep="")
nwell = length(wells)

path = "/files1/song884/bpt/new_simulation_13_5/"
path = "/files1/song884/bpt/new_simulation_13_25/"
path = "/files3/pin/simulations/Test13_piecewiseGrad_2010_2015_6h/"
path = "/files3/pin/simulations/Test13_piecewiseGrad_2010_2015_6h/new_simulation_13/"

obs.types = c("Tracer_river_318",
              "Tracer_river_319",                 
              "Tracer_river_320",
              "Tracer_river_321",
              "Tracer_river_322",
              "Tracer_river_323",
              "Tracer_river_324",
              "Tracer_river_325",
              "Tracer_northBC",
              "qlx","qly"                            
              )

load(paste(path,"simu.all.r",sep=''))

well.data = list()
for (iwell in wells)
{
    well.data[[iwell]] = list()
    obs.name = iwell
    for (iobs in obs.types)
    {
        simu.col=intersect(grep(iwell,names(simu.all)),grep(iobs,names(simu.all)))
        well.data[[iwell]][[iobs]] = simu.all[,simu.col]
    }
}
simu.time = simu.all[,1]




tracer.types = c("Tracer_river_318",
                 "Tracer_river_319",                 
                 "Tracer_river_320",
                 "Tracer_river_321",
                 "Tracer_river_322",
                 "Tracer_river_323",
                 "Tracer_river_324",
                 "Tracer_river_325",
                 "Tracer_northBC"                                                                                     
              )

tracer = list()
for (itracer in tracer.types)
{
    tracer[[itracer]] = list()
    for (iwell in wells)
    {
        abs.vec = (well.data[[iwell]][["qlx"]]^2+well.data[[iwell]][["qly"]]^2)^0.5
        tracer[[itracer]][[iwell]] = rowSums(well.data[[iwell]][[itracer]]*abs.vec)/rowSums(abs.vec)
    }
}


tracer.types = c("Tracer_river","Tracer_north")

for (itracer in tracer.types)
{
    tracer[[itracer]]=list()
}


for (iwell in wells)
{
    tracer[["Tracer_river"]][[iwell]] = tracer[["Tracer_river_318"]][[iwell]]+tracer[["Tracer_river_319"]][[iwell]]+
        tracer[["Tracer_river_320"]][[iwell]]+tracer[["Tracer_river_321"]][[iwell]]+
        tracer[["Tracer_river_322"]][[iwell]]+tracer[["Tracer_river_323"]][[iwell]]+
        tracer[["Tracer_river_324"]][[iwell]]+tracer[["Tracer_river_325"]][[iwell]]
        tracer[["Tracer_north"]][[iwell]] = tracer[["Tracer_northBC"]][[iwell]]
}



save(list=c("well.data","simu.time","tracer"),file=paste(path,"simu_wells_total_river.r",sep=""))
