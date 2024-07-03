import java.util.LinkedList;
import java.util.Scanner;

public class Parser {
	
	private static String ispis="";
	private static LinkedList<String> ulaz=new LinkedList<>();

	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		String gram=sc.nextLine();
		for(int i=0;i<gram.length();i++) {
			ulaz.add(String.valueOf(gram.charAt(i)));
		}
		sc.close();
		boolean rez=S();
		System.out.println(ispis);
		if(ulaz.isEmpty() && rez) {
			System.out.println("DA");
		} else {
			System.out.println("NE");
		}
	}

	private static boolean S() {
		boolean def=false;
		ispis+="S";
		if(ulaz.isEmpty()) {
			return false;
		}
		String tmp=ulaz.get(0);
		ulaz.remove(0);
		def=false;
		switch(tmp) {
			case("a"):
				if(def=A()) {
					def=B();
				}
				return def;
			case("b"):
				if(def=B()) {
					def=A();
				}
				return def;
			default:
				return false;
		}
	}
	
	private static boolean A() {
		ispis+="A";
		if(ulaz.isEmpty()) {
			return false;
		}
		String tmp=ulaz.get(0);
		ulaz.remove(0);
		boolean def=false;
		switch(tmp) {
			case("a"):
				return true;
			case("b"):
				def=C();
				return def;
			default:
				return false;
		}
	}
	
	private static boolean B() {
		ispis+="B";
		if(ulaz.isEmpty()) {
			return true;
		}
		String tmp=ulaz.get(0);
		switch(tmp) {
			case("c"):
				ulaz.remove(0);
				String tmp2;
				if(!ulaz.isEmpty()) {
					tmp2=ulaz.get(0);
				} else return false;
				switch(tmp2) {
				case("c"):
					ulaz.remove(0);
					S();
					String tmp3;
					if(!ulaz.isEmpty()) {
						tmp3=ulaz.get(0);
					} else return false;
					switch(tmp3) {
						case("b"):
							ulaz.remove(0);
							String tmp4;
							if(!ulaz.isEmpty()) {
								tmp4=ulaz.get(0);
							} else return false;
							switch(tmp4) {
								case("c"):
									ulaz.remove(0);
									return true;
								default:
									return false;
							}
					}
				}
			default:
				return true;
		}
	}
	private static boolean C() {
		ispis+="C";
		boolean def=false;
		if(def=A()) {
			def=A();
		}
		return def;
	}
}
