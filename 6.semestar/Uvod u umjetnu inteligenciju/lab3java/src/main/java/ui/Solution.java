package ui;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;

public class Solution {

	public static void main(String[] args) throws FileNotFoundException {
        List<Data> TrainingData = new ArrayList<>();
        List<Data> TestData = new ArrayList<>();
        int k = -1;
        Set<String> attributes = new HashSet<>();
        
        // Priprema podataka
        String TrainingDataPath=args[0];
        String TestDataPath=args[1];
        if(args.length==3) k=Integer.parseInt(args[2]);
        Scanner sc = new Scanner(new File(TrainingDataPath));
        String[] str = sc.nextLine().split(",");
        List<String> names = new ArrayList<>();
        for(int i=0;i<str.length-1;i++) {
        	names.add(str[i]);
        	attributes.add(str[i]);
        }
        
        while(sc.hasNextLine()) {
        	Map<String, String> m = new LinkedHashMap<>();
        	String[] str2 = sc.nextLine().split(",");
        	for(int i=0;i<str2.length-1;i++) {
        		m.put(names.get(i), str2[i]);
        	}
        	TrainingData.add(new Data(m, str2[str2.length-1]));
        }
        sc.close();
        
        
        Scanner sc2 = new Scanner(new File(TestDataPath));
        String strPom = sc2.nextLine();
        while(sc2.hasNextLine()) {
        	Map<String, String> m = new LinkedHashMap<>();
        	String[] str2 = sc2.nextLine().split(",");
        	for(int i=0;i<str2.length-1;i++) {
        		m.put(names.get(i), str2[i]);
        	}
        	TestData.add(new Data(m, str2[str2.length-1]));
        }
        sc2.close();

        ID3 id3 = new ID3();
        
        Node decisionTree = id3.fit(TrainingData, attributes, k);

        // Ispis grana stabla
        System.out.println("[BRANCHES]:");
        printTree(decisionTree, 1, "");
        
        // Ispis predikcija
        System.out.print("[PREDICTIONS]:");
        for (Data d : TestData) {
            String prediction = predict(decisionTree, d);
            System.out.print(" " + prediction);
        }
        System.out.println();
        
        // Izracun i ispis tocnosti predikcija
        int correctPredictions = 0;
        for (int i = 0; i < TestData.size(); i++) {
            String prediction = predict(decisionTree, TestData.get(i));
            String actualLabel = TestData.get(i).getLabel();
            if (prediction.equals(actualLabel)) {
                correctPredictions++;
            }
        }
        double accuracy = (double) correctPredictions / TestData.size();
        Locale.setDefault(Locale.ENGLISH);
        System.out.printf("[ACCURACY]: %.5f%n", accuracy);
        
        // Popunjavanje matrice zabune
        Set<String> uniqueLabels = new TreeSet<>();
        for (Data d : TestData) {
            uniqueLabels.add(d.getLabel());
        }
        int numClasses = uniqueLabels.size();
        Map<String, Integer> labelToIndexMap = new HashMap<>();
        int index = 0;
        for (String label : uniqueLabels) {
            labelToIndexMap.put(label, index);
            index++;
        }
        int[][] confusionMatrix = new int[numClasses][numClasses];
        for (Data d : TestData) {
            String actualLabel = d.getLabel();
            String predictedLabel = predict(decisionTree, d);

            int actualIndex = labelToIndex(actualLabel, labelToIndexMap);
            int predictedIndex = labelToIndex(predictedLabel, labelToIndexMap);

            confusionMatrix[actualIndex][predictedIndex]++;
        }

        // Ispis matrice zabune
        System.out.println("[CONFUSION_MATRIX]:");
        for (int i = 0; i < confusionMatrix.length; i++) {
            for (int j = 0; j < confusionMatrix[i].length; j++) {
                System.out.print(confusionMatrix[i][j] + " ");
            }
            System.out.println();
        }
	}
	
	public static int labelToIndex(String label, Map<String, Integer> labelToIndexMap) {
	    return labelToIndexMap.get(label);
	}
	
	public static String predict(Node node, Data data) {
		try {
		    if (node.getLabel() != null) {
		        return node.getLabel();
		    } else {
		        String attributeValue = data.getAttributes().get(node.getAttribute());
		        Node nextNode = node.getChildren().get(attributeValue);
		        return predict(nextNode, data);
		    }
	    } catch (NullPointerException e) {
	    	return "maybe";
	    }
	}
	
	public static void printTree(Node node, int level, String parent) {
		
		if (node.getLabel() != null) {
            System.out.println(parent + " " + node.getLabel());
        } else {
            for (Map.Entry<String, Node> entry : node.getChildren().entrySet()) {
                if (entry.getKey() == null) {
                    continue;
                }
                String prefix = parent.isEmpty() ? level + ":" + node.getAttribute() + "=" + entry.getKey()
                                                 : parent + " " + level + ":" + node.getAttribute() + "=" + entry.getKey();
                printTree(entry.getValue(), level + 1, prefix);
            }
        }
    }
	
	private static class Data {
	    private Map<String, String> attributes;
	    private String label;

	    public Data(Map<String, String> attributes, String label) {
	        this.attributes = attributes;
	        this.label = label;
	    }

	    public Map<String, String> getAttributes() {
	        return attributes;
	    }

	    public String getLabel() {
	        return label;
	    }
	}
	
	private static class Node {
	    private String attribute;
	    private String label;
	    private Map<String, Node> children;

	    public Node(String attribute) {
	        this.attribute = attribute;
	        this.children = new HashMap<>();
	    }

	    public String getAttribute() {
	        return attribute;
	    }

	    public String getLabel() {
	        return label;
	    }

	    public void setLabel(String label) {
	        this.label = label;
	    }

	    public Map<String, Node> getChildren() {
	        return children;
	    }

	    public void addChild(String attributeValue, Node child) {
	        this.children.put(attributeValue, child);
	    }
	}
	
	private static class ID3 {

	    public Node fit(List<Data> data, Set<String> attributes, int maxDepth) {
	        if (data.isEmpty()) {
	            return null;
	        }

	        // Ako nemamo vise atributa
	        if (attributes.isEmpty() || maxDepth == 0) {
	            Node leaf = new Node(null);
	            leaf.setLabel(getMajorityLabel(data));
	            return leaf;
	        }
	        
	        // Ako svi podatci imaju jednak ishod
	        if (isHomogeneous(data)) {
	            Node leaf = new Node(null);
	            leaf.setLabel(data.get(0).getLabel());
	            return leaf;
	        }

	        // Potraga za najboljim atributom pomocu IG-a
	        String bestAttribute = getBestAttribute(data, attributes);

	        Node subtrees = new Node(bestAttribute);
	        Set<String> remainingAttributes = new HashSet<>(attributes);
	        remainingAttributes.remove(bestAttribute);

	        Map<String, List<Data>> partitions = partitionData(data, bestAttribute);
	        for (Map.Entry<String, List<Data>> entry : partitions.entrySet()) {
	            Node childNode = fit(entry.getValue(), remainingAttributes, maxDepth - 1);
	            subtrees.addChild(entry.getKey(), childNode);
	        }

	        return subtrees;
	    }

	    private boolean isHomogeneous(List<Data> data) {
	        String firstLabel = data.get(0).getLabel();
	        for (Data d : data) {
	            if (!d.getLabel().equals(firstLabel)) {
	                return false;
	            }
	        }
	        return true;
	    }

	    private String getMajorityLabel(List<Data> data) {
	        Map<String, Long> labelCounts = data.stream()
	                .collect(Collectors.groupingBy(Data::getLabel, Collectors.counting()));
	        String rez = "Z";
	        long numCounts=Integer.MIN_VALUE;
	        for(String str : labelCounts.keySet()) {
	        	long count=labelCounts.get(str);
	        	if(count > numCounts) {
	        		numCounts = count;
	        		rez = str;
	        	}
	        	if(count == numCounts) {
	        		if(str.charAt(0)<rez.charAt(0)) {
	                	rez = str;
	                }
	        	}
	        }
	        return rez;
	    }

	    private String getBestAttribute(List<Data> data, Set<String> attributes) {
	        String bestAttribute = null;
	        double bestGain = Double.MIN_VALUE;

	        for (String attribute : attributes) {
	            double gain = calculateInformationGain(data, attribute);
	            System.out.printf("IG(%s) = %.4f ", attribute, gain);
	            if (gain > bestGain) {
	                bestGain = gain;
	                bestAttribute = attribute;
	            }
	            if(gain == bestGain) {
                	if(attribute.charAt(0)<bestAttribute.charAt(0)) {
	                	bestAttribute = attribute;
	                }
                }
	        }
	        System.out.println();
	        return bestAttribute;
	    }

	    private double calculateInformationGain(List<Data> data, String attribute) {
	        double entropyBefore = calculateEntropy(data);
	        Map<String, List<Data>> partitions = partitionData(data, attribute);
	        double entropyAfter = 0.0;

	        for (List<Data> partition : partitions.values()) {
	            entropyAfter += ((double) partition.size() / data.size()) * calculateEntropy(partition);
	        }

	        return entropyBefore - entropyAfter;
	    }

	    private double calculateEntropy(List<Data> data) {
	        Map<String, Long> labelCounts = data.stream()
	                .collect(Collectors.groupingBy(Data::getLabel, Collectors.counting()));
	        double entropy = 0.0;

	        for (long count : labelCounts.values()) {
	            double probability = (double) count / data.size();
	            entropy -= probability * Math.log(probability) / Math.log(2);
	        }

	        return entropy;
	    }

	    private Map<String, List<Data>> partitionData(List<Data> data, String attribute) {
	        Map<String, List<Data>> partitions = new HashMap<>();
	        for (Data d : data) {
	            String attributeValue = d.getAttributes().get(attribute);
	            partitions.computeIfAbsent(attributeValue, k -> new ArrayList<>()).add(d);
	        }
	        return partitions;
	    }
	}
}
