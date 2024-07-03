#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

pthread_mutex_t m;
pthread_cond_t cekaj, stvaraj;
int *desnaObala, *lijevaObala, *camac, *dTip, *cTip, *lTip;
int bDesno=0, bLijevo=0, bCamac=0, kCamac=0, mCamac=0, kanibalB=1, misionarB=1, obala=0,slazem=0;

void printStatus()
{
	printf("C[");
	if(obala==0){
		printf("D");
	} else if(obala==1){
		printf("L");
	}
	printf("]={");
	for(int i=0;i<bCamac;i++){
		if(cTip[i]==1){
			printf("M%d ", camac[i]);
		} else if(cTip[i]==0){
			printf("K%d ", camac[i]);
		}
	}
	printf("} LO={");
	for(int i=0;i<bLijevo;i++){
		if(lTip[i]==1){
			printf("M%d ", lijevaObala[i]);
		} else if(cTip[i]==0){
			printf("K%d ", lijevaObala[i]);
		}
	}
	printf("} DO={");
	for(int i=0;i<bDesno;i++){
		if(dTip[i]==1){
			printf("M%d ", desnaObala[i]);
		} else if(dTip[i]==0){
			printf("K%d ", desnaObala[i]);
		}
	}
	printf("}\n\n");
}

void kanibal()
{
	pthread_mutex_lock(&m);
	int a=rand()%2+1;
	while(slazem==1){
		pthread_cond_wait(&stvaraj, &m);
	}
	if(a==1){
		printf("K%d: došao na lijevu obalu\n", kanibalB);
		lijevaObala[bLijevo]=kanibalB;
		lTip[bLijevo]=0;
		kanibalB++;
		bLijevo++;
		printStatus();
	} else if (a==2){
		printf("K%d: došao na desnu obalu\n", kanibalB);
		desnaObala[bDesno]=kanibalB;
		dTip[bDesno]=0;
		kanibalB++;
		bDesno++;
		printStatus();
	}
	pthread_cond_signal(&cekaj);
	pthread_mutex_unlock(&m);
}

void misionar()
{
	pthread_mutex_lock(&m);
	int a=rand()%2+1;
	while(slazem==1){
		pthread_cond_wait(&stvaraj, &m);
	}
	if(a==1){
		printf("M%d: došao na lijevu obalu\n", misionarB);
		lijevaObala[bLijevo]=misionarB;
		lTip[bLijevo]=1;
		misionarB++;
		bLijevo++;
		printStatus();
	} else if (a==2){
		printf("M%d: došao na desnu obalu\n", misionarB);
		desnaObala[bDesno]=misionarB;
		dTip[bDesno]=1;
		misionarB++;
		bDesno++;
		printStatus();
	}
	pthread_cond_signal(&cekaj);
	pthread_mutex_unlock(&m);
}

void generator()
{
	while(1){
		pthread_t t1, t2, t3;
		sleep(1);
		pthread_create(&t1,NULL,(void *)kanibal,NULL);
		sleep(1);
		pthread_create(&t2,NULL,(void *)kanibal,NULL);
		pthread_create(&t3,NULL,(void *)misionar,NULL);
		
		pthread_join(t1,NULL);
		pthread_join(t2,NULL);
		pthread_join(t3,NULL);
	}
}

void camacDretva()
{
	while(1){
		if(obala==0){
			printf("C: przan na desnoj obali\n");
			printStatus();
		} else if (obala==1){
			printf("C: prazan na lijevoj obali\n");
			printStatus();
		}
		
		while(bCamac<7){
			pthread_mutex_lock(&m);
			if(bCamac<3){
				pthread_cond_wait(&cekaj,&m);
			}
			int canGo=1;
			if(obala==0){
				int added=0;
				for(int i=0;i<bDesno;i++){
					if(dTip[i]==0 && (kCamac+1<=mCamac || mCamac==0)){
						camac[bCamac]=desnaObala[i];
						cTip[bCamac]=dTip[i];
						bCamac++;
						if(dTip[i]==0){
							printf("K%d: ušao u čamac\n", desnaObala[i]);
						}
						slazem==1;
						for(int j=i;j<bDesno;j++){
							if(j<29){
								dTip[j]=dTip[j+1];
								desnaObala[j]=desnaObala[j+1];
							}
						}
						slazem=0;
						pthread_cond_broadcast(&stvaraj);
						kCamac++;
						bDesno--;
						added=1;
						canGo=0;
						printStatus();
						break;
					} else if(dTip[i]==1 && (kCamac<=1  || bCamac==0 || kCamac<mCamac)){
						camac[bCamac]=desnaObala[i];
						cTip[bCamac]=dTip[i];
						bCamac++;
						slazem=1;
						printf("M%d: ušao u čamac\n", desnaObala[i]);
						for(int j=i;j<bDesno;j++){
							if(j<29){
								dTip[j]=dTip[j+1];
								desnaObala[j]=desnaObala[j+1];
							}
						}
						slazem=0;
						pthread_cond_broadcast(&stvaraj);
						mCamac++;
						bDesno--;
						added=1;
						canGo=0;
						printStatus();
						break;
					}
				}
			}else if(obala==1){
				if(bCamac<3){
					pthread_cond_wait(&cekaj, &m);
				}
				int added=0;
				for(int i=0;i<bLijevo;i++){
					if(lTip[i]==0 && (kCamac+1<=mCamac || mCamac==0)){
						camac[bCamac]=lijevaObala[i];
						cTip[bCamac]=lTip[i];
						bCamac++;
						slazem=1;
						if(lTip[i]==0){
							printf("K%d: ušao u čamac\n", lijevaObala[i]);
						}
						for(int j=i;j<bLijevo;j++){
							if(j<29){
								lTip[j]=lTip[j+1];
								lijevaObala[j]=lijevaObala[j+1];
							}
						}
						slazem=0;
						pthread_cond_broadcast(&stvaraj);
						kCamac++;
						bLijevo--;
						added=1;
						canGo=0;
						printStatus();
						break;
					} else if(lTip[i]==1 && (kCamac<=1 || bCamac==0 || kCamac<mCamac)){
						camac[bCamac]=lijevaObala[i];
						cTip[bCamac]=lTip[i];
						bCamac++;
						slazem=1;
						printf("M%d: ušao u čamac\n", lijevaObala[i]);
						for(int j=i;j<bLijevo;j++){
							if(j<29){
								lTip[j]=lTip[j+1];
								lijevaObala[j]=lijevaObala[j+1];
							}
						}
						slazem=0;
						pthread_cond_broadcast(&stvaraj);
						mCamac++;
						bLijevo--;
						added=1;
						canGo=0;
						printStatus();
						break;
					}
				}
			}
			if(obala==0){
				if(bCamac>=3 && (bDesno==0 || canGo==1)){
				int br=0;
				if(obala==0){
					br=bDesno;
				} else if(obala==1){
					br=bLijevo;
				}
				printf("C: tri putnika ukrcana, polazim za jednu sekundu\n");
				printStatus();
				sleep(0.9);
				sleep(0.1);
				
				if(obala==0 && br==bDesno){
					break;
				}
				if (canGo=1) break;
				}
			} else if (obala==1){
				if(bCamac>=3 && (bLijevo==0 || canGo==1)){
				int br=0;
				if(obala==0){
					br=bDesno;
				} else if(obala==1){
					br=bLijevo;
				}
				printf("C: tri putnika ukrcana, polazim za jednu sekundu\n");
				printStatus();
				sleep(0.9);
				sleep(0.1);
				
				if(obala==1 && br==bLijevo){
					break;
				}
				if (canGo=1) break;
				}
			}
			pthread_mutex_unlock(&m);
		}
			pthread_mutex_unlock(&m);
		
		if(obala==0){
			printf("C: prevozim s desne na lijevu obalu: ");
			for (int i=0;i<bCamac;i++){
				if(cTip[i]==1){
					printf("M%d ", camac[i]);
				} else if(cTip[i]==0){
					printf("K%d ", camac[i]);
				}
			}
			printf("\n\n");
		} else if (obala==1){
			printf("C: prevozim s lijeve na desnu obalu: ");
			for (int i=0;i<bCamac;i++){
				if(cTip[i]==1){
					printf("M%d ", camac[i]);
				} else if(cTip[i]==0){
					printf("K%d ", camac[i]);
				}
			}
			printf("\n\n");
		}
		sleep(1);
		
		pthread_mutex_lock(&m);
		
		if(obala==0){
			printf("C: preveo s desne na lijevu obalu: ");
			for (int i=0;i<bCamac;i++){
				if(cTip[i]==1){
					printf("M%d ", camac[i]);
				} else if(cTip[i]==0){
					printf("K%d ", camac[i]);
				}
			}
			printf("\n");
		} else if (obala==1){
			printf("C: preveo s lijeve na desnu obalu: ");
			for (int i=0;i<bCamac;i++){
				if(cTip[i]==1){
					printf("M%d ", camac[i]);
				} else if(cTip[i]==0){
					printf("K%d ", camac[i]);
				}
			}
			printf("\n");
		}
		
		for(int i=0;i<7;i++){
			cTip[i]=0;
			camac[i]=0;
		}
		bCamac=0;
		mCamac=0;
		kCamac=0;
		obala=1-obala;
		
		pthread_mutex_unlock(&m);
	}
}

int main()
{
	pthread_mutex_init(&m,NULL);
	pthread_cond_init(&cekaj,NULL);
	pthread_cond_init(&stvaraj,NULL);
	
	desnaObala=(int*)calloc(30,sizeof(int));
	dTip=(int*)calloc(30,sizeof(int));
	lijevaObala=(int*)calloc(30,sizeof(int));
	lTip=(int*)calloc(30,sizeof(int));
	camac=(int*)calloc(7,sizeof(int));
	cTip=(int*)calloc(7,sizeof(int));
	
	srand(time(NULL));
	
	printf("Legenda: M-misionar, K-kanibal, C-čamac\n");
	printf("	LO-lijeva obala, DO-desna obala\n");
	printf("	L-lijevo, D-desno\n\n");
	
	pthread_t t1, t2;
	
	pthread_create(&t1,NULL,(void *)camacDretva,NULL);
	pthread_create(&t2,NULL,(void *)generator,NULL);
	
	pthread_join(t1,NULL);
	pthread_join(t2,NULL);
	
	return 0;
}




