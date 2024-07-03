#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <math.h>

int broj;
char status[]="status.txt";
char obrada[]="obrada.txt";
int nije_kraj=1;

int obradaBroja(int br);
void obradi_dogadjaj(int sig);
void obradi_sigterm(int sig);
void obradi_sigint(int sig);

int main()
{
	struct sigaction act;

	act.sa_handler=obradi_dogadjaj;
	sigemptyset(&act.sa_mask);
	sigaddset(&act.sa_mask, SIGTERM);
	act.sa_flags=0;
	sigaction(SIGUSR1, &act, NULL);

	act.sa_handler=obradi_sigterm;
	sigemptyset(&act.sa_mask);
	sigaction(SIGTERM, &act, NULL);

	act.sa_handler=obradi_sigint;
	sigaction(SIGINT, &act, NULL);

	printf("Program s PID=%ld krenuo s radom\n", (long) getpid());

	FILE *statusFileR;
	FILE *statusFileW;
	FILE *obradaFileR;
	FILE *obradaFileW;
	statusFileR=fopen(status, "r");
	obradaFileR=fopen(obrada, "r");

	fscanf(statusFileR, "%d", &broj);
	fclose(statusFileR);
	if(broj==0){
		while(fscanf(obradaFileR, "%d", &broj)==1);
		broj=sqrt(broj);
	}
	fclose(obradaFileR);
	statusFileW=fopen(status, "w");
	fprintf(statusFileW, "%d ", 0);
	fclose(statusFileW);
	int x;
	obradaFileW=fopen(obrada, "a");
	while(nije_kraj){
		broj++;
		x=obradaBroja(broj);
		fprintf(obradaFileW, "%d \n", x);
		sleep(5);
	}
	return 0;
}

int obradaBroja(int br)
{
	int rez=br*br;
	return rez;
}

void obradi_dogadjaj(int sig)
{
	printf("%d\n", broj);
}

void obradi_sigterm(int sig)
{
	FILE *statusFileW;
	statusFileW=fopen(status, "w");
	fprintf(statusFileW, "%d ", broj);
	fclose(statusFileW);
	exit(1);
}

void obradi_sigint(int sig)
{
	exit(1);
}
