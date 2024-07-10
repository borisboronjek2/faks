package ui;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Solution {
	private static double pMutation = 0.1;
    private static double scaleMutation = 0.1;
    private static int popSize = 10;
    private static int elitism = 1;
    private static int iterations = 2000;
    private static double[][] trainInput;
    private static double[] trainCorrect;
    private static double[][] testInput;
    private static double[] testCorrect;

    public static void main(String[] args) throws IOException {
        String trainPath = "sine_train.txt";
        String testPath = "sine_test.txt";
        String architectureString = "5s";
        for (int i = 0; i < args.length; i++) {
            switch (args[i]) {
                case "--train":
                    trainPath = args[++i];
                    break;
                case "--test":
                    testPath = args[++i];
                    break;
                case "--nn":
                    architectureString = args[++i];
                    break;
                case "--popsize":
                    popSize = Integer.parseInt(args[++i]);
                    break;
                case "--elitism":
                    elitism = Integer.parseInt(args[++i]);
                    break;
                case "--p":
                    pMutation = Double.parseDouble(args[++i]);
                    break;
                case "--K":
                    scaleMutation = Double.parseDouble(args[++i]);
                    break;
                case "--iter":
                    iterations = Integer.parseInt(args[++i]);
                    break;
            }
        }

        List<Integer> hiddenLayers = new ArrayList<>();
        Pattern pattern = Pattern.compile("\\d+");
        Matcher matcher = pattern.matcher(architectureString);
        while (matcher.find()) {
            hiddenLayers.add(Integer.parseInt(matcher.group()));
        }

        List<double[]> trainData = readCsv(trainPath);
        trainInput = new double[trainData.size() - 1][];
        trainCorrect = new double[trainData.size() - 1];
        for (int i = 1; i < trainData.size(); i++) {
            double[] row = trainData.get(i);
            trainInput[i - 1] = new double[row.length - 1];
            System.arraycopy(row, 0, trainInput[i - 1], 0, row.length - 1);
            trainCorrect[i - 1] = row[row.length - 1];
        }

        List<double[]> testData = readCsv(testPath);
        testInput = new double[testData.size() - 1][];
        testCorrect = new double[testData.size() - 1];
        for (int i = 1; i < testData.size(); i++) {
            double[] row = testData.get(i);
            testInput[i - 1] = new double[row.length - 1];
            System.arraycopy(row, 0, testInput[i - 1], 0, row.length - 1);
            testCorrect[i - 1] = row[row.length - 1];
        }

        // inicijalizacija populacije
        List<NeuralNetwork> population = new ArrayList<>();
        for (int i = 0; i < popSize; i++) {
            NeuralNetwork nn = new NeuralNetwork(hiddenLayers);
            nn.initializeNN(trainInput[0].length);
            population.add(nn);
        }

        // evolucijski algoritam
        List<NeuralNetwork> newPopulation = new ArrayList<>();
        for (int i = 0; i < iterations; i++) {
            List<NeuralNetwork> evaluatedPopulation = evaluatePopulation(population);
            newPopulation.clear();
            for (int j = 0; j < elitism; j++) {
                newPopulation.add(evaluatedPopulation.get(j));
            }

            while (newPopulation.size() < popSize) {
                NeuralNetwork[] parents = pickParents(evaluatedPopulation);
                NeuralNetwork child = cross(parents[0], parents[1]);
                mutate(child);
                newPopulation.add(child);
            }

            population = new ArrayList<>(newPopulation);
            Locale.setDefault(Locale.ENGLISH);

            if ((i + 1) % 2000 == 0) {
                System.out.printf("[Train error @%d]: %.6f%n", i + 1, 1 / evaluatePopulation(population).get(0).evaluate(trainInput, trainCorrect));
            }
        }

        NeuralNetwork bestNN = evaluatePopulation(population).get(0);
        System.out.printf("[Test error]: %.6f%n", 1 / bestNN.evaluate(testInput, testCorrect));
    }

    private static List<NeuralNetwork> evaluatePopulation(List<NeuralNetwork> population) {
        List<NeuralNetwork> evaluated = new ArrayList<>();
        for (NeuralNetwork nn : population) {
            evaluated.add(nn);
        }
        evaluated.sort((a, b) -> Double.compare(b.evaluate(trainInput, trainCorrect), a.evaluate(trainInput, trainCorrect)));
        return evaluated;
    }

    private static NeuralNetwork[] pickParents(List<NeuralNetwork> population) {
        NeuralNetwork[] parents = new NeuralNetwork[2];
        double totalFitness = population.stream().mapToDouble(nn -> nn.evaluate(trainInput, trainCorrect)).sum();
        Random random = new Random();
        for (int i = 0; i < 2; i++) {
            double rand = random.nextDouble() * totalFitness;
            double cumulative = 0;
            for (NeuralNetwork nn : population) {
                cumulative += nn.evaluate(trainInput, trainCorrect);
                if (cumulative > rand) {
                    parents[i] = nn;
                    break;
                }
            }
        }
        return parents;
    }

    private static NeuralNetwork cross(NeuralNetwork parent1, NeuralNetwork parent2) {
        List<double[][]> newLayers = new ArrayList<>();
        List<double[]> newBiases = new ArrayList<>();
        for (int i = 0; i < parent1.layersMatrices.size(); i++) {
            double[][] newLayer = new double[parent1.layersMatrices.get(i).length][];
            for (int j = 0; j < parent1.layersMatrices.get(i).length; j++) {
                newLayer[j] = new double[parent1.layersMatrices.get(i)[j].length];
                for (int k = 0; k < parent1.layersMatrices.get(i)[j].length; k++) {
                    newLayer[j][k] = (parent1.layersMatrices.get(i)[j][k] + parent2.layersMatrices.get(i)[j][k]) / 2;
                }
            }
            newLayers.add(newLayer);

            double[] newBias = new double[parent1.biasVectors.get(i).length];
            for (int j = 0; j < parent1.biasVectors.get(i).length; j++) {
                newBias[j] = (parent1.biasVectors.get(i)[j] + parent2.biasVectors.get(i)[j]) / 2;
            }
            newBiases.add(newBias);
        }
        NeuralNetwork child = new NeuralNetwork(parent1.hiddenLayers);
        child.layersMatrices = newLayers;
        child.biasVectors = newBiases;
        return child;
    }

    private static void mutate(NeuralNetwork network) {
        Random random = new Random();
        for (double[][] matrix : network.layersMatrices) {
            for (int i = 0; i < matrix.length; i++) {
                for (int j = 0; j < matrix[i].length; j++) {
                    if (random.nextDouble() < pMutation) {
                        matrix[i][j] += random.nextGaussian() * scaleMutation;
                    }
                }
            }
        }
        for (double[] bias : network.biasVectors) {
            for (int i = 0; i < bias.length; i++) {
                if (random.nextDouble() < pMutation) {
                    bias[i] += random.nextGaussian() * scaleMutation;
                }
            }
        }
    }
    
    private static class NeuralNetwork {
        private List<double[][]> layersMatrices;
        private List<double[]> biasVectors;
        private List<Integer> hiddenLayers;

        public NeuralNetwork(List<Integer> hiddenLayers) {
            this.hiddenLayers = new ArrayList<>(hiddenLayers);
            layersMatrices = new ArrayList<>();
            biasVectors = new ArrayList<>();
        }

        public void initializeNN(int inputSize) {
            int sizePrev = inputSize;
            Random random = new Random();
            for (int h : hiddenLayers) {
                double[][] layerMatrix = new double[h][sizePrev];
                for (int i = 0; i < h; i++) {
                    for (int j = 0; j < sizePrev; j++) {
                        layerMatrix[i][j] = random.nextGaussian() * 0.01;
                    }
                }
                layersMatrices.add(layerMatrix);

                double[] biasVector = new double[h];
                for (int i = 0; i < h; i++) {
                    biasVector[i] = random.nextGaussian() * 0.01;
                }
                biasVectors.add(biasVector);

                sizePrev = h;
            }

            double[][] outputLayer = new double[1][sizePrev];
            for (int j = 0; j < sizePrev; j++) {
                outputLayer[0][j] = random.nextGaussian() * 0.01;
            }
            layersMatrices.add(outputLayer);

            double[] outputBias = new double[1];
            outputBias[0] = random.nextGaussian() * 0.01;
            biasVectors.add(outputBias);
        }

        public double predict(double[] input) {
            double[] prevValues = input.clone();
            for (int l = 0; l < layersMatrices.size() - 1; l++) {
                double[][] layerMatrix = layersMatrices.get(l);
                double[] biasVector = biasVectors.get(l);
                prevValues = sigmoid(add(dot(layerMatrix, prevValues), biasVector));
            }
            double[][] outputLayer = layersMatrices.get(layersMatrices.size() - 1);
            double[] outputBias = biasVectors.get(biasVectors.size() - 1);
            return add(dot(outputLayer, prevValues), outputBias)[0];
        }

        public double evaluate(double[][] inputs, double[] correctOutputs) {
            double errorSum = 0;
            for (int i = 0; i < inputs.length; i++) {
                double prediction = predict(inputs[i]);
                errorSum += Math.pow(correctOutputs[i] - prediction, 2);
            }
            return 1 / (errorSum / inputs.length);
        }

        private double[] sigmoid(double[] x) {
            double[] result = new double[x.length];
            for (int i = 0; i < x.length; i++) {
                result[i] = 1.0 / (1.0 + Math.exp(-x[i]));
            }
            return result;
        }

        private double[] add(double[] a, double[] b) {
            double[] result = new double[a.length];
            for (int i = 0; i < a.length; i++) {
                result[i] = a[i] + b[i];
            }
            return result;
        }

        private double[] dot(double[][] matrix, double[] vector) {
            double[] result = new double[matrix.length];
            for (int i = 0; i < matrix.length; i++) {
                result[i] = 0;
                for (int j = 0; j < vector.length; j++) {
                    result[i] += matrix[i][j] * vector[j];
                }
            }
            return result;
        }
    }
    
    private static List<double[]> readCsv(String csvPath) throws IOException {
        List<double[]> allRows = new ArrayList<>();
        BufferedReader br = new BufferedReader(new FileReader(csvPath));
        String line;
        boolean first = true;
        while ((line = br.readLine()) != null) {
            if (first) {
                first = false;
                continue;
            }
            String[] values = line.split(",");
            double[] row = new double[values.length];
            for (int i = 0; i < values.length; i++) {
                row[i] = Double.parseDouble(values[i]);
            }
            allRows.add(row);
        }
        br.close();
        return allRows;
    }
    
}
