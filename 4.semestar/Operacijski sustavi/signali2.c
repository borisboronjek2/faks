#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <time.h>

struct timespec t0;

void postavi_pocetno_vrijeme()
{
	clock_gettime(CLOCK_REALTIME, &t0);
}

void vrijeme(void)
{
	struct timespec t;
	clock_gettime(CLOCK_REALTIME, &t);
	t.tv_sec-=t0.tv_sec;
	t.tv_nsec-=t0.tv_nsec;
	if(t.tv_nsec<0){
		t.tv_nsec+=1000000000;
		t.tv_nsec--;
	}
	printf("%03ld.%03ld:\t", t.tv_sec, t.tv_nsec/1000000);
}

#define PRINTF(format, ...)		\
do {					\
	vrijeme();			\
	printf(format,##__VA_ARGS__);	\
}					\
while(0);

int T_P=0;
int K_Z[3]={0,0,0};
int stog[3]={0,0,0};

int obradaBroja(int br);
void obradi_dogadjaj(int sig);
void obradi_sigterm(int sig);
void obradi_sigint(int sig);

void ispisStanje(void)
{
	PRINTF("K_Z=");
	for(int i=0;i<3;i++){
		printf("%d", K_Z[i]);
	}
	printf(", T_P=%d, stog: ", T_P);
	for(int i=2;i>=0;i--){
		if(stog[i]!=0){
			printf("%d reg[%d] ", i, i);
		}
	}
	printf("\n");
	printf("\n");
}

void obrada3()
{
	PRINTF("Pocela obrada prekida razine 3\n");
	K_Z[2]=0;
	stog[T_P]=1;
	T_P=3;
	ispisStanje();
	for(int i=0;i<5;i++){
		sleep(1);
	}
	PRINTF("Kraj obrade prekida razine 3\n");
}

void obrada2()
{
	PRINTF("Pocela obrada prekida razine 2\n");
	K_Z[1]=0;
	stog[T_P]=1;
	T_P=2;
	ispisStanje();
	for(int i=0;i<5;i++){
		sleep(1);
		if(K_Z[2]==1){
			obrada3();
			PRINTF("Nastavlja se obrada prekida razine 2\n");
			stog[2]=0;
			T_P=2;
			ispisStanje();
		}
	}
	PRINTF("Kraj obrade prekida razine 2\n");
}

void obrada1()
{
	PRINTF("Pocela obrada prekida razine 1\n");
	K_Z[0]=0;
	stog[T_P]=1;
	T_P=1;
	ispisStanje();
	for(int i=0;i<5;i++){
		sleep(1);
		if(K_Z[2]==1){
			obrada3();
			PRINTF("Nastavlja se obrada prekida razine 1\n");
			stog[1]=0;
			T_P=1;
			ispisStanje();
		}
		if(K_Z[1]==1){
			obrada2();
			PRINTF("Nastavlja se obrada prekida razine 1\n");
			stog[1]=0;
			T_P=1;
			ispisStanje();
		}
	}
	PRINTF("Kraj obrade prekida razine 1\n");
}

void obradi_sigint(int sig)
{
	if(K_Z[2]==1){
	} else if(T_P==3){
		PRINTF("Dogodio se prekid razine 3, ali se on pamti i ne prosljedjuje procesoru\n");
		K_Z[2]=1;
		ispisStanje();
	} else {
		PRINTF("Dogodio se prekid razine 3 i prosljedjuje se procesoru\n");
		K_Z[2]=1;
		ispisStanje();
		stog[T_P]=1;
	}
}

void obradi_sigterm(int sig)
{
	if(K_Z[1]==1){
	} else if(T_P>=2){
		PRINTF("Dogodio se prekid razine 2, ali se on pamti i ne prosljedjuje procesoru\n");
		K_Z[1]=1;
		ispisStanje();
	} else {
		PRINTF("Dogodio se prekid razine 2 i prosljedjuje se procesoru\n");
		K_Z[1]=1;
		ispisStanje();
		stog[T_P]=1;
	}
}

void obradi_dogadjaj(int sig)
{
	if(K_Z[0]==1){
	} else if(T_P>=1){
		PRINTF("Dogodio se prekid razine 1, ali se on pamti i ne prosljedjuje procesoru\n");
		K_Z[0]=1;
		ispisStanje();
	} else {
		PRINTF("Dogodio se prekid razine 1 i prosljedjuje se procesoru\n");
		K_Z[0]=1;
		ispisStanje();
		stog[T_P]=1;
	}
}

int main()
{
	struct sigaction act;

	act.sa_handler=obradi_dogadjaj;	//SIGUSR1, prioritet razine 1
	sigemptyset(&act.sa_mask);
	sigaddset(&act.sa_mask, SIGTERM);
	act.sa_flags=0;
	sigaction(SIGUSR1, &act, NULL);

	act.sa_handler=obradi_sigterm;	//SIGTERM, prioritet razine 2
	sigemptyset(&act.sa_mask);
	sigaction(SIGTERM, &act, NULL);

	act.sa_handler=obradi_sigint;		//SIGINT, prioritet razine 3
	sigaction(SIGINT, &act, NULL);
	
	postavi_pocetno_vrijeme();
	
	PRINTF("Program s PID=%ld krenuo s radom\n", (long) getpid());
	ispisStanje();
	
	for(int i=0;i<10;i++){
		sleep(1);
		T_P=0;
		stog[T_P]=0;
		if(K_Z[2]==1){
			obrada3();
			PRINTF("Nastavlja se izvodjenje glavnog programa\n");
			stog[0]=0;
			T_P=0;
			ispisStanje();
		}
		if(K_Z[1]==1){
			obrada2(0);
			PRINTF("Nastavlja se izvodjenje glavnog programa\n");
			stog[0]=0;
			T_P=0;
			ispisStanje();
		}
		if (K_Z[0]==1){
			obrada1(0);
			PRINTF("Nastavlja se izvodjenje glavnog programa\n");
			stog[0]=0;
			T_P=0;
			ispisStanje();
		}
	}
	
	PRINTF("Kraj programa\n");
	ispisStanje();
	
	return 0;
}






