package DisMatLab2;
import java.util.LinkedList;
import java.util.Scanner;

public class DisMatLab2 {

	public static void main(String[] args) {
		
		Scanner sc = new Scanner(System.in);
		System.out.print("Unesite redom, odvojene razmakom, parametre n, a i b: ");
		int n = sc.nextInt();
		int a = sc.nextInt();
		int b = sc.nextInt();
		int k, l;
		sc.close();
		int[][] tezine = new int[n][n];
		for(k = 0; k < n; k++) {
			for(l = 0; l < n; l++) {
				if(k < l) {
					tezine[k][l] = (int) (Math.pow((a*(k+1)+b*(l+1)), 2) + 1);
				}else {
					tezine[k][l] = 0;
				}
			}
		}
		for(k = 0; k < n; k++) {
			for(l = 0; l < n; l++) {
				tezine[l][k] = tezine[k][l];
			}
		}
		int pocetak=0, tez=10000;
		for (int i=0;i<n;i++) {
			for(int j=0;j<n;j++) {
				if(tezine[i][j]!=0 && tezine[i][j]<tez) {
					pocetak=k;
				}
			}
		}
		LinkedList<Integer> used = new LinkedList<>();
		used.add(0);
		int min = pohlepni(pocetak, 0, n, 0, tezine, used);
		for(int i = 0; i < n; i++) {
			used.add(i);
			int current = pohlepni(i, 0, n, 0, tezine, used);
			if(min > current) {
				min = current;
			}
		}
		System.out.println("Pohlepni algoritam nalazi ciklus duljine "+ min);
		boolean[] v= new boolean[n];
		v[0]=true;
		int ans=10000000;
		ans=iscrpni(tezine, v, 0, n, 1, 0, ans);
		System.out.println("Iscrpni algoritam nalazi ciklus duljine "+ ans);
		if(min==ans) {
			System.out.println("Pohlepni algoritam na ovom grafu daje optimalno rješenje!");
		} else {
			System.out.println("Pohlepni algoritam na ovom grafu ne daje optimalno rješenje!");
		}
	}
	
	public static int pohlepni(int k, int brojPonavljanja, int n, int sum, int[][] tezine, LinkedList<Integer> used) {
		int index=k;
		int min=10000000;
		if(brojPonavljanja == n - 1) {
			int startingIndex = used.getFirst();
			sum += tezine[k][startingIndex];
			used.clear();
			return sum;
		}
		for(int l = 0; l < n; l++) {
			if(tezine[k][l] != 0 && !used.contains(l)) {
				if(min > tezine[k][l]) {
					min = tezine[k][l];
					index = l;
				}
			}
		}
		sum += min;
		brojPonavljanja++;
		used.add(index);
		return pohlepni(index, brojPonavljanja, n, sum, tezine, used);
	}
	
	public static int iscrpni(int[][] tezine, boolean[] v, int currPos, int n, int count, int cost, int ans) {
		if (count==n && tezine[currPos][0]>0) {
			ans=Math.min(ans, cost+tezine[currPos][0]);
			return ans;
		}
		for(int i=0;i<n;i++) {
			if(v[i]==false && tezine[currPos][i]>0) {
				v[i]=true;
				ans=iscrpni(tezine, v, i, n, count+1, cost+tezine[currPos][i], ans);
				v[i]=false;
			}
		}
		return ans;
	}
}
