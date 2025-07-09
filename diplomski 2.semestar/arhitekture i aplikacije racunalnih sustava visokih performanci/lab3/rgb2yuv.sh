#!/bin/bash
#SBATCH --job-name=rgb2yuv
#SBATCH --output=rgb2yuv_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=00:10:00

export OMP_NUM_THREADS=1
./parallel

export OMP_NUM_THREADS=2
./parallel

export OMP_NUM_THREADS=4
./parallel

export OMP_NUM_THREADS=8
./parallel

export OMP_NUM_THREADS=16
./parallel
