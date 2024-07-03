#include <stdio.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <unistd.h>

int *A;
int *pravo;
int *zastavica;
int id,id2,id3;

void proces(int p, int m)
{
	for(int i=0;i<m;i++){
		//uđi u kritični odsječak
		zastavica[p]=1;
		while(zastavica[1-p]!=0){
			if((*pravo)==1-p){
				zastavica[p]=0;
				while((*pravo)==1-p){
				}
				zastavica[p]=1;
			}
		}
		//K.O.
		//printf("Proces %d uvećava varijablu A za 1. ",p+1);
		(*A)++;
		//printf("Varijabla A sada ima vrijednost %d.\n",*A);
		//sleep(0.1);
		//izađi iz kritičnog odsječka
		(*pravo)=1-p;
		zastavica[p]=0;
	}
	//printf("Proces %d zavrsio s brojanjem.\n",p+1);
}

int main(int argc, char **argv)
{
	int n=atoi(argv[1]);
	
	id=shmget(IPC_PRIVATE, sizeof(int), 0600);
	if(id==-1) exit(1);
	A=(int *) shmat(id, NULL, 0);
	*A=0;
	
	id2=shmget(IPC_PRIVATE, sizeof(int), 0600);
	if(id2==-1) exit(1);
	pravo=(int *) shmat(id2, NULL, 0);
	*pravo=0;
	
	id3=shmget(IPC_PRIVATE, 2*sizeof(int), 0600);
	if(id3==-1) exit(1);
	zastavica=(int *) shmat(id3, NULL, 0);
	zastavica[0]=0;
	zastavica[1]=0;
	
	printf("Varijabla A ima vrijednost %d na početku programa.\n",*A);
	
	if(fork()==0){
		proces(0,n);
		exit(0);
	}else{
		proces(1,n);
	}
	wait(NULL);
	printf("Cijeli program zavrsio s brojanjem. Varijabla A na kraju ima vrijednost %d.\n", *A);
	return 0;
}





