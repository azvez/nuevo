################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/principal.cpp 

CU_SRCS += \
../src/suma_vectores.cu 

CU_DEPS += \
./src/suma_vectores.d 

OBJS += \
./src/principal.o \
./src/suma_vectores.o 

CPP_DEPS += \
./src/principal.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-6.0/bin/nvcc -G -g -O0 -gencode arch=compute_11,code=sm_11 --target-cpu-architecture x86 -m64 -odir "src" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-6.0/bin/nvcc -G -g -O0 --compile --target-cpu-architecture x86 -m64  -x c++ -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/%.o: ../src/%.cu
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-6.0/bin/nvcc -G -g -O0 -gencode arch=compute_11,code=sm_11 --target-cpu-architecture x86 -m64 -odir "src" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-6.0/bin/nvcc --compile -G -O0 -g -gencode arch=compute_11,code=compute_11 -gencode arch=compute_11,code=sm_11 --target-cpu-architecture x86 -m64  -x cu -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


