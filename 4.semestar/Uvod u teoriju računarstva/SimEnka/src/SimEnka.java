import java.util.LinkedList;
import java.util.Scanner;

public class SimEnka {

	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		String[] Niz=sc.nextLine().split("\\|");
		String[] Stanja=sc.nextLine().split("\\,");
		String[] Simboli=sc.nextLine().split("\\,");
		String SkupPrStanja=sc.nextLine();
		String PocetnoStanje=sc.nextLine();
		LinkedList<String> PrijelazPom=new LinkedList<String>();
		String pom;
		while(sc.hasNextLine()) {
			pom=sc.nextLine();
			PrijelazPom.addLast(pom);
		}
		sc.close();
		String[][] Pr1=Prijelaz(PrijelazPom, PrijelazPom.size());
		String[][] Prijelaz=Prijelaz2(Pr1, PrijelazPom.size());
		LinkedList<String> TrenutnoStanje=new LinkedList<String>();
		LinkedList<String> SljedeceStanje=new LinkedList<String>();
		for(int j=0;j<Niz.length;j++) {
			TrenutnoStanje.add(PocetnoStanje);
			String[] Niz2=Niz[j].split("\\,");
			for(int m=0;m<Niz2.length;m++) {
				for(int k=0;k<TrenutnoStanje.size();k++) {
					for(int l=0;l<PrijelazPom.size();l++) {
						if(Prijelaz[l][0].equals(TrenutnoStanje.get(k)) && Prijelaz[l][1].equals("$")) {
							String[] Prijelaz_=Prijelaz[l][2].split("\\,");
							for(int n=0;n<Prijelaz_.length;n++) {
								if(!TrenutnoStanje.contains(Prijelaz_[n])) {
									TrenutnoStanje.add(Prijelaz_[n]);
								}
							}
						}
					}
				}
				for(int k=0;k<TrenutnoStanje.size();k++) {
					for(int l=0;l<PrijelazPom.size();l++) {
						if(Prijelaz[l][0].equals(TrenutnoStanje.get(k)) && Prijelaz[l][1].equals(Niz2[m])) {
							String[] Prijelaz_=Prijelaz[l][2].split("\\,");
							for(int n=0;n<Prijelaz_.length;n++) {
								if(!SljedeceStanje.contains(Prijelaz_[n])) {
									SljedeceStanje.add(Prijelaz_[n]);
								}
							}
						}
					}
				}
				for(int k=0;k<SljedeceStanje.size();k++) {
					for(int l=0;l<PrijelazPom.size();l++) {
						if(Prijelaz[l][0].equals(SljedeceStanje.get(k)) && Prijelaz[l][1].equals("$")) {
							String[] Prijelaz_=Prijelaz[l][2].split("\\,");
							for(int n=0;n<Prijelaz_.length;n++) {
								if(!SljedeceStanje.contains(Prijelaz_[n])) {
									SljedeceStanje.add(Prijelaz_[n]);
								}
							}
						}
					}
				}
				if(SljedeceStanje.isEmpty()){
					SljedeceStanje.add("#");
				}
				int n=1;
				for(int k=0;k<Stanja.length;k++) {
					if(TrenutnoStanje.contains("#") && TrenutnoStanje.size()==1) {
						System.out.print("#");
						break;
					}
					if(TrenutnoStanje.contains(Stanja[k]) && n==1) {
						System.out.print(Stanja[k]);
						n=0;
					} else if(TrenutnoStanje.contains(Stanja[k]) && n==0) {
						System.out.print("," + Stanja[k]);
					}
				}
				System.out.print("|");
				n=1;
				if(m==Niz2.length-1) {
					for(int k=0;k<Stanja.length;k++) {
						if(SljedeceStanje.contains("#") && SljedeceStanje.size()==1) {
							System.out.print("#");
							break;
						}
						if(SljedeceStanje.contains(Stanja[k]) && n==1) {
							System.out.print(Stanja[k]);
							n=0;
						} else if(SljedeceStanje.contains(Stanja[k]) && n==0) {
							System.out.print("," + Stanja[k]);
						}
					}
				}
				while(!TrenutnoStanje.isEmpty()) {
					TrenutnoStanje.remove();
				}
				while(!SljedeceStanje.isEmpty()) {
					TrenutnoStanje.add(SljedeceStanje.getFirst());
					SljedeceStanje.removeFirst();
				}
				
			}
			System.out.println();
			while(!TrenutnoStanje.isEmpty()) {
				TrenutnoStanje.remove();
			}
		}
	}
	static public String[][] Prijelaz(LinkedList<String> Prijelaz,int  j){
		String[][] rez=new String[j][2];
		for(int i=0;i<j;i++) {
			String[] novi=Prijelaz.get(i).split("->");
			for(int k=0;k<2;k++) {
				rez[i][k]=novi[k];
			}
		}
		return rez;
	}
	static public String[][] Prijelaz2(String[][] Prijelaz, int j){
		String[][] rez=new String[j][3];
		for(int i=0;i<j;i++) {
			String[] novi=Prijelaz[i][0].split("\\,");
			for(int k=0;k<3;k++) {
				if(k==2) {
					rez[i][k]=Prijelaz[i][1];
				} else {
					rez[i][k]=novi[k];
				}
			}
		}
		return rez;
	}
}