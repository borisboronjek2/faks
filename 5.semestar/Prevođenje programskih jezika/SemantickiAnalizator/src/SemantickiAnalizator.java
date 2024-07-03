import java.util.LinkedList;
import java.util.Scanner;

public class SemantickiAnalizator {

	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		LinkedList<String> stablo=new LinkedList<String>();
		LinkedList<String> leksicki=new LinkedList<String>();
		while (sc.hasNextLine()) {
			stablo.addLast(sc.nextLine());
		}
		sc.close();
		for(int i=0;i<stablo.size();i++) {
			if(stablo.get(i).contains("IDN") || stablo.get(i).contains("KR_ZA") || stablo.get(i).contains("KR_AZ") || stablo.get(i).contains("KR_OD")
					|| stablo.get(i).contains("KR_DO")) {
				String[] polje=stablo.get(i).split(" ");
				StringBuilder sb=new StringBuilder();
				for(int j=0;j<polje.length;j++) {
					if(!polje[j].equals("") && j<polje.length-1) {
						sb.append(polje[j]);
						sb.append(" ");
					} else if(!polje[j].equals("")) {
						sb.append(polje[j]);
					}
				}
				leksicki.add(sb.toString());
			}
		}
		LinkedList<LinkedList<Struct>> trajanje=new LinkedList<LinkedList<Struct>>();
		trajanje.add(new LinkedList<Struct>());
		LinkedList<LinkedList<String>> red=new LinkedList<LinkedList<String>>();
		String[][] leksickiPom=pomocno(leksicki);
		for(int i=0;i<leksicki.size();i++) {
			int r=Integer.parseInt(leksickiPom[i][1]);
			if(red.size()<r) {
				LinkedList<String> pom=new LinkedList<String>();
				pom.add(leksicki.get(i));
				red.add(pom);
			} else {
				red.get(r-1).add(leksicki.get(i));
			}
		}
		boolean err=false;
		int tr=0;
		for (int i=0;i<leksicki.size();i++) {
			if(err) {
				break;
			} else {
				if(leksickiPom[i][0].equals("KR_ZA")) {
					trajanje.add(new LinkedList<Struct>());
					tr++;
					while(!leksickiPom[i][0].equals("KR_OD")) {
						trajanje.get(tr).add(new Struct(leksickiPom[i][2], Integer.parseInt(leksickiPom[i][1])));
						i++;
					}
					while(!leksickiPom[i][0].equals("KR_DO")) {
						if(red.get(Integer.parseInt(leksickiPom[i][1])-1).get(1).equals(leksicki.get(i))) {
							System.out.println("err "+leksickiPom[i][1]+" "+leksickiPom[i][2]);
							err=true;
							break;
						} else if(leksickiPom[i][0].equals("IDN") && defined(leksickiPom[i][2], trajanje)) {
							int redak=whereDefined(leksickiPom[i][2], trajanje);
							System.out.println(leksickiPom[i][1]+" "+redak+" "+leksickiPom[i][2]);
						} else if(!leksickiPom[i][0].equals("KR_OD")) {
							System.out.println("err "+leksickiPom[i][1]+" "+leksickiPom[i][2]);
							err=true;
							break;
						}
						i++;
					}
					if(err) {
						break;
					}
					while(leksickiPom[i][1].equals(leksickiPom[i-1][1])) {
						if(red.get(Integer.parseInt(leksickiPom[i][1])-1).get(1).equals(leksicki.get(i))) {
							System.out.println("err "+leksickiPom[i][1]+" "+leksickiPom[i][2]);
							err=true;
							break;
						} else if(leksickiPom[i][0].equals("IDN") && defined(leksickiPom[i][2], trajanje)) {
							int redak=whereDefined(leksickiPom[i][2], trajanje);
							System.out.println(leksickiPom[i][1]+" "+redak+" "+leksickiPom[i][2]);
						} else if(!leksickiPom[i][0].equals("KR_DO")){
							System.out.println("err "+leksickiPom[i][1]+" "+leksickiPom[i][2]);
							err=true;
							break;
						}
						i++;
					}
				} else if(leksickiPom[i][0].equals("KR_AZ")) {
					tr--;
					trajanje.removeLast();
				} else {
					if(i==0) {
						trajanje.get(tr).add(new Struct(leksickiPom[i][2], Integer.parseInt(leksickiPom[i][1])));
					} else if(!leksickiPom[i][1].equals(leksickiPom[i-1][1])) {
						if(!defined2(leksickiPom[i][2],trajanje)) {
							trajanje.get(tr).add(new Struct(leksickiPom[i][2], Integer.parseInt(leksickiPom[i][1])));
						} 
					} else if(leksickiPom[i][1].equals(leksickiPom[i-1][1])) {
						int redak=whereDefined(leksickiPom[i][2], trajanje);
						if(redak==Integer.parseInt(leksickiPom[i][1])) {
							System.out.println("err "+leksickiPom[i][1]+" "+leksickiPom[i][2]);
							err=true;
							break;
						} else {
							System.out.println(leksickiPom[i][1]+" "+redak+" "+leksickiPom[i][2]);
						}
					}
				}
			}
		}
	}
	public static String[][] pomocno(LinkedList<String> lines) {
		String[][] rez=new String[lines.size()][3];
		for(int i=0;i<lines.size();i++) {
			String[] novi=lines.get(i).split(" ");
			for(int j=0;j<3;j++) {
				rez[i][j]=novi[j];
			}
		}
		return rez;
	}
	public static boolean defined(String tst, LinkedList<LinkedList<Struct>> trajanje) {
		boolean rez=false;
		for(int i=0;i<trajanje.size()-1;i++) {
			for(int j=0;j<trajanje.get(i).size();j++) {
				if(trajanje.get(i).get(j).getIDN().equals(tst)) {
					rez=true;
				}
			}
		}
		return rez;
	}
	public static boolean defined2(String tst, LinkedList<LinkedList<Struct>> trajanje) {
		boolean rez=false;
		for(int i=0;i<trajanje.size();i++) {
			for(int j=0;j<trajanje.get(i).size();j++) {
				if(trajanje.get(i).get(j).getIDN().equals(tst)) {
					rez=true;
				}
			}
		}
		return rez;
	}
	public static int whereDefined(String tst, LinkedList<LinkedList<Struct>> trajanje) {
		int rez=0;
		for(int i=0;i<trajanje.size();i++) {
			for(int j=0;j<trajanje.get(i).size();j++) {
				if(trajanje.get(i).get(j).getIDN().equals(tst)) {
					rez=trajanje.get(i).get(j).getRedak();
				}
			}
		}
		return rez;
	}
	public static class Struct{
		String IDN;
		int redak;
		public Struct(String IDN, int redak) {
			this.IDN = IDN;
			this.redak = redak;
		}
		public String getIDN() {
			return IDN;
		}
		public int getRedak() {
			return redak;
		}
	}
}
