#include <fstream>
#include <time.h>
#include <iostream>
#include <string>
#include <sstream>

extern "C"
void vecAdd_par(float *h_A, float *h_B, float *h_C, int n);

void leer_ficheros(float* &h_A, float* &h_B, float* &h_C_sec, float* &h_C_par, int i, int &n){

	//Código para crear una estructura que nos permita abrir y leer el par de ficheros
	std::fstream fichero1,fichero2;
	int tam,j;
	char aux[50];
	std::ostringstream path1, path2;
	path1 << "../datos/input" << i << "0.raw";
	path2 << "../datos/input" << i << "1.raw";
	std::string path1_s=path1.str();
	std::string path2_s=path2.str();
	const char* file1=path1_s.c_str();
	const char* file2=path2_s.c_str();
	fichero1.open(file1, std::ios::in);
	fichero2.open(file2, std::ios::in);

	//Guardamos el tamaño de los vectores y avanzamos una linea en ambos ficheros para empezar a leer datos
	fichero1>>tam;
	fichero2>>tam;
	n=tam;

	//Creamos los tres vectores del tamaño adecuado
	h_A=new float[tam];
	h_B=new float[tam];

	h_C_sec=new float[tam];
	h_C_par=new float[tam];

	//Guardamos los datos del primero fichero en el vector A
	j=0;
	while(!fichero1.eof()){
		fichero1>>h_A[j];
		j++;
	}

	//Guardamos los datos del segundo fichero en el vector B
	j=0;
	while(!fichero2.eof()){
		fichero2>>h_B[j];
		j++;
	}

	//Cerramos las estructuras que nos sirvieron para leer los ficheros
	fichero1.close();
	fichero2.close();

}

//Suma secuencial ejecutada por la CPU
void vecAdd_sec(float* h_A, float* h_B, float* h_C, int n){
	for(int i=0;i<n;i++)
		h_C[i]=h_A[i]+h_B[i];
}

int main (int argc, char **argv){
	//Creamos las variables necesarias para ejecutar el programa
	struct timespec cgt1,cgt2,cgt1_,cgt2_;
	double t_sec,t_par;
	float *h_A,*h_B,*h_C_sec,*h_C_par;
	bool correcto=true;
	int n;

	//Vamos a leer los diez ficheros
	for(int i=0;i<10;i++){

		//Se leen el par de ficheros y se almacenan en los vectores A y B
		leer_ficheros(h_A, h_B, h_C_sec, h_C_par,i ,n);

		//toma_inicio_tiempo_secuencial
		clock_gettime(CLOCK_REALTIME,&cgt1);
		//Se realiza la suma secuencial de los vectores y se guarda en C_sec
		vecAdd_sec(h_A, h_B, h_C_sec, n);
		//toma_fin_tiempo_secuencial
		clock_gettime(CLOCK_REALTIME,&cgt2);
		//calculo del tiempo secuencial
		t_sec=(double) (cgt2.tv_sec-cgt1.tv_sec)+(double) ((cgt2.tv_nsec-cgt1.tv_nsec)/(1.e+9));

		//toma_inicio_tiempo_paralelo
		clock_gettime(CLOCK_REALTIME,&cgt1_);
		//Se realiza la suma paralela de los vectores y se guarda en C_par
		vecAdd_par(h_A, h_B, h_C_par, n);
		//toma_fin_tiempo_paralelo
		clock_gettime(CLOCK_REALTIME,&cgt2_);
		//calculo del tiempo parelelo
		t_par=(double) (cgt2_.tv_sec-cgt1_.tv_sec)+(double) ((cgt2_.tv_nsec-cgt1_.tv_nsec)/(1.e+9));

		//Comprobación de si las sumas secuencial y paralela son iguales
		for (int j=0;j<n;j++){
			if(h_C_sec[j]-h_C_par[j]>0.1){
				correcto=false;
			}
		}

		if(correcto==true){
			//Se muestran los resultados
			std::cout<<"Par de archivos "<<i<<". Tiempo secuencial para un vector de tamaño " <<n<<": "<<t_sec<<"."<<std::endl;
			std::cout<<"Par de archivos "<<i<<". Tiempo paralelo para un vector de tamaño " <<n<<": "<<t_par<<"."<<std::endl;
			std::cout<<std::endl;
		}

		else{
			std::cout<<"Error. Las sumas secuencial y paralela no coinciden."<<std::endl;
		}

		//liberamos la memoria de los vectores usados
	    delete[] h_A;
	    delete[] h_B;
	    delete[] h_C_sec;
	    delete[] h_C_par;
	}
}

