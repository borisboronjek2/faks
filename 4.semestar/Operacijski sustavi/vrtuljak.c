#include <stdio.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <pthread.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/shm.h>
#include <semaphore.h>
#include <unistd.h>

sem_t *vrtuljak_;
sem_t *sjeli;
sem_t *smije_izaci;
sem_t *izasli;
int *kapacitet;
int id1,id2,id3,id4,id5;

void vrtuljak()
{
	while(1){
		sem_post(vrtuljak_);
		sleep(1);
		for(int i=1;i<=*kapacitet;i++){
			sem_wait(sjeli);
		}
		printf("Vrtuljak pokrenut\n");
		sleep(3);
		printf("Vrtuljak staje\n");
		sem_post(smije_izaci);
		sleep(1);
		for(int i=1;i<=*kapacitet;i++){
			sem_wait(izasli);
		}
		sleep(1);
	}
}

void posjetitelj(){
	while(1){
		sem_wait(vrtuljak_);
		sleep(1);
		for(int i=1;i<=*kapacitet;i++){
			printf("Osoba sjeda na vrtuljak\n");
			sem_post(sjeli);
		}
		sleep(1);
		sem_wait(smije_izaci);
		sleep(1);
		for(int i=1;i<=*kapacitet;i++){
			printf("Osoba napusta vrtuljak\n");
			sem_post(izasli);
		}
		sleep(1);
	}
}

int main()
{
	int id1=shmget(IPC_PRIVATE,sizeof(sem_t),0600);
	int id2=shmget(IPC_PRIVATE,sizeof(sem_t),0600);
	int id3=shmget(IPC_PRIVATE,sizeof(sem_t),0600);
	int id4=shmget(IPC_PRIVATE,sizeof(sem_t),0600);
	
	vrtuljak_=(sem_t*)shmat(id1,NULL,0);
	sjeli=(sem_t*)shmat(id1,NULL,0);
	smije_izaci=(sem_t*)shmat(id1,NULL,0);
	izasli=(sem_t*)shmat(id1,NULL,0);
	
	sem_init(vrtuljak_,1,0);
	sem_init(sjeli,1,0);
	sem_init(smije_izaci,1,0);
	sem_init(izasli,1,0);
	
	id5=shmget(IPC_PRIVATE, sizeof(int), 0600);
	if(id5==-1) exit(1);

	kapacitet=(int *)shmat(id5, NULL, 0);
	*kapacitet=30;
	
	if(fork()==0){
		posjetitelj();
		exit(0);
	} else {
		vrtuljak();
		wait(NULL);
	}
}
	}
	return 0;
}
