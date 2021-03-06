#!/bin/bash 
#SBATCH -A m1800
#SBATCH -p debug
#SBATCH --qos premium
#SBATCH --gres=craynetwork:3
#SBATCH -N 60
#SBATCH -t 00:30:00
#SBATCH -L SCRATCH  
#SBATCH -J time_hdf5
#SBATCH -C haswell



module load R

nreaz=6
nvari=30
years=$(seq 1 6)
for ireaz in 3
do
    for ivari in $(seq 1 $nvari)
    do
	for iyear in $years
	do
            srun -N 1 -n 1 --mem=40960 --gres=craynetwork:1 R CMD BATCH  "--args ireaz=$ireaz ivari=$ivari iyear=$iyear" codes/output.time.hdf5.R   R_hdf$ireaz"_"$ivari"_"$iyear".out" &
	done
    done
done

wait


####SBATCH --qos premium
