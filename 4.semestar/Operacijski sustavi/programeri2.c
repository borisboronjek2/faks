#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/shm.h>
#include <time.h>
#include <sys/wait.h>

pthread_mutex_t m;
pthread_cond_t red[2];
int unutra[2]={0,0};
int ceka[2]={0,0};
int posluzeno[2]={0,0};
int N=10;
int MicrosoftProgrameri=30;
int LinuxProgrameri=30;
int vrsta_pr[2]={0,1}; //0 oznacava microsoft programere, a 1 linux programere

void *udji(int *tvrtka)
{	
	int vrsta=*((int *)tvrtka);
	pthread_mutex_lock(&m);
	ceka[vrsta]++;
	while(unutra[1-vrsta]>0 || (ceka[1-vrsta]>0 && posluzeno[vrsta]>=N)){
		pthread_cond_wait(&red[vrsta], &m);
	}
	unutra[vrsta]++;
	posluzeno[1-vrsta]=0;
	ceka[vrsta]--;
	posluzeno[vrsta]++;
	if(vrsta==0){
		printf("Windows programer usao u restoran\n");
	} else{
		printf("Linux programer usao u restoran\n");
	}
	pthread_mutex_unlock(&m);
}

void *izadi(int *tvrtka)
{	
	int vrsta=*((int *)tvrtka);
	pthread_mutex_lock(&m);
	unutra[vrsta]--;
	if(vrsta==0){
		printf("Windows programer izasao iz restorana\n");
	} else{
		printf("Linux programer izasao iz restorana\n");
	}
	if(unutra[vrsta]==0){
		pthread_cond_broadcast(&red[1-vrsta]);
	}
	pthread_mutex_unlock(&m);
}

void programer(void *arg)
{
	pthread_t th[2];
	int vrsta=*(int *)arg;
	pthread_create(&th[0], NULL,(void *)udji,(void *)&vrsta);
	sleep(1);
	pthread_create(&th[1], NULL,(void *)izadi,(void *)&vrsta);
	pthread_join(th[0],NULL);
	pthread_join(th[1],NULL);
}


int main()
{
	pthread_mutex_init(&m,NULL);
	pthread_cond_init(&red[0],NULL);
	pthread_cond_init(&red[1],NULL);
	pthread_t t[MicrosoftProgrameri+LinuxProgrameri];
	for(int i=0;i<MicrosoftProgrameri+LinuxProgrameri;i++){
		pthread_create(&t[i],NULL,(void *)programer,(void *)&vrsta_pr[0]);
		i++;
		pthread_create(&t[i],NULL,(void *)programer,(void *)&vrsta_pr[1]);
	}
	for(int i=0;i<MicrosoftProgrameri+LinuxProgrameri;i++){
		pthread_join(t[i],NULL);
	}
	return 0;
}
