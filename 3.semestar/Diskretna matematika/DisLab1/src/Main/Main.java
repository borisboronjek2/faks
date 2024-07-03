package Main;

import java.util.Scanner;

public class Main {
	
	static double f(double l1, double l2, double a0, double a1, int n) {
		if (n==0)
			return a0;
		else if(n==1)
			return a1;
		else
			return l1*f(l1, l2, a0, a1, n-1) + l2*f(l1, l2, a0, a1, n-2);
	}
	
	static double homogeno(double l1, double l2, double a0, double a1, int n) {
		double x1, x2;
		x1=(l1+Math.sqrt(Math.pow(l1, 2)+4*l2))/2;
		x2=(l1-Math.sqrt(Math.pow(l1, 2)+4*l2))/2;
		double nl1, nl2;
		if(x1==x2) {
			nl1=a0;
			nl2=a1-nl1*x1;
			return nl1*Math.pow(x1, n) + nl2*n*Math.pow(x2, n);
		} else {
			nl2=(a1-x1*a0)/(x2-x1);
			nl1=(a0-nl2);
			return nl1*Math.pow(x1, n) + nl2*Math.pow(x2, n);
		}
	}

	public static void main(String[] args) {
		double l1, l2, a0, a1;
		int n;
		Scanner scanner= new Scanner(System.in);
		System.out.print("Unesite prvi koeficijent l_1 rekurzivne relacije: ");
		l1=scanner.nextDouble();
		System.out.print("Unesite drugi koeficijent l_2 rekurzivne relacije: ");
		l2=scanner.nextDouble();
		System.out.print("Unesite vrijednost nultog clana niza a_0: ");
		a0=scanner.nextDouble();
		System.out.print("Unesite vrijednost prvog clana niza a_1: ");
		a1=scanner.nextDouble();
		System.out.print("Unesite redni broj n trazenog clana niza: ");
		n=scanner.nextInt();
		System.out.println("Vrijednost n-tog clana niza pomocu formule: " + homogeno(l1, l2, a0, a1, n));
		System.out.println("Vrijednost n-tog clana niza iz rekurzije: " + f(l1, l2, a0, a1, n));
		System.out.println("Vrijednost (n-2)-clana niza pomocu formule: " + homogeno(l1, l2, a0, a1, n-2));
		if(homogeno(l1, l2, a0, a1, n-2)==homogeno(l1, l2, a0, a1, n)) {
			System.out.println("(n-2)-clan je jednak od n-tog clana.");
		} else if(homogeno(l1, l2, a0, a1, n-2)<=homogeno(l1, l2, a0, a1, n)) {
			System.out.println("(n-2)-clan je manji od n-tog clana.");
		} else
			System.out.println("(n-2)-clan je veci od n-tog clana.");
	}

}
