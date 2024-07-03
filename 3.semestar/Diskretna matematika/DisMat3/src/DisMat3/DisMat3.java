package DisMat3;

import java.io.File;
import java.util.Scanner;
import java.io.FileNotFoundException;

public class DisMat3 {

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
		int[][] matrix=new int [brojVrhova][brojVrhova];
		for(int i=1;i<=brojVrhova;i++) {
			for(int j=1;j<=brojVrhova;j++) {
				for(int k=0;k<s;k++) {
					if(Math.abs(i-j)==elementi[k]) {
						matrix[i-1][j-1]=1;
						break;
					} else {
						matrix[i-1][j-1]=0;
					}
				}
			}
		}
		int[] boje=new int[brojVrhova];
		int kromatski=0;
		for(int i=1;i<=brojVrhova;i++) {
			if(bojanjeGrafa(matrix, i, brojVrhova, boje)) {
				kromatski=i;
				break;
			}
		}
		System.out.println("Kromatski broj zadanog grafa je "+ kromatski);
		for(int i=0;i<brojVrhova;i++) {
			for(int j=0;j<brojVrhova;j++) {
				System.out.print(matrix[i][j]);
			}
			System.out.println();
		}
		int SumBridova=0;
		for(int i=0;i<brojVrhova;i++) {
			for(int j=i+1;j<brojVrhova;j++) {
				if(matrix[i][j]==1) {
					SumBridova++;
				}
			}
		}
		System.out.print(SumBridova);
	}
	static boolean isSafe(int v, int matrix[][], int boje[], int b, int brojVrhova) {
		for(int i=0;i<brojVrhova;i++) {
			if(matrix[v][i]==1 && b==boje[i]) {
				return false;
			}
		}
		return true;
	}
	static boolean bojanjeGrafaUtil(int matrix[][], int m, int boje[], int v, int brojVrhova) {
		if(v==brojVrhova) return true;
		for(int c=1;c<=m;c++) {
			if(isSafe(v, matrix, boje, c, brojVrhova)) {
				boje[v]=c;
				if(bojanjeGrafaUtil(matrix, m, boje, v+1, brojVrhova)) {
					return true;
				}
				boje[v]=0;
			}
		}
		return false;
	}
	static boolean bojanjeGrafa(int matrix[][], int m, int brojVrhova, int boje[]) {
		for(int i=0;i<brojVrhova;i++) {
			boje[i]=0;
		}
		if(!bojanjeGrafaUtil(matrix, m, boje, 0, brojVrhova)) {
			return false;
		}
		return true;
	}
}
