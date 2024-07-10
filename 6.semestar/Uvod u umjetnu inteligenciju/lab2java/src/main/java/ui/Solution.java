package ui;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Scanner;
import java.util.Set;
import java.util.function.Predicate;

public class Solution {

    public static void main(String[] args) throws FileNotFoundException {
    	try {
	        String clausesPath = "";
	        String inputPath = "";
	        boolean cooking = false;
	        
	        if(args[0].equals("resolution")) {
	        	clausesPath = args[1];
	        } else if (args[0].equals("cooking")) {
	        	clausesPath=args[1];
	        	inputPath=args[2];
	        	cooking=true;
	        }
	        
	        if (cooking) {
	            Scanner sc2 = new Scanner(new File(inputPath));
	            List<String> newAtomList = new ArrayList<>();
	            List<String> command = new ArrayList<>();
	            while(sc2.hasNextLine()) {
	            	String data = sc2.nextLine();
	            	newAtomList.add(data.substring(0, data.length()-2).toLowerCase());
	            	command.add(data.substring(data.length()-1, data.length()));
	            }
	            List<PairClauses> changeClauses = new ArrayList<>();
	            for(int i=0;i<newAtomList.size();i++) {
	            	if(command.get(i).equals("+")) {
	            		Set<Atom> atoms = new HashSet<>();
	                    for (String atom : newAtomList.get(i).split(" v ")) {
	                        Boolean isTrue = !atom.contains("~");
	                        if(isTrue) {
	    						Atom newAtom = new Atom(atom, isTrue);
	    						atoms.add(newAtom);
	    					} else {
	    						Atom newAtom = new Atom(atom.substring(1,atom.length()), isTrue);
	    						atoms.add(newAtom);
	    					}
	                    }
	                    changeClauses.add(new PairClauses(new Clause(atoms), true));
	            	} else if (command.get(i).equals("-")) {
	            		Set<Atom> atoms = new HashSet<>();
	                    for (String atom : newAtomList.get(i).toLowerCase().split(" v ")) {
	                        Boolean isTrue = !atom.contains("~");
	                        if(isTrue) {
	    						Atom newAtom = new Atom(atom, isTrue);
	    						atoms.add(newAtom);
	    					} else {
	    						Atom newAtom = new Atom(atom.substring(1,atom.length()), isTrue);
	    						atoms.add(newAtom);
	    					}
	                    }
	                    changeClauses.add(new PairClauses(new Clause(atoms), false));
	            	} else if (command.get(i).equals("?")) {
	            		Resolution resolution = new Resolution();
	            		resolution.loadClausesForCooking(clausesPath);
	            		for(PairClauses pairClauses : changeClauses) {
	            			if(pairClauses.addClause) {
	            				resolution.clauses.add(pairClauses.clause);
	            				System.out.println("ADDED: " + pairClauses.clause.toString());
	            			} else {
	            				resolution.clauses.remove(pairClauses.clause);
	            				System.out.println("REMOVED: " + pairClauses.clause.toString());
	            			}
	            		}
	            		Set<Atom> atoms = new HashSet<>();
	                    for (String atom : newAtomList.get(i).toLowerCase().split(" v ")) {
	                        Boolean isTrue = !atom.contains("~");
	                        if(isTrue) {
	    						Atom newAtom = new Atom(atom, isTrue);
	    						atoms.add(newAtom);
	    					} else {
	    						Atom newAtom = new Atom(atom.substring(1,atom.length()), isTrue);
	    						atoms.add(newAtom);
	    					}
	                    }
	            		resolution.goalClause=new Clause(atoms);
	            		if (resolution.goalClause.atoms.size() > 1) {
	                        for (Atom atom : resolution.goalClause.atoms) {
	                            Set<Atom> atomList = new HashSet<>();
	                            atomList.add(atom);
	                            resolution.setOfSupport.add(new Clause(atomList).negate());
	                        }
	                    } else {
	                        resolution.setOfSupport.add(resolution.goalClause.negate());
	                    }
	                    System.out.println(resolution.br + "." + resolution.goalClause.negate());
	                    System.out.println("===========");
	            		boolean conclusion = resolution.plResolution();
	            		
	    		        System.out.println("===========");
	    		        if(conclusion) {
	    		        	System.out.println("[CONCLUSION]: " + resolution.goalClause.toString() + " is true");
	    		        } else {
	    		        	System.out.println("[CONCLUSION]: " + resolution.goalClause.toString() + " is unknown");
	    		        }
	    		        System.out.println();
	            	}
	            }
	        } else {
		        Resolution resolution = new Resolution();
		        resolution.loadClauses(clausesPath);
		        boolean conclusion = resolution.plResolution();
		
		        System.out.println("===========");
		        if(conclusion) {
		        	System.out.println("[CONCLUSION]: " + resolution.goalClause.toString() + " is true");
		        } else {
		        	System.out.println("[CONCLUSION]: " + resolution.goalClause.toString() + " is unknown");
		        }
	        }
	
	        
    	} catch(Exception e) {
    		
    	}
    }
    
    private static class Atom {
        String variable;
        Boolean isTrue;

        public Atom(String variable, Boolean isTrue) {
            this.variable = variable;
            this.isTrue = isTrue;
        }

        @Override
        public boolean equals(Object o) {
            Atom atom = (Atom) o;
            return (Objects.equals(variable, atom.variable) && Objects.equals(isTrue, atom.isTrue));
        }

        @Override
        public int hashCode() {
            return Objects.hash(variable, isTrue);
        }

        @Override
        public String toString() {
            return
                    (isTrue ? "": "~") +
                    this.variable.toString();
        }
        public Atom negate() {
            return new Atom(this.variable, !isTrue);
        }
    }
    private static class PairClauses{
    	Clause clause;
    	boolean addClause;
    	public PairClauses(Clause clause, boolean addClause) {
    		this.clause = clause;
    		this.addClause = addClause;
    	}
    }
    
    private static class Pair <T> {
        T first;
        T second;

        public Pair(T first, T second) {
            this.first = first;
            this.second = second;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            Pair<?> pair = (Pair<?>) o;
            return Objects.equals(first, pair.first) && Objects.equals(second, pair.second);
        }

        @Override
        public int hashCode() {
            return Objects.hash(first, second);
        }
    }
    
    private static class Clause {
        Set<Atom> atoms;
        Pair<Clause> parentPair;

        public Clause(Set<Atom> atoms) {
            this.atoms = atoms;
            this.parentPair = null;
        }

        public Clause(Set<Atom> atoms, Pair<Clause> parentPair) {
            this.atoms = atoms;
            this.parentPair = parentPair;
        }

        @Override
        public String toString() {
            String rez = "";
            int i = 0;
            for (Atom atom : atoms) {
                rez += atom;
                if (i != atoms.size() - 1) {
                    rez += " v ";
                }
                i++;
            }
            return rez;
        }

        public Clause negate() {
            List<Atom> negatedAtoms = new ArrayList<>();
            for (Atom atom : this.atoms) {
                negatedAtoms.add(atom.negate());
            }

            Set<Atom> negatedAtomsSet = new HashSet<>();
            negatedAtomsSet.addAll(negatedAtoms);
            Clause negatedClause = new Clause(negatedAtomsSet);
            return negatedClause;
        }

        @Override
        public boolean equals(Object o) {
            Clause clause = (Clause) o;
            return Objects.equals(atoms, clause.atoms);
        }

        @Override
        public int hashCode() {
            return Objects.hash(atoms);
        }
    }
    
    private static class Resolution {
        public Set<Clause> clauses;
        public Set<Pair<Clause>> resolvedPairs;
        public Set<Clause> setOfSupport;
        public Clause goalClause;
        public Map<Clause, Integer> number;
        public int br = 1;

        public Resolution() {
            this.clauses = new HashSet<>();
            this.resolvedPairs = new HashSet<>();
            this.setOfSupport = new HashSet<>();
            this.goalClause = null;
            this.number = new HashMap<>();
        }


        public Boolean plResolution() {
        	number.put(goalClause.negate(), br++);
            clauses.add(goalClause.negate());
            while (true) {
                List<Clause> newClauses = new ArrayList<>();
                for (Pair<Clause> clausePair : selectClauses()) {
                    List<Clause> resolvents = plResolve(clausePair);
                    for (Clause c : resolvents) {
                        if (c.atoms.contains(new Atom("NIL", true))) {
                            clauses.add(c);
                            number.put(c, br++);
                            System.out.println(number.get(c) + ". " + c.toString() + " (" + c.parentPair.first.toString() + "," + c.parentPair.second.toString() + ")");
                            return true;
                        }
                    }
                    setOfSupport.addAll(resolvents);
                    newClauses.addAll(resolvents);
                }
                if (clauses.containsAll(newClauses))
                    return false;

                for(Clause nClause : newClauses) {
                	if(!clauses.contains(nClause)) {
                		clauses.add(nClause);
	                	number.put(nClause, br++);
	                	System.out.println(number.get(nClause) + ". " + nClause.toString() + " (" + nClause.parentPair.first.toString() + "," + nClause.parentPair.second.toString() + ")");
                	}
                }
            }
        }


        private List<Clause> plResolve(Pair<Clause> clausePair) {
            Clause c1 = clausePair.first;
            Clause c2 = clausePair.second;
            List<Clause> resolvents = new ArrayList<>();

            resolvedPairs.add(new Pair<>(c1,c2));

            Set<Atom> newAtoms = new HashSet<>();

            if (c1.equals(c2.negate())) {
                if (c1.atoms.size() > 1) {
                    return resolvents;
                }
                newAtoms.add(new Atom("NIL", true));
                resolvents.add(new Clause(newAtoms, clausePair));
                return resolvents;
            }
            newAtoms.addAll(c1.atoms);
            newAtoms.addAll(c2.atoms);

            Boolean minimised = false;

            for (Atom atom : c1.atoms) {
                if (c2.atoms.contains(atom.negate())) {
                    newAtoms.removeIf(new Predicate<Atom>() {
                        @Override
                        public boolean test(Atom a) {
                            if (a.equals(atom) || a.equals(atom.negate()))
                                return true;
                            return false;
                        }
                    });
                    minimised = true;
                }
            }
            if (!minimised) {
                return resolvents;
            }
            else {
                resolvents.add(new Clause(newAtoms, clausePair));
                return resolvents;
            }
        }

        public List<Pair<Clause>> selectClauses() {
            List<Pair<Clause>> selectedClauses = new ArrayList<>();
            for (Clause sosClause : setOfSupport) {
                for (Clause clause : clauses) {
                    if (!sosClause.equals(clause) && !resolvedPairs.contains(new Pair<>(sosClause, clause))) {
                    	selectedClauses.add(new Pair<>(sosClause, clause));
                    }
                }
            }

            return selectedClauses;
        }

        public void loadClauses(String clausesPath) throws FileNotFoundException {
            Scanner sc = new Scanner(new File(clausesPath));

            while (sc.hasNextLine()) {
                String input = sc.nextLine();
                if (input.charAt(0)=='#') {
                    continue;
                }
                Set<Atom> atoms = new HashSet<>();
                for (String atom : input.toLowerCase().split(" v ")) {
                    Boolean isTrue = !atom.contains("~");
                    if(isTrue) {
						Atom newAtom = new Atom(atom, isTrue);
						atoms.add(newAtom);
					} else {
						Atom newAtom = new Atom(atom.substring(1,atom.length()), isTrue);
						atoms.add(newAtom);
					}
                }
                if (!sc.hasNextLine()) {
                    goalClause = (new Clause(atoms));
                    break;
                }
                Boolean tautology = false;
                for (Atom atom : atoms) {
                    if (atoms.contains(atom.negate())) {
                        tautology = true;
                    }

                }
                if (!tautology) {
                	Clause nClause = new Clause(atoms);
                    clauses.add(nClause);
                    number.put(nClause, br++);
                    System.out.println(number.get(nClause) + ". " + nClause.toString());
                }
            }
            if (goalClause.atoms.size() > 1) {
                for (Atom atom : goalClause.atoms) {
                    Set<Atom> atomList = new HashSet<>();
                    atomList.add(atom);
                    setOfSupport.add(new Clause(atomList).negate());
                }
            } else {
            	setOfSupport.add(goalClause.negate());
            }
            System.out.println(br + "." + goalClause.negate());
            System.out.println("===========");
        }
        
        public void loadClausesForCooking(String dataPathClauses) throws FileNotFoundException {
            Scanner sc = new Scanner(new File(dataPathClauses));

            while (sc.hasNextLine()) {
                String input = sc.nextLine();
                if (input.charAt(0)=='#') {
                    continue;
                }
                Set<Atom> atoms = new HashSet<>();
                for (String atom : input.toLowerCase().split(" v ")) {
                    Boolean isTrue = !atom.contains("~");
                    if(isTrue) {
						Atom newAtom = new Atom(atom, isTrue);
						atoms.add(newAtom);
					} else {
						Atom newAtom = new Atom(atom.substring(1,atom.length()), isTrue);
						atoms.add(newAtom);
					}
                }
                Boolean tautology = false;
                for (Atom atom : atoms) {
                    if (atoms.contains(atom.negate())) {
                        tautology = true;
                    }

                }
                if (!tautology) {
                	Clause nClause = new Clause(atoms);
                    clauses.add(nClause);
                    number.put(nClause, br++);
                    System.out.println(number.get(nClause) + ". " + nClause.toString());
                }
            }
        }
    }

}
