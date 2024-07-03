#include <signal.h>
#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <sys/types.h>
#include <time.h>
#include <sys/shm.h>
#include <sys/wait.h>
#include <unistd.h>

char ispis[]="ispis.txt";
int id, id2, *prvaZajVar=0, drugaZajVar=0, *brojac;
FILE *ispisW;

void ulazni_proces()
{
	printf("Pokrenut ULAZNI PROCES\n");
	sleep(1);
	while(*brojac!=0){
		do{
			sleep(1);
		} while(*prvaZajVar!=0);
		if (*brojac==0){
			break;
		}
		srand(time(NULL));
		int broj=rand()%100+1;
		printf("\nULAZNI PROCES: broj %d\n", broj);
		*prvaZajVar=broj;
		int randSleep=rand()%5+1;
		sleep(randSleep);
	}
	printf("Zavrsio ULAZNI PROCES\n");
	exit(0);
}

void *radna_dretva(void *x)
{
	printf("Pokrenuta RADNA DRETVA\n");
	sleep(1);
	while(*brojac!=0){
		int broj;
		do{
			broj=*prvaZajVar;
			sleep(1);
		} while(broj==0 || drugaZajVar!=0);
		drugaZajVar=broj+1;
		printf("RADNA DRETVA: Procitan broj %d i povecan na %d\n", broj, drugaZajVar);
		sleep(1);
		while(drugaZajVar!=0){
			sleep(1);
		}
		*prvaZajVar=0;
	}
	printf("Zavrsila RADNA DRETVA\n");
	pthread_exit(0);
}

void *izlazna_dretva(void *x)
{
	printf("Pokrenuta IZLAZNA DRETVA\n");
	sleep(1);
	for(;*brojac>0;*brojac=*brojac-1){
		ispisW=fopen(ispis, "a");
		do{
			sleep(1);
		} while (drugaZajVar==0);
		fprintf(ispisW, "%d\n", drugaZajVar);
		printf("IZLAZNA DRETVA: broj upisan u datoteku %d\n", drugaZajVar);
		drugaZajVar=0;
		fclose(ispisW);
	}
	printf("\nZavrsila IZLAZNA DREVTA\n");
	pthread_exit(0);
}

void cisti(int sig)
{
	(void) shmdt((int *)prvaZajVar);
	(void) shmctl(id, IPC_RMID, NULL);
	exit(0);
}

int main(int argc, char **argv)
{
	printf("PID: %d\n", getpid());
	ispisW=fopen(ispis, "w");
	fclose(ispisW);

	id=shmget(IPC_PRIVATE, sizeof(int), 0600);
	if(id==-1) exit(1);

	prvaZajVar=(int *)shmat(id, NULL, 0);
	*prvaZajVar=0;

	id2=shmget(IPC_PRIVATE, sizeof(int), 0600);
	if(id2==-1) exit(1);

	brojac=(int *)shmat(id2, NULL, 0);
	*brojac=0;

	struct sigaction act;
	act.sa_handler=cisti;
	sigaction(SIGINT, &act, NULL);
	
	int n=atoi(argv[1]);
	*brojac=n;
	pthread_t t[2];

	if(fork()==0){
		pthread_create(&t[0], NULL, radna_dretva, NULL);
		pthread_create(&t[1], NULL, izlazna_dretva, NULL);
		
		pthread_join(t[0], NULL);
		pthread_join(t[1], NULL);

		exit(0);
	} else {
		ulazni_proces();
		wait(NULL);
	}

	cisti(0);
	return 0;
}
