import java.util.LinkedList;
import java.util.Scanner;

public class LeksickiAnalizator {
	
	private static LinkedList<String> numbers=new LinkedList<>();
	private static LinkedList<String> operators=new LinkedList<>();
	private static LinkedList<String> brackets=new LinkedList<>();

	public static void main(String[] args) {
		numbers.add("0");
		numbers.add("1");
		numbers.add("2");
		numbers.add("3");
		numbers.add("4");
		numbers.add("5");
		numbers.add("6");
		numbers.add("7");
		numbers.add("8");
		numbers.add("9");
		
		operators.add("=");
		operators.add("+");
		operators.add("-");
		operators.add("/");
		operators.add("*");
		
		brackets.add(")");
		brackets.add("(");
		
		Scanner sc=new Scanner(System.in);
		LinkedList<String> lines=new LinkedList<String>();
		while (sc.hasNextLine()) {
			lines.addLast(sc.nextLine());
		}
		sc.close();
		
		for(int i=0;i<lines.size();i++) {
			for(int j=0;j<lines.get(i).length();j++) {
				if("/".charAt(0)==lines.get(i).charAt(j)) {
					if("/".charAt(0)==lines.get(i).charAt(j+1)) {
						break;
					} else {
						System.out.println("OP_DIJELI "+(i+1)+" /");
					}
				} else if ("+".charAt(0)==(lines.get(i).charAt(j))) {
					System.out.println("OP_PLUS "+(i+1)+" +");
				} else if ("-".charAt(0)==(lines.get(i).charAt(j))) {
					System.out.println("OP_MINUS "+(i+1)+" -");
				} else if ("*".charAt(0)==(lines.get(i).charAt(j))) {
					System.out.println("OP_PUTA "+(i+1)+" *");
				} else if ("=".charAt(0)==(lines.get(i).charAt(j))) {
					System.out.println("OP_PRIDRUZI "+(i+1)+" =");
				} else if ("(".charAt(0)==(lines.get(i).charAt(j))) {
					System.out.println("L_ZAGRADA "+(i+1)+" (");
				} else if (")".charAt(0)==(lines.get(i).charAt(j))) {
					System.out.println("D_ZAGRADA "+(i+1)+" )");
				} else if("z".charAt(0)==(lines.get(i).charAt(j)) && j<lines.get(i).length()-2) {
					if("a".charAt(0)==(lines.get(i).charAt(j+1)) && " ".charAt(0)==(lines.get(i).charAt(j+2))) {
						System.out.println("KR_ZA "+(i+1)+" za");
						j++;
					} else {
						System.out.print("IDN "+(i+1)+" z");
						j++;
						StringBuilder sb=new StringBuilder();
						sb.append(lines.get(i).charAt(j));
						String pom=sb.toString();
						while(!operators.contains(pom) && !brackets.contains(pom) && " ".charAt(0)!=(lines.get(i).charAt(j))) {
							sb.delete(0, sb.length());
							System.out.print(lines.get(i).charAt(j));
							if(j==lines.get(i).length()) {
								System.out.println();
							} else {
								j++;
								if(j==lines.get(i).length()) {
									break;
								}
								sb.append(lines.get(i).charAt(j));
								pom=sb.toString();
							}
						}
						if(operators.contains(pom) || brackets.contains(pom)) {
							j--;
						}
						if(j!=lines.get(i).length()) {
							System.out.println();
						}
					}
				} else if("a".charAt(0)==(lines.get(i).charAt(j)) && j<=lines.get(i).length()-2) {
					if("z".charAt(0)==(lines.get(i).charAt(j+1)) && j==lines.get(i).length()-2) {
						System.out.println("KR_AZ "+(i+1)+" az");
						j++;
					} else {
						System.out.print("IDN "+(i+1)+" a");
						j++;
						StringBuilder sb=new StringBuilder();
						sb.append(lines.get(i).charAt(j));
						String pom=sb.toString();
						while(!operators.contains(pom) && !brackets.contains(pom) && " ".charAt(0)!=(lines.get(i).charAt(j))) {
							sb.delete(0, sb.length());
							System.out.print(lines.get(i).charAt(j));
							if(j==lines.get(i).length()) {
								System.out.println();
								break;
							} else {
								j++;
								if(j==lines.get(i).length()) {
									break;
								}
								sb.append(lines.get(i).charAt(j));
								pom=sb.toString();
							}
						}
						if(operators.contains(pom) || brackets.contains(pom)) {
							j--;
						}
						if(j!=lines.get(i).length()) {
							System.out.println();
						}
					}
				} else if("d".charAt(0)==(lines.get(i).charAt(j)) && j<lines.get(i).length()-2) {
					if("o".charAt(0)==(lines.get(i).charAt(j+1)) && " ".charAt(0)==(lines.get(i).charAt(j+2))) {
						System.out.println("KR_DO "+(i+1)+" do");
						j++;
					} else {
						System.out.print("IDN "+(i+1)+" d");
						j++;
						StringBuilder sb=new StringBuilder();
						sb.append(lines.get(i).charAt(j));
						String pom=sb.toString();
						while(!operators.contains(pom) && !brackets.contains(pom) && " ".charAt(0)!=(lines.get(i).charAt(j))) {
							sb.delete(0, sb.length());
							System.out.print(lines.get(i).charAt(j));
							if(j==lines.get(i).length()) {
								System.out.println();
								break;
							} else {
								j++;
								if(j==lines.get(i).length()) {
									break;
								}
								sb.append(lines.get(i).charAt(j));
								pom=sb.toString();
							}
						}
						if(operators.contains(pom) || brackets.contains(pom)) {
							j--;
						}
						if(j!=lines.get(i).length()) {
							System.out.println();
						}
					}
				} else if("o".charAt(0)==(lines.get(i).charAt(j)) && j<lines.get(i).length()-2) {
					if("d".charAt(0)==(lines.get(i).charAt(j+1)) && " ".charAt(0)==(lines.get(i).charAt(j+2))) {
						System.out.println("KR_OD "+(i+1)+" od");
						j++;
					} else {
						System.out.print("IDN "+(i+1)+" o");
						j++;
						StringBuilder sb=new StringBuilder();
						sb.append(lines.get(i).charAt(j));
						String pom=sb.toString();
						j++;
						while(!operators.contains(pom) && !brackets.contains(pom) && " ".charAt(0)!=(lines.get(i).charAt(j))) {
							sb.delete(0, sb.length());
							System.out.print(lines.get(i).charAt(j));
							if(j==lines.get(i).length()) {
								System.out.println();
								break;
							} else {
								j++;
								if(j==lines.get(i).length()) {
									break;
								}
								sb.append(lines.get(i).charAt(j));
								pom=sb.toString();
							}
						}
						if(operators.contains(pom) || brackets.contains(pom)) {
							j--;
						}
						if(j!=lines.get(i).length()) {
							System.out.println();
						}
					}
				} else {
					StringBuilder sb=new StringBuilder();
					sb.append(lines.get(i).charAt(j));
					String pom=sb.toString();
					if(numbers.contains(pom)) {
						System.out.print("BROJ "+(i+1)+" "+pom);
						sb.delete(0, sb.length());
						j++;
						if(j==lines.get(i).length()) {
							System.out.println();
							break;
						}
						sb.append(lines.get(i).charAt(j));
						pom=sb.toString();
						while(numbers.contains(pom)) {
							System.out.print(lines.get(i).charAt(j));
							sb.delete(0, sb.length());
							j++;
							if(j==lines.get(i).length()) {
								break;
							}
							sb.append(lines.get(i).charAt(j));
							pom=sb.toString();
							if(j==lines.get(i).length()) {
								System.out.println();
								break;
							}
						}
						if(j!=lines.get(i).length()) {
							j--;
						}
						System.out.println();
					} else if((lines.get(i).charAt(j)>='a' && lines.get(i).charAt(j)<='z') || (lines.get(i).charAt(j)>='A' && lines.get(i).charAt(j)<='Z')) {
						System.out.print("IDN "+(i+1)+" "+pom);
						sb.delete(0, sb.length());
						j++;
						if(j==lines.get(i).length()) {
							System.out.println();
							break;
						}
						sb.append(lines.get(i).charAt(j));
						pom=sb.toString();
						while(!operators.contains(pom) && !brackets.contains(pom) && " ".charAt(0)!=(lines.get(i).charAt(j))) {
							System.out.print(lines.get(i).charAt(j));
							if(j==lines.get(i).length()) {
								System.out.println();
								break;
							} else {
								j++;
								if(j==lines.get(i).length()) {
									break;
								}
								sb.delete(0, 0);
								sb.append(lines.get(i).charAt(j));
								pom=sb.toString();
							}
						}
						if(operators.contains(pom) || brackets.contains(pom)) {
							j--;
							System.out.println();
						} else {
							System.out.println();
						}
					}
				}
			}
		}
	}
}