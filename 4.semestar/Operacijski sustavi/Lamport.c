#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

int A=0, m=0;
int *ulaz, *broj;

void *dretva(void *x)
{
	int brDretve=*((int*)x);
	//printf("Stvorena dretva broj %d.\n",brDretve);
	for(int i=0;i<m;i++){
		//uđi u kritični odsječak
		ulaz[i]=1;
		for(int j=0;j<m;j++){
			if(broj[i]<=broj[j]){
				broj[i]=broj[j]+1;
			}
		}
		
		ulaz[i]=0;
		for(int j=0;j<m;j++){
			while(ulaz[j]!=0){
			}
			while(broj[j]!=0 && ((broj[j]<broj[i]) || (broj[j]==broj[i] && j<i))){
			}
		}
		//K.O.
		A++;
		//printf("Dretva %d uvecava varijablu A za 1. A sada ima vrijednost %d.\n",brDretve,A);
		//sleep(0.1);
		//izađi iz kritičnog odsječka
		broj[i]=0;
	}
	//printf("dretva broj %d završila s brojanjem.\n",brDretve);
}

int main(int argc, char **argv)
{
	int n=atoi(argv[1]);
	m=atoi(argv[2]);
	ulaz=(int*)calloc(m,sizeof(int));
	broj=(int*)calloc(m,sizeof(int));
	
	pthread_t t[n];
	int brDretve[n];
	for(int i=0;i<n;i++){
		brDretve[i]=i+1;
	}
	
	printf("Varijabla A ima vrijednost %d na početku programa.\n",A);
	
	for(int i=0;i<n;i++){
		pthread_create(&t[i], NULL, dretva, &brDretve[i]);
	}
	for(int i=0;i<n;i++){
		pthread_join(t[i], NULL);
	}
	printf("Na kraju izvođenja programa varijabla A ima vrijednost %d.\n",A);
	return 0;
}
