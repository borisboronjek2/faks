package DisMatLab3;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class DisMatLab3 {

	public static void main(String[] args) throws FileNotFoundException {
		Scanner sc= new Scanner(System.in);
		System.out.print("Unesite ime datoteke: ");
		String dat=sc.nextLine();
		sc.close();
		File file= new File(dat);
		int brojVrhova, s;
		Scanner sc2=new Scanner(file);
		brojVrhova=sc2.nextInt();
		s=sc2.nextInt();
		int[] elementi=new int[s];
		for(int i=0;i<s;i++) {
			elementi[i]=sc2.nextInt();
		}
		sc2.close();
		boolean[][] matrix=new boolean [brojVrhova][brojVrhova];
		for(int i=1;i<=brojVrhova;i++) {
			for(int j=1;j<=brojVrhova;j++) {
				for(int k=0;k<s;k++) {
					if(Math.abs(i-j)==elementi[k]) {
						matrix[i-1][j-1]=true;
						break;
					} else {
						matrix[i-1][j-1]=false;
					}
				}
			}
		}
		int[] boje=new int [brojVrhova];
		for(int i=0;i<brojVrhova;i++) {
			boje[i]=0;
		}
		int Kromatski=0;
		int br=0;
		for(int i=1;i<=brojVrhova;i++) {
			if(bojanjeGrafa(matrix, i, br, boje, brojVrhova)) {
				Kromatski=i;
				break;
			} else {
				br=0;
			}
		}
		System.out.println("Kromatski broj zadanog grafa je "+ Kromatski);
	}
	static boolean isSafe(boolean[][] matrix, int[] boje, int brojVrhova) {
		for(int i=0;i<brojVrhova;i++) {
			for(int j=i+1;j<brojVrhova;j++) {
				if(matrix[i][j] && boje[i]==boje[j]) {
					return false;
				}
			}
		} return true;
	}
	static boolean bojanjeGrafa(boolean[][] matrix, int potencijalniKromatski, int i, int[] boje, int brojVrhova) {
		if(i==brojVrhova) {
			if(isSafe(matrix, boje, brojVrhova)) {
				return true;
			}
			return false;
		}
		for(int j=1;j<=potencijalniKromatski;j++) {
			boje[i]=j;
			if(bojanjeGrafa(matrix, potencijalniKromatski, i+1, boje, brojVrhova)) {
				return true;
			}
			boje[i]=0;
		}
		return false;
	}
}
