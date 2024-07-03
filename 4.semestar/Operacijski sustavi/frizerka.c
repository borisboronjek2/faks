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

sem_t *klijent_;
sem_t *spavaj;
int *brojac;
int *otvoreno;
int *krajRadnogVremena;
int *cekaonicaMjesta;
int *cekaonica;

void frizerka()
{
	printf("Frizerka: Otvaram salon\n");
	printf("Frizerka: Postavljam znak OTVORENO\n");
	(*otvoreno)=1;
	while(1){
		if(*otvoreno==0 && *cekaonicaMjesta==4){
			printf("Frizerka: Zatvaram salon\n");
			break;
		} else if(*krajRadnogVremena==1){
			printf("Frizerka: Postavljam znak ZATVORENO\n");
			(*otvoreno)=0;
			(* krajRadnogVremena)=0;
		} else if(*cekaonicaMjesta<4){
			int brKlijenta=cekaonica[0];
			printf("Frizerka: Idem raditi na klijentu %d\n", brKlijenta);
			sem_post(klijent_);
			sleep(2);
			printf("Frizerka: Klijent %d gotov \n", brKlijenta);
		} else if(*krajRadnogVremena==0){
			printf("Frizerka: Spavam dok klijenti ne dođu\n");
			sem_wait(spavaj);
		}
	}
}

void klijent(int *x)
{
	(*brojac)++;
	printf("	Klijent(%d): Želim na frizuru\n", *x);
	if(*cekaonicaMjesta>0 && *otvoreno==1){
		(*cekaonicaMjesta)--;
		for(int i=0;i<4;i++){
			if(cekaonica[i]==0){
				cekaonica[i]=(*x);
				break;
			}
		}
		printf("	Klijent(%d): Ulazim u čekaonicu\n", *x);
		if (*cekaonicaMjesta==3){
			sem_post(spavaj);
		}
		sem_wait(klijent_);
		for(int i=0;i<4;i++){
			if(i!=3){
				cekaonica[i]=cekaonica[i+1];
			} else {
				cekaonica[i]=0;
			}
		}
		(*cekaonicaMjesta)++;
	} else {
		printf("	Klijent(%d): Nema mjesta u čekaoni, vratit ću se sutra\n", *x);
	}
}

int main()
{
	int id1=shmget(IPC_PRIVATE,sizeof(sem_t),0600);
	int id2=shmget(IPC_PRIVATE,sizeof(sem_t),0600);
	int id3=shmget(IPC_PRIVATE,sizeof(int), 0600);
	int id4=shmget(IPC_PRIVATE,sizeof(int), 0600);
	int id5=shmget(IPC_PRIVATE,sizeof(int), 0600);
	int id6=shmget(IPC_PRIVATE,sizeof(int), 0600);
	int id7=shmget(IPC_PRIVATE,4*sizeof(int), 0600);
	
	klijent_=(sem_t*)shmat(id1,NULL,0);
	spavaj=(sem_t*)shmat(id2,NULL,0);
	brojac=(int*)shmat(id3,NULL,0);
	cekaonicaMjesta=(int*)shmat(id4,NULL,0);
	otvoreno=(int*)shmat(id5,NULL,0);
	krajRadnogVremena=(int*)shmat(id6,NULL,0);
	cekaonica=(int*)shmat(id7,NULL,0);
	*brojac=0;
	*cekaonicaMjesta=4;
	*otvoreno=0;
	*krajRadnogVremena=0;
	for(int i=0;i<4;i++){
		cekaonica[i]=0;
	}
	
	sem_init(klijent_,1,0);
	sem_init(spavaj,1,0);
	
	if(fork()==0){
		if(fork()==0){
			frizerka();
			exit(0);
		} else {
			while(*otvoreno==0){
				sleep(0.1);
			}
			if(*otvoreno==1){
				for(int i=0;i<30;i++){
					if (fork()==0){
						klijent(brojac);
						//sleep(0.1);
						exit(0);
					} else {
					}
					sleep(1);
				}
				for(int i=0;i<30;i++){
					wait(NULL);
				}
			}
			wait(NULL);
		}
		exit(0);
	} else {
		sleep(30);
		*krajRadnogVremena=1;
		sem_post(spavaj);
		wait(NULL);
	}
	
	return 0;
}




