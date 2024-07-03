import java.util.ArrayList;
import java.util.Scanner;

public class MinDka {

	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		String[] StanjaPom=sc.nextLine().split("\\,");
		String[] simboli=sc.nextLine().split("\\,");
		String[] PrihvatljivaStanjaPom=sc.nextLine().split("\\,");
		String pocetnoStanje=sc.nextLine();
		ArrayList<String> PrijelazPom=new ArrayList<String>();
		String pom;
		while(sc.hasNextLine()) {
			pom=sc.nextLine();
			PrijelazPom.add(pom);
		}
		sc.close();
		ArrayList<String> Stanja=new ArrayList<String>();
		ArrayList<String> prihvatljiva=new ArrayList<String>();
		for(int i=0;i<StanjaPom.length;i++) {
			Stanja.add(StanjaPom[i]);
		}
		for(int i=0;i<PrihvatljivaStanjaPom.length;i++) {
			prihvatljiva.add(PrihvatljivaStanjaPom[i]);
		}
		String[][] Pr1=pretvori(PrijelazPom, PrijelazPom.size());
		String[][] prijelaz=pretvori2(Pr1, PrijelazPom.size());
		ArrayList<ArrayList<String>> prva=new ArrayList<ArrayList<String>>();
		ArrayList<ArrayList<String>> druga=new ArrayList<ArrayList<String>>();
		ArrayList<String> pomocna=new ArrayList<String>();
		for(int i=0;i<Stanja.size();i++) {
			if(!prihvatljiva.contains(Stanja.get(i))) {
				pomocna.add(Stanja.get(i));
			}
		}
		prva.add(pomocna);
		prva.add(prihvatljiva);
		int prSize=PrijelazPom.size();
		ArrayList<ArrayList<String>> temp=new ArrayList<ArrayList<String>>();
		if(StanjaPom.length==1) {
			System.out.println(StanjaPom[0]);
			for(int i=0;i<simboli.length;i++) {
				if(i!=simboli.length-1) {
					System.out.print(simboli[i] + ",");
				} else {
					System.out.println(simboli[i]);
				}
			}
			System.out.println(PrihvatljivaStanjaPom[0]);
			System.out.println(pocetnoStanje);
			for(int i=0;i<PrijelazPom.size();i++) {
				System.out.println(PrijelazPom.get(i));
			}
		} else if(PrihvatljivaStanjaPom.length==StanjaPom.length){
			System.out.println(StanjaPom[0]);
			for(int i=0;i<simboli.length;i++) {
				if(i!=simboli.length-1) {
					System.out.print(simboli[i] + ",");
				} else {
					System.out.println(simboli[i]);
				}
			}
			System.out.println(StanjaPom[0]);
			System.out.println(StanjaPom[0]);
			for(int i=0;i<simboli.length;i++) {
				System.out.println(pocetnoStanje + "," + simboli[i] + "->" + pocetnoStanje);
			}
		} else {
			do{
				temp=prva;
				for (int i=0;i<prva.size();i++) {
					ArrayList<String> pom1=new ArrayList<String>();
					ArrayList<String> pom2=new ArrayList<String>();
					pom1.add(prva.get(i).get(0));
					for(int j=1;j<prva.get(i).size();j++) {
						int brojac=0;
						for(int br1=0;br1<prSize;br1++) {
							for(int br2=0;br2<prSize;br2++) {
								for(int arr=0;arr<prva.size();arr++) {
									if(prva.get(i).get(0).equals(prijelaz[br1][0]) && prva.get(i).get(j).equals(prijelaz[br2][0]) && 
											prijelaz[br1][1].equals(prijelaz[br2][1]) && prva.get(arr).contains(prijelaz[br1][2]) &&
											prva.get(arr).contains(prijelaz[br2][2]) && !prijelaz[br1][0].equals(prijelaz[br2][0]) &&
											!pom1.contains(prva.get(i).get(j))) {
										brojac++;
										if(brojac%simboli.length==simboli.length-1) {
											pom1.add(prva.get(i).get(j));
										}
									}
								}
							}
						}
					}
					for(int j=0;j<prva.get(i).size();j++) {
						if(!pom1.contains(prva.get(i).get(j))) {
							pom2.add(prva.get(i).get(j));
						}
					}
					druga.add(pom1);
					if(!pom2.isEmpty()) {
						druga.add(pom2);
					}
				} 
				prva=druga;
				druga=new ArrayList<ArrayList<String>>();
				
			} while(!temp.equals(prva));
			
			boolean printed=false;
			for(int i=0;i<StanjaPom.length;i++) {
				for(int j=0;j<prva.size();j++) {
					if (printed && StanjaPom[i].equals(prva.get(j).get(0))) {
						System.out.print(",");
					}
					if (StanjaPom[i].equals(prva.get(j).get(0))) {
						System.out.print(prva.get(j).get(0));
						printed=true;
					}
				}
			}
			System.out.println();
			for(int i=0;i<simboli.length;i++) {
				if(i!=simboli.length-1) {
					System.out.print(simboli[i] + ",");
					} else {
						System.out.println(simboli[i]);
					}
			}
			printed=false;
			for(int i=0;i<prva.size();i++) {
				if(prihvatljiva.contains(prva.get(i).get(0))) {
					if (printed) {
						System.out.print(",");
					}
					System.out.print(prva.get(i).get(0));
					printed=true;
				} 
			}
			System.out.println();
			for(int i=0;i<prva.size();i++) {
				if(prva.get(i).contains(pocetnoStanje)) {
					pocetnoStanje=prva.get(i).get(0);
				}
			}
			System.out.println(pocetnoStanje);
			ArrayList<String> stanja=new ArrayList<String>();
			for(int i=0;i<prva.size();i++) {
				stanja.add(prva.get(i).get(0));
			}
			String[] matrix=new String[prSize];
			for(int i=0;i<prSize;i++) {
				for(int j=0;j<prva.size();j++) {
					if(prva.get(j).contains(prijelaz[i][2])){
						matrix[i]=prva.get(j).get(0);
					}
				}
			}
			for(int i=0;i<prSize;i++) {
				if(stanja.contains(prijelaz[i][0])) {
					System.out.println(prijelaz[i][0] + "," + prijelaz[i][1] + "->" + matrix[i]);
				}
			}
		}
	}
	static public String[][] pretvori(ArrayList<String> PrijelazPom, int j){
		String[][] rez=new String[j][2];
		for(int i=0;i<j;i++) {
			String[] novi=PrijelazPom.get(i).split("->");
				for(int k=0;k<2;k++) {
					rez[i][k]=novi[k];
				}
		}
		return rez;
	}
	static public String[][] pretvori2(String[][] Pr1, int j) {
		String[][] rez=new String[j][3];
		for(int i=0;i<j;i++) {
			String[] novi=Pr1[i][0].split("\\,");
			for(int k=0;k<3;k++) {
				if(k==2) {
					rez[i][k]=Pr1[i][1];
				} else {
					rez[i][k]=novi[k];
				}
			}
		}
		return rez;
	}
}
