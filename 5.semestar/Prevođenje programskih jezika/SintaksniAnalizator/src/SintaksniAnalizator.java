import java.util.LinkedList;
import java.util.Scanner;

public class SintaksniAnalizator {

	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		LinkedList<String> lines=new LinkedList<String>();
		while (sc.hasNextLine()) {
			lines.addLast(sc.nextLine());
		}
		sc.close();
		String[][] leksickiPom=pomocno(lines);
		int countZa=0, countAz=0, errBr=0;
		boolean err=false, err2=false;
		for(int i=0;i<lines.size();i++) {
			if(leksickiPom[i][0].equals("KR_ZA")) {
				countZa++;
			} else if(leksickiPom[i][0].equals("KR_AZ")) {
				countAz++;
			}
		}
		if(countZa!=countAz) {
			err=true;
		}
		for(int i=1;i<lines.size()-1;i++) {
			if(leksickiPom[i][0].equals("OP_PRIDRUZI")) {
				if(leksickiPom[i+1][0].equals("KR_ZA") || leksickiPom[i+1][0].equals("KR_AZ") || leksickiPom[i+1][0].equals("KR_OD") || leksickiPom[i+1][0].equals("KR_DO")
						|| leksickiPom[i+1][0].equals("D_ZAGRADA")) {
					err=true;
				}
			}
		}
		if(lines.size()==2 && leksickiPom[0][0].equals("IDN") && leksickiPom[1][0].equals("OP_PRIDRUZI")) {
			err=true;
		}
		for(int i=0;i<lines.size()-1;i++) {
			if(leksickiPom[i][0].equals("IDN") && ((leksickiPom[i+1][0].equals("IDN") && leksickiPom[i][1].equals(leksickiPom[i+1][1])) || leksickiPom[i+1][0].equals("BROJ"))) {
				err2=true;
				errBr=i+1;
				break;
			} 
			if(leksickiPom[i][0].equals("KR_ZA") && leksickiPom[i+1][0].equals("KR_OD")) {
				err2=true;
				errBr=i+1;
				break;
			} 
			if(leksickiPom[i][0].equals("KR_OD") && leksickiPom[i+1][0].equals("KR_DO")) {
				err2=true;
				errBr=i+1;
				break;
			}
			if(leksickiPom[i][0].equals("KR_DO") && leksickiPom[i+1][0].equals("KR_AZ")) {
				err2=true;
				errBr=i+1;
				break;
			}
		}
		if(err2) {
			System.out.println("err "+lines.get(errBr));
		} else if(err) {
			System.out.println("err kraj");
		} else {
			Tree generativnoStablo=new Tree();
			generativnoStablo.fillTree(generativnoStablo.getRoot(), lines);
			generativnoStablo.printTree(generativnoStablo.getRoot(), 0);
		}
	}
	
	public static class Node {
		private String data;
		private LinkedList<Node> children;
		
		public Node(String data) {
			this.data=data;
			this.children=new LinkedList<Node>();
		}
		public String getData() {
			return data;
		}
		public void setData(String data) {
			this.data = data;
		}
		public LinkedList<Node> getChildren() {
			return children;
		}
		public void setChildren(LinkedList<Node> children) {
			this.children = children;
		}
	}
	
	public static class Tree {
		private Node root;
		
		public Tree() {
			this.root=new Node("<program>");
		}
		public Node getRoot() {
			return root;
		}
		public void setRoot(Node root) {
			this.root = root;
		}
		public void printTree(Node node, int level) {
			level++;
			for(int i=0;i<level-1;i++) {
				System.out.print(" ");
			}
			System.out.println(node.getData());
			if(!node.getChildren().isEmpty()) {
				for(int i=0;i<node.getChildren().size();i++) {
					printTree(node.getChildren().get(i),level);
				}
			} 
		}
		public void fillTree(Node node, LinkedList<String> leksicki) {
			if(node.getData().equals("<program>")) {
				node.getChildren().add(new Node("<lista_naredbi>"));
				fillTree(node.getChildren().get(0),leksicki);
			} else if (node.getData().equals("<lista_naredbi>")) {
				 if(leksicki.isEmpty() || leksicki.size()<2) {
					node.getChildren().add(new Node("$"));
				} else if(leksicki.get(0).contains("KR_AZ") || leksicki.isEmpty()) {
					node.getChildren().add(new Node("$"));
				} else {
					node.getChildren().add(new Node("<naredba>"));
					fillTree(node.getChildren().get(0),leksicki);
					node.getChildren().add(new Node("<lista_naredbi>"));
					fillTree(node.getChildren().get(1),leksicki);
				}
			} else if(node.getData().equals("<naredba>")) {
				String[] pom=leksicki.get(1).split(" ");
				if(pom[0].equals("OP_PRIDRUZI")) {
					node.getChildren().add(new Node("<naredba_pridruzivanja>"));
					fillTree(node.getChildren().get(0),leksicki);
				} else {												
					node.getChildren().add(new Node("<za_petlja>"));
					fillTree(node.getChildren().get(0),leksicki);
				}
			} else if(node.getData().equals("<naredba_pridruzivanja>")) {
				node.getChildren().add(new Node(leksicki.get(0)));
				leksicki.remove(0);
				node.getChildren().add(new Node(leksicki.get(0)));
				leksicki.remove(0);
				node.getChildren().add(new Node("<E>"));
				fillTree(node.getChildren().get(2), leksicki);
			} else if(node.getData().equals("<za_petlja>")) {
				node.getChildren().add(new Node(leksicki.get(0)));
				leksicki.remove(0);
				node.getChildren().add(new Node(leksicki.get(0)));
				leksicki.remove(0);
				node.getChildren().add(new Node(leksicki.get(0)));
				leksicki.remove(0);
				node.getChildren().add(new Node("<E>"));
				fillTree(node.getChildren().get(3),leksicki);
				node.getChildren().add(new Node(leksicki.get(0)));
				leksicki.remove(0);
				node.getChildren().add(new Node("<E>"));
				fillTree(node.getChildren().get(5),leksicki);
				node.getChildren().add(new Node("<lista_naredbi>"));
				fillTree(node.getChildren().get(6),leksicki);
				node.getChildren().add(new Node(leksicki.get(0)));
				leksicki.remove(0);
			} else if(node.getData().equals("<E>")) {
				node.getChildren().add(new Node("<T>"));
				fillTree(node.getChildren().get(0),leksicki);
				node.getChildren().add(new Node("<E_lista>"));
				fillTree(node.getChildren().get(1),leksicki);
			} else if(node.getData().equals("<E_lista>")) {
				if(leksicki.isEmpty()) {
					node.getChildren().add(new Node("$"));
				} else {
					String[] pom=leksicki.get(0).split(" ");
					if(pom[0].equals("OP_PLUS")) {
						node.getChildren().add(new Node(leksicki.get(0)));
						leksicki.remove(0);
						node.getChildren().add(new Node("<E>"));
						fillTree(node.getChildren().get(1),leksicki);
					} else if(pom[0].equals("OP_MINUS")) {
						node.getChildren().add(new Node(leksicki.get(0)));
						leksicki.remove(0);
						node.getChildren().add(new Node("<E>"));
						fillTree(node.getChildren().get(1),leksicki);
					} else {
						node.getChildren().add(new Node("$"));
					}
				}
			} else if(node.getData().equals("<T>")) {
				node.getChildren().add(new Node("<P>"));
				fillTree(node.getChildren().get(0),leksicki);
				node.getChildren().add(new Node("<T_lista>"));
				fillTree(node.getChildren().get(1),leksicki);
			} else if(node.getData().equals("<T_lista>")) {
				if(leksicki.isEmpty()) {
					node.getChildren().add(new Node("$"));
				} else {
					String[] pom=leksicki.get(0).split(" ");
					if(pom[0].equals("OP_PUTA")) {
						node.getChildren().add(new Node(leksicki.get(0)));
						leksicki.remove(0);
						node.getChildren().add(new Node("<T>"));
						fillTree(node.getChildren().get(1),leksicki);
					} else if(pom[0].equals("OP_DIJELI")) {
						node.getChildren().add(new Node(leksicki.get(0)));
						leksicki.remove(0);
						node.getChildren().add(new Node("<T>"));
						fillTree(node.getChildren().get(1),leksicki);
					} else {
						node.getChildren().add(new Node("$"));
					}
				}
			} else if(node.getData().equals("<P>")) {
				if(!leksicki.isEmpty()) {
					String[] pom=leksicki.get(0).split(" ");
					if(pom[0].equals("OP_PLUS")) {
						node.getChildren().add(new Node(leksicki.get(0)));
						leksicki.remove(0);
						node.getChildren().add(new Node("<P>"));
						fillTree(node.getChildren().get(1),leksicki);
					} else if(pom[0].equals("OP_MINUS")) {
						node.getChildren().add(new Node(leksicki.get(0)));
						leksicki.remove(0);
						node.getChildren().add(new Node("<P>"));
						fillTree(node.getChildren().get(1),leksicki);
					} else if(pom[0].equals("L_ZAGRADA")) {
						node.getChildren().add(new Node(leksicki.get(0)));
						leksicki.remove(0);
						node.getChildren().add(new Node("<E>"));
						fillTree(node.getChildren().get(1),leksicki);
						node.getChildren().add(new Node(leksicki.get(0)));
						leksicki.remove(0);
					} else if(pom[0].equals("IDN")) {
						node.getChildren().add(new Node(leksicki.get(0)));
						leksicki.remove(0);
					} else if(pom[0].equals("BROJ")) {
						node.getChildren().add(new Node(leksicki.get(0)));
						leksicki.remove(0);
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
}
