################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/deviceQuery.cpp 

OBJS += \
./src/deviceQuery.o 

CPP_DEPS += \
./src/deviceQuery.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-6.0/bin/nvcc -I"/usr/local/cuda-6.0/samples/1_Utilities" -I"/usr/local/cuda-6.0/samples/common/inc" -I"/home/azvez/Dropbox/ICC/2_Cuatrimestre/ACAP/pr/practica4/gpu_car" -G -g -O0 -gencode arch=compute_10,code=sm_10 --target-cpu-architecture x86 -m64 -odir "src" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-6.0/bin/nvcc -I"/usr/local/cuda-6.0/samples/1_Utilities" -I"/usr/local/cuda-6.0/samples/common/inc" -I"/home/azvez/Dropbox/ICC/2_Cuatrimestre/ACAP/pr/practica4/gpu_car" -G -g -O0 --compile --target-cpu-architecture x86 -m64  -x c++ -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


