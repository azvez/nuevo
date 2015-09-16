/**
 * Copyright 1993-2012 NVIDIA Corporation.  All rights reserved.
 *
 * Please refer to the NVIDIA end user license agreement (EULA) associated
 * with this source code for terms and conditions that govern your use of
 * this software. Any use, reproduction, disclosure, or distribution of
 * this software and related documentation outside the terms of the EULA
 * is strictly prohibited.
 */

//System includes
#include <stdio.h>
#include <stdlib.h>

//Cuda includes
#include <cuda.h>


__global__ void vecAddKernel(float *A, float *B, float *C, int n){
	int i = threadIdx.x+blockDim.x*blockIdx.x;
	if(i<n)
		C[i] = A[i]+B[i];
}

extern "C"
void vecAdd_par(float* h_A, float* h_B, float* h_C, int n){
	int size = n*sizeof(float);
	float *dA, *dB, *dC;

	// Alocate memory para A, B, C
	cudaMalloc((void **) &dA,size);
	cudaMalloc((void **) &dB,size);
	cudaMalloc((void **) &dC,size);

	// Copiar A y B a la memoria del dispositivo
	cudaMemcpy(dA,h_A,size,cudaMemcpyHostToDevice);
	cudaMemcpy(dB,h_B,size,cudaMemcpyHostToDevice);

	// llamada al kernel
	// dA, dB, dC tal y como lo hemos visto antes
	// Para bloques de hebras de 256
	int var=256;
	if(n>512)
		var=512;
	dim3 DimBlock(var,1,1);
	dim3 DimGrid(((n-1)/DimBlock.x)+1,1,1);
	vecAddKernel<<<DimGrid,DimBlock>>>(dA,dB,dC,n);

	// copiar C desde el dispositivo
	cudaMemcpy(h_C,dC,size,cudaMemcpyDeviceToHost);

	// liberar memoria de A, B y C
	cudaFree(dA);
	cudaFree(dB);
	cudaFree(dC);
}
