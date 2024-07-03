import java.util.LinkedList;
import java.util.Scanner;

public class SimPa {

	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		String[] niz=sc.nextLine().split("\\|");
		String[] stanja=sc.nextLine().split("\\,");
		String[] ulZnakovi=sc.nextLine().split("\\,");
		String[] znakoviStoga=sc.nextLine().split("\\,");
		String prihvatljivoStanje=sc.nextLine();
		String pocetnoStanje=sc.nextLine();
		String pocetniZnakStoga=sc.nextLine();
		LinkedList<String> PrijelazPom=new LinkedList<String>();
		String pom;
		while(sc.hasNextLine()) {
			pom=sc.nextLine();
			PrijelazPom.addLast(pom);
		}
		sc.close();
		String[][] Pr1=Prijelaz(PrijelazPom, PrijelazPom.size());
		String[][] Prijelaz=Prijelaz2(Pr1, PrijelazPom.size());
		
		for(int i=0;i<niz.length;i++) {
			String[] pomNiz=niz[i].split("\\,");
			LinkedList<String> stog=new LinkedList<String>();
			stog.add(pocetniZnakStoga);
			String trenutnoStanje=pocetnoStanje;
			System.out.print(trenutnoStanje+"#"+pocetniZnakStoga+"|");
			boolean fix=true;
			boolean fail=false;
			boolean fix2=true;
			boolean fix3=true;
			for(int j=0;j<pomNiz.length;j++) {
				boolean change=false;
				int pomVar=0;
				for(int k=0;k<PrijelazPom.size();k++) {
					if(Prijelaz[k][0].equals(trenutnoStanje) && (Prijelaz[k][2].equals(stog.getLast()) || (stog.getLast().equals("$") && 
							Prijelaz[k][1].equals("$"))) &&
							(Prijelaz[k][1].equals(pomNiz[j]) || Prijelaz[k][1].equals("$"))) {
						pomVar=k;
						change=true;
						if(Prijelaz[k][1].equals("$")) {
							if(fix3) {
								if(!fix2) {
									fix3=false;
								}
								j--;
							}
							trenutnoStanje=Prijelaz[k][3];
							stog.removeLast();
							if(!Prijelaz[k][4].equals("$")) {
								for(int l=Prijelaz[k][4].length()-1;l>=0;l--) {
									StringBuilder sb=new StringBuilder();
									sb.append(Prijelaz[k][4].charAt(l));
									String s=sb.toString();
									stog.add(s);
								}
							} else if(stog.isEmpty()){
								stog.add(Prijelaz[k][4]);
							}
						} else {
							trenutnoStanje=Prijelaz[k][3];
							stog.removeLast();
							if(!Prijelaz[k][4].equals("$")) {
								for(int l=Prijelaz[k][4].length()-1;l>=0;l--) {
									StringBuilder sb=new StringBuilder();
									sb.append(Prijelaz[k][4].charAt(l));
									String s=sb.toString();
									stog.add(s);
								}
							} else if(stog.isEmpty()){
								stog.add(Prijelaz[k][4]);
							}
						}
						break;
					}
				}
				fail=!change;
				if(!fix || !fix2) {
					fail=false;
				}
				if(fail) {
					System.out.print("fail");
				} else {
					System.out.print(trenutnoStanje);
					System.out.print("#");
					for(int k=stog.size()-1;k>=0;k--) {
						System.out.print(stog.get(k));
					}
				}
				System.out.print("|");
				if(fail) {
					break;
				}
				if(j==pomNiz.length-1 && stog.size()==1 && Prijelaz[pomVar][4].equals("$") && fix) {
					j--;
					fix=false;
					stog.remove();
					stog.add("$");
				} 
				if(j==pomNiz.length-1 && !trenutnoStanje.equals(prihvatljivoStanje) && fix2 && !prihvatljivoStanje.equals("")) {
					j--;
					fix2=false;
				}
			}
			if(trenutnoStanje.equals(prihvatljivoStanje) && !fail) {
				System.out.println("1");
			} else {
				System.out.println("0");
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
		String[][] rez=new String[j][5];
		for(int i=0;i<j;i++) {
			String[] novi=Prijelaz[i][0].split("\\,");
			String[] novi2=Prijelaz[i][1].split("\\,");
			for(int k=0;k<3;k++) {
				rez[i][k]=novi[k];
			}
			for(int k=3;k<5;k++) {
				rez[i][k]=novi2[k-3];
			}
		}
		return rez;
	}
}