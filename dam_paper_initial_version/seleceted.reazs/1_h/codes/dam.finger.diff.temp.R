rm(list=ls())
library(gplots)
library(abind)
load("statistics/parameters.r")
load("statistics/boundary.r")

fname="2duniform"

time.ticks = c(
    as.POSIXct("2011-01-01 12:01:01",tz="GMT",format="%Y-%m-%d %H:%M:%S"),
    as.POSIXct("2012-01-01 12:01:01",tz="GMT",format="%Y-%m-%d %H:%M:%S"),
    as.POSIXct("2013-01-01 12:01:01",tz="GMT",format="%Y-%m-%d %H:%M:%S"),
    as.POSIXct("2014-01-01 12:01:01",tz="GMT",format="%Y-%m-%d %H:%M:%S"),
    as.POSIXct("2015-01-01 12:01:01",tz="GMT",format="%Y-%m-%d %H:%M:%S")
    )

args=(commandArgs(TRUE))
if(length(args)==0) {
    print("no realization id supplied,use default 1")
    ireaz=4
    ix=228
}else{
    for(i in 1:length(args)) {
        eval(parse(text=args[[i]]))
    }
}
ivari=20


load(paste(ireaz,"/","h5data0.r",sep=""))
nvari = length(h5data)
vari.names = names(h5data)
ivari = vari.names[ivari]


load(paste("highlight.data/1_",ivari,"_",ix,".r",sep=""))
base = value[,-c(365,365+366,365*2+366,365*3+366)]


###iyear = 4
years = c(365,365,366,365,365,365)
files = 0:sum(years[2:6]*8)+(sum(years[1])*8)
##files = 0:(years[iyear]*8)+(sum(years[0:(iyear-1)])*8)
nfile = length(files)
level.river.interp = approx((level.river[[ireaz]][[1]]-start.time),level.river[[ireaz]][[2]],
                            files*3*3600)[[2]]
level.inland.interp = approx((level.inland[[ireaz]][[1]]-start.time),level.inland[[ireaz]][[2]],
                             files*3*3600)[[2]]
temp.river.interp = approx((temp.river[[ireaz]][[1]]-start.time),temp.river[[ireaz]][[2]],
                           files*3*3600)[[2]]
temp.inland.interp = approx((temp.inland[[ireaz]][[1]]-start.time),temp.inland[[ireaz]][[2]],
                            files*3*3600)[[2]]
level.river.interp.part = level.river.interp
level.river.interp.part[which(level.inland.interp<=level.river.interp)] = NA


load(paste("highlight.data/",ireaz,"_",ivari,"_",ix,".r",sep=""))
smooth = value[,-c(365,365+366,365*2+366,365*3+366)]




z.ori=z
z[c(which.min(z),which.max(z))] = round(range(z))


print(ix)
ylim = range(z[which(material_ids[ix,]>0)])
##jpeg(paste("download.figure/",ireaz,"/","finger.",ivari,"_",ix,".jpg",sep=""),width=10.5,height=2,units="in",res=200,quality=100)




## jpeg(paste("download.figure/",ireaz,"/","finger_diff.",ivari,"_",ireaz,"_",ix,"ix.jpg",sep=""),width=5.4,height=1.3,units="in",res=600,quality=100)
## par(mgp=c(2.,0.6,0),mar=c(2.5,3,1,1))    


jpeg(paste("download.figure/",ireaz,"/","finger_diff.",ivari,"_",ireaz,"_",ix,"ix.jpg",sep=""),width=9.8,height=2.88,units="in",res=600,quality=100)
par(mgp=c(2.,0.6,0),mar=c(4.1,4.1,2.1,2.1))    
##par(mgp=c(2.,0.6,0),mar=c(2.5,3,1,1))    

field = t((base-smooth)[,])
column.top = max(which(!is.na(field[1,])))    
river.loc = 301:325


##par(mar=c(4,5,2,0),mgp=c(2.5,1,0))
field[which(field>2)] = 2
field[which(field< -2)] = -2
filled.contour(files*3*3600+start.time,z,field,
               ## main = paste(ivari,", x =",round(x[ix],2),"(m)",
               ##              ", z =",round(z[column.top],2),"(m)"),
               color = bluered,                   
               ylim = c(98.5,110),
               xlim = c(as.POSIXct("2011-01-01 12:01:01",tz="GMT",format="%Y-%m-%d %H:%M:%S"),
                        as.POSIXct("2016-01-01 12:01:01",tz="GMT",format="%Y-%m-%d %H:%M:%S")
                        ),
               zlim = c(-2,2),
               xlab = "",
               ylab = "Elevation (m)",
##               key.axes=axis(4,seq(0,24,8)),                              
               plot.axes = {
                   axis.POSIXct(1,at=time.ticks,format="%Y");                   
                   axis(2,at=c(90,95,100,105,110));
                   mtext("Time",at=end.time-3600*50*24,1,0.6)                                                                                
                   lines(c(start.time,end.time),rep(max(z[which(material_ids[ix,]==5)]),2),col="blue",lty=2,lwd=2)
                   lines(c(start.time,end.time),rep(max(z[which(material_ids[ix,]==1)]),2),col="green",lty=2,lwd=2)
                   lines(c(start.time,end.time),rep(max(z[which(material_ids[ix,]==4)]),2),col="black",lty=2,lwd=2)
                   lines(files*3*3600+start.time,level.river.interp,lwd=2)
##                   lines(files*3*3600+start.time,level.river.interp.part,col="green")
##                   lines(rep(16060*3*3600+start.time,2),c(80,200))                                                             
               }
               
               )

dev.off()
##    mtext("Time",1,line=0)
##    mtext("Elevation (m)",2,line=0)    

z = z.ori
