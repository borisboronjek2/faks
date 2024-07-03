#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>

pthread_mutex_t m;
pthread_cond_t red[2];
int unutra[2]={0,0};
int ceka[2]={0,0};
int posluzeno[2]={0,0};
int N=10;
int MicrosoftProgrameri=30;
int LinuxProgrameri=30;
int vrsta_pr[2]={0,1}; //0 oznacava microsoft programere, a 1 linux programere

void udji(int vrsta)
{	
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
	return;
}

void izadi(int vrsta)
{	
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
	return;
}

void programer(void *arg)
{
	int vrsta=*(int *)arg;
	udji(vrsta);
	sleep(1);
	izadi(vrsta);
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
