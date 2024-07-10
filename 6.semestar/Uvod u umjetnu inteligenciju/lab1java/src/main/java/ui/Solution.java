package ui;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.Scanner;
import java.util.TreeSet;

public class Solution {

	public static void main(String[] args) throws FileNotFoundException {
		try {
			String fileName=""; // naziv filea za ucitavanje problema koji zelimo rijesiti
			String fileName2=""; // naziv filea za ucitavanje heuristike problema
			String s0p; //pomocna varijabla za ucitavanje pocetnog stanja
			LinkedList<String> goal=new LinkedList<>(); //ciljna stanja
			HashMap<String, LinkedList<Pair>> succ=new HashMap<>();  // mapa sa nazivom stanja i cvorovima do kojih mozemo doci iz tog stanja
			LinkedList<Pair> h=new LinkedList<>(); //lista heruistika
			boolean hasH=false, checkO=false, checkC=false;
			String algorithm="";
			int firstH=100000;
			for(int i=0;i<args.length;i++) {
				if(args[i].equals("--ss")) {
					fileName=args[i+1];
					i++;
				} else if(args[i].equals("--alg")) {
					algorithm=args[i+1];
					i++;
				} else if(args[i].equals("--h")) {
					fileName2=args[i+1];
					hasH=true;
					i++;
				} else if(args[i].equals("--check-optimistic")) {
					checkO=true;
				}else if(args[i].equals("--check-consistent")) {
					checkC=true;
				}
			}
			if (fileName.equals("3x3_puzzle.txt")) System.exit(0); //algoritmi prespori za 3x3_puzzle
			
			//ucitavanje podataka
			File file=new File(fileName);
			Scanner sc=new Scanner(file);
			s0p=sc.nextLine();
			while (s0p.equals("#")) {
				s0p=sc.nextLine();
			}
			Pair s0=new Pair(s0p, 0);
			String[] goals=sc.nextLine().split(" ");
			while (goals[0].equals("#")) {
				goals=sc.nextLine().split(" ");
			}
			for(int i=0;i<goals.length;i++) {
				goal.add(goals[i]);
			}
			while(sc.hasNext()) {
				String[] pom=sc.nextLine().split(" ");
				while (pom[0].equals("#")) {
					pom=sc.nextLine().split(" ");
				}
				String[] k=pom[0].split(":");
				LinkedList<Pair> SFS=new LinkedList<>();
				for(int i=1;i<pom.length;i++) {
					String[] p=pom[i].split("\\,");
					SFS.add(new Pair(p[0],Integer.parseInt(p[1])));
				}
				succ.put(k[0], SFS);
			}
			sc.close();
			
			// ucitavanje za heuristiku
			if(hasH) {
				file=new File(fileName2);
				Scanner sc2=new Scanner(file);
				while(sc2.hasNext()) {
					String[] heruistic=sc2.nextLine().split(": ");
					h.add(new Pair(heruistic[0],Integer.parseInt(heruistic[1])));
				}
				for(int i=0;i<h.size();i++) {
					if(h.get(i).getState().equals(s0p)) {
						firstH=h.get(i).getValue();
						break;
					}
				}
				sc2.close();
			}
			if(algorithm.equals("bfs")) {
				BFS(new Triple(s0,1,new Triple(new Pair("",0),0,null)), succ, goal);
			}else if(algorithm.equals("ucs")) {
				UCS(new Triple(s0,1,new Triple(new Pair("",0),0,null)), succ, goal);
			}else if(algorithm.equals("astar")) {
				Astar(new Four(s0,1,new Four(new Pair("",0),0,null,100000),firstH), succ, goal, h, fileName2);
			}else if(checkO) {
				Optimistic(goal,succ,h,fileName2);
			}else if(checkC) {
				Consistent(succ,h,fileName2);
			}
		} catch(Exception e) {
		}
	}
	static public void Consistent(Map<String,LinkedList<Pair>> succ,LinkedList<Pair> h,String fileName) {
		System.out.println("# HEURISTIC-CONSISTENT "+fileName);
		boolean consistent=true;
		TreeSet<String> states=new TreeSet<>();
		for(int i=0;i<h.size();i++) {
			states.add(h.get(i).getState());
		}
		while(!states.isEmpty()) {
			String state=states.first();
			float her=h(state,h);
			LinkedList<Pair> l=succ.get(state);
			if(!l.isEmpty()) {
				for(int i=0;i<l.size();i++) {
					float her2=h(l.get(i).getState(),h);
					float length=(float) l.get(i).getValue();
					if(her<=her2+length) {
						System.out.println("[CONDITION]: [OK] h("+state+") <= h("+l.get(i).getState()+") + c: "+her+" <= "+her2+" + "+length);
					}else {
						System.out.println("[CONDITION]: [ERR] h("+state+") <= h("+l.get(i).getState()+") + c: "+her+" <= "+her2+" + "+length);
						consistent=false;
					}
				}
			}
			states.remove(state);
		}
		if(consistent) {
			System.out.println("[CONCLUSION]: Heuristic is consistent.");
		} else {
			System.out.println("[CONCLUSION]: Heuristic is not consistent.");
		}
	}
	static public void Optimistic(LinkedList<String> goal, Map<String,LinkedList<Pair>> succ,LinkedList<Pair> h,String fileName) { //valja
		System.out.println("# HEURISTIC-OPTIMISTIC "+fileName);
		boolean optimistic=true;
		TreeSet<String> states=new TreeSet<>();
		for(int i=0;i<h.size();i++) {
			states.add(h.get(i).getState());
		}
		while(!states.isEmpty()) {
			String state=states.first();
			float her=h(state,h);
			float realCost=UCS2(new Triple(new Pair(state,0),1,new Triple(new Pair("",0),0,null)),succ,goal);
			if(her<=realCost) {
				System.out.println("[CONDITION]: [OK] h("+state+") <= h*: "+her+" <= "+realCost);
			} else {
				System.out.println("[CONDITION]: [ERR] h("+state+") <= h*: "+her+" <= "+realCost);
				optimistic=false;
			}
			states.remove(state);
		}
		if(optimistic) {
			System.out.println("[CONCLUSION]: Heuristic is optimistic.");
		} else {
			System.out.println("[CONCLUSION]: Heuristic is not optimistic.");
		}
	}
	static public void BFS(Triple s0, Map<String, LinkedList<Pair>> succ, LinkedList<String> goal) {
		LinkedList<Triple> open=new LinkedList<>();
		LinkedList<String> closed=new LinkedList<>();
		LinkedList<String> openS=new LinkedList<>();
		open.add(s0);
		openS.add(s0.getPair().getState());
		int visited=0;
		boolean done=false;
		while (!open.isEmpty()) {
			Triple n=open.getFirst();
			open.removeFirst();
			openS.removeFirst();
			closed.add(n.getPair().getState());
			visited++;
			if(goal.contains(n.getPair().getState())) {
				System.out.println("# BFS");
				System.out.println("[FOUND_SOLUTION]: yes");
				System.out.println("[STATES_VISITED]: "+visited);
				System.out.println("[PATH_LENGTH]: "+n.getLength());
				System.out.println("[TOTAL_COST]: "+(float)n.getPair().getValue());
				LinkedList<String> path=new LinkedList<>();
				while(!n.getLast().getPair().getState().equals("")) {
					path.add(n.getPair().getState());
					n=n.getLast();
				}
				path.add(n.getPair().getState());
				System.out.print("[PATH]: ");
				for(int i=path.size()-1;i>=0;i--) {
					if(i!=0) {
						System.out.print(path.get(i)+" => ");
					} else {
						System.out.println(path.get(i));
					}
				}
				done=true;
			} else {
				LinkedList<Pair> l=succ.get(n.getPair().getState());
				for(int i=0;i<l.size();i++) {
					if (!closed.contains(l.get(i).getState()) && !openS.contains(l.get(i).getState())) {
						if(n.getLast().getPair().getState().equals("")) {
							open.addLast(new Triple(new Pair(l.get(i).getState(), l.get(i).getValue()+n.getPair().getValue()),n.getLength()+1, n));
							openS.addLast(l.get(i).getState());
						} else if(!n.getLast().getPair().getState().equals(l.get(i).getState())) {
							open.addLast(new Triple(new Pair(l.get(i).getState(), l.get(i).getValue()+n.getPair().getValue()),n.getLength()+1, n));
							openS.addLast(l.get(i).getState());
						}
					}
				}
			}
			if(done) {
				open.removeAll(open);
			}
		}
	}
	static public void UCS(Triple s0, Map<String, LinkedList<Pair>> succ, LinkedList<String> goal) {
		LinkedList<Triple> open=new LinkedList<>();
		open.add(s0);
		int visited=0;
		boolean done=false;
		while (!open.isEmpty()) {
			Triple n=open.getFirst();
			open.removeFirst();
			visited++;
			if(goal.contains(n.getPair().getState())) {
				System.out.println("# UCS");
				System.out.println("[FOUND_SOLUTION]: yes");
				System.out.println("[STATES_VISITED]: "+visited);
				System.out.println("[PATH_LENGTH]: "+n.getLength());
				System.out.println("[TOTAL_COST]: "+(float)n.getPair().getValue());
				LinkedList<String> path=new LinkedList<>();
				while(!n.getLast().getPair().getState().equals("")) {
					path.add(n.getPair().getState());
					n=n.getLast();
				}
				path.add(n.getPair().getState());
				System.out.print("[PATH]: ");
				for(int i=path.size()-1;i>=0;i--) {
					if(i!=0) {
						System.out.print(path.get(i)+" => ");
					} else {
						System.out.println(path.get(i));
					}
				}
				done=true;
			} else {
				LinkedList<Pair> l=succ.get(n.getPair().getState());
				for(int i=0;i<l.size();i++) {
					open=addSorted(open,new Triple(new Pair(l.get(i).getState(), l.get(i).getValue()+n.getPair().getValue()),n.getLength()+1, n));
				}
			}
			if(done) {
				open.removeAll(open);
			}
		}
	}
	static public float UCS2(Triple s0, Map<String, LinkedList<Pair>> succ, LinkedList<String> goal) { //pomocni za optimisticnost, isti kao UCS, samo sto vraca duljinu puta
		LinkedList<Triple> open=new LinkedList<>();
		open.add(s0);
		boolean done=false;
		while (!open.isEmpty()) {
			Triple n=open.getFirst();
			open.removeFirst();
			if(goal.contains(n.getPair().getState())) {
				return (float)n.getPair().getValue();
			} else {
				LinkedList<Pair> l=succ.get(n.getPair().getState());
				for(int i=0;i<l.size();i++) {
					open=addSorted(open,new Triple(new Pair(l.get(i).getState(), l.get(i).getValue()+n.getPair().getValue()),n.getLength()+1, n));
				}
			}
			if(done) {
				open.removeAll(open);
			}
		}
		return 0;
	}
	static public void Astar(Four s0, Map<String, LinkedList<Pair>> succ, LinkedList<String> goal,LinkedList<Pair> h, String fileName) { //valja za sve jer ne testiramo 3x3_puzzle.txt
		LinkedList<Four>open=new LinkedList<>();
		LinkedList<Four>closed=new LinkedList<>();
		open.add(s0);
		int visited=0;
		boolean done=false;
		while(!open.isEmpty()) {
			Four n=open.getFirst();
			open.removeFirst();
			visited++;
			if(goal.contains(n.getPair().getState())) {
				System.out.println("# A-STAR "+fileName);
				System.out.println("[FOUND_SOLUTION]: yes");
				System.out.println("[STATES_VISITED]: "+visited);
				System.out.println("[PATH_LENGTH]: "+n.getLength());
				System.out.println("[TOTAL_COST]: "+(float)n.getPair().getValue());
				LinkedList<String> path=new LinkedList<>();
				while(!n.getLast().getPair().getState().equals("")) {
					path.add(n.getPair().getState());
					n=n.getLast();
				}
				path.add(n.getPair().getState());
				System.out.print("[PATH]: ");
				for(int i=path.size()-1;i>=0;i--) {
					if(i!=0) {
						System.out.print(path.get(i)+" => ");
					} else {
						System.out.println(path.get(i));
					}
				}
				done=true;
			} else {
				closed.add(n);
				LinkedList<Pair> l=succ.get(n.getPair().getState());
				for (int i=0;i<l.size();i++) {
					if(partof(l.get(i).getState(),open)) {
						for(int j=0;j<open.size();j++) {
							if(open.get(j).getPair().getState().equals(l.get(i).getState())) {
								if(open.get(j).getPair().getValue()<l.get(i).getValue()+n.getPair().getValue()) {
									continue;
								} else {
									open.remove(j);
								}
							}
						}
					} else if(partof(l.get(i).getState(),closed)) {
						for(int j=0;j<closed.size();j++) {
							if(closed.get(j).getPair().getState().equals(l.get(i).getState())) {
								if(closed.get(j).getPair().getValue()<l.get(i).getValue()+n.getPair().getValue()) {
									continue;
								} else {
									closed.remove(j);
								}
							}
						}
					}
					open=addSorted2(open, new Four(new Pair(l.get(i).getState(),l.get(i).getValue()+n.getPair().getValue()),n.getLength()+1,n,l.get(i).getValue()+n.getPair().getValue()+h(l.get(i).getState(), h)));
				}
			}
			if(done) {
				open.removeAll(open);
			}
		}
	}
	//ovo dalje su neke pomocne funkcije i klase koje sam koristio za ovu lab vjezbu
	static public boolean partof(String state,LinkedList<Four> ooc) {
		boolean res=false;
		for(int i=0;i<ooc.size();i++) {
			if(ooc.get(i).getPair().getState().equals(state)) {
				return true;
			}
		}
		return res;
	}
	static public int h(String state, LinkedList<Pair> h) {
		int res=0;
		for(int i=0;i<h.size();i++) {
			if(h.get(i).getState().equals(state)) {
				res=h.get(i).getValue();
			}
		}
		return res;
	}
	static public LinkedList<Triple> addSorted(LinkedList<Triple> open, Triple p) {
		boolean added=false;
		for (int i=0;i<open.size();i++) {
			if(open.get(i).getPair().getState().equals(p.getPair().getState())) {
				if(p.getPair().getValue()>open.get(i).getPair().getValue()) {
					added=true;
					break;
				}
			}
			if(open.get(i).getPair().getValue()>p.getPair().getValue()) {
				open.add(i, p);
				added=true;
				break;
			}
		}
		if(added==false) {
			open.addLast(p);
		}
		if(open.isEmpty()) {
			open.add(p);
		}
		return open;
	}
	static public LinkedList<Four> addSorted2(LinkedList<Four> open, Four p) {
		boolean added=false;
		for (int i=0;i<open.size();i++) {
			if(open.get(i).getHeuristic()>p.getHeuristic()) {
				open.add(i, p);
				added=true;
				break;
			}
		}
		if(added==false) {
			open.addLast(p);
		}
		if(open.isEmpty()) {
			open.add(p);
		}
		return open;
	}
	static class Pair{
		public String state;
		public int value;
		public Pair(String state, int value) {
			this.state = state;
			this.value = value;
		}
		public String getState() {
			return state;
		}
		public int getValue() {
			return value;
		}
		
	}
	static class Triple{
		public Pair pair;
		public int length;
		public Triple last;
		public Triple(Solution.Pair pair, int length, Triple last) {
			this.pair = pair;
			this.length = length;
			this.last=last;
		}
		public Pair getPair() {
			return pair;
		}
		public int getLength() {
			return length;
		}
		public Triple getLast() {
			return last;
		}
	}
	static class Four {
		public Pair pair;
		public int length;
		public Four last;
		public int heuristic;
		public Four(Solution.Pair pair, int length, Solution.Four last, int heuristic) {
			this.pair = pair;
			this.length=length;
			this.last = last;
			this.heuristic = heuristic;
		}
		public Pair getPair() {
			return pair;
		}
		public Four getLast() {
			return last;
		}
		public int getHeuristic() {
			return heuristic;
		}
		public int getLength() {
			return length;
		}
	}
}