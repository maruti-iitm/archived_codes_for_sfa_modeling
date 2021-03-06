rm(list = ls())
library(rhdf5)
library(RCurl) #for merage list


wells = c("1-10A","2-1","2-2","2-32","1-21A","2-3")
wells = paste("Well_399-",wells,sep="")
nwell = length(wells)
path = "/files3/pin/simulations/reTest7_newRingold_2010_2015_6h/"
path = "/files3/pin/simulations/Test13_piecewiseGrad_2010_2015_6h/"
path = "/files3/pin/simulations/Test13_piecewiseGrad_2010_2015_6h/new_simulation_13/"
## path = "/files1/song884/bpt/new_simulation_13_5/"
## path = "/files1/song884/bpt/new_simulation_13_25/"
#path = "/files3/pin/simulations/Test13_piecewiseGrad_2010_2015_6h/new_simulation_13/"

###read in all data
simu.all=list()
obs.files = list.files(path,pattern=paste("-obs-",sep=''))
for (ifile in obs.files)
{
    print(ifile)
    header=read.table(paste(path,ifile,sep=''),nrow=1,sep=",",header=FALSE,stringsAsFactors=FALSE)
    simu.single=read.table(paste(path,ifile,sep=""),skip=1,header=FALSE)
    colnames(simu.single)=header
    simu.all=merge.list(simu.all,simu.single)
}

save(simu.all,file=paste(path,"simu.all.r",sep=''))

