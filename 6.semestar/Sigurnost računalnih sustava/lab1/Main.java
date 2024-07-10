import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.SecureRandom;
import java.security.spec.KeySpec;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

public class Main {
	
	private static final int KEY_SIZE = 256; //AES-256
	private static final int ITERATIONS = 10000; // PBKDF2 number of iterations
	private static final int SALT_SIZE = 16; // salt size in bytes
	private static final int IV_SIZE = 16; // iv size in bytes
	private static final SecureRandom random = new SecureRandom();
	

	public static void main(String[] args) throws Exception {
		try {
			if(args[0].equals("init")) {
				init(args[1]);
			} else if (args[0].equals("put")) {
				put(args[1], args[2], args[3]);
			} else if (args[0].equals("get")) {
				System.out.println("Password for " + args[2] + " is: " + get(args[1], args[2]) + ".");
			} else {
				System.exit(0);
			}
		} catch(NoSuchFileException e) {
			System.err.println("Master password not initialized");
		} catch (ArrayIndexOutOfBoundsException e) {
            System.err.println("Wrong number of arguments");
        } catch(BadPaddingException e) {
            System.err.println("Master password incorrect or integrity check failed.");
        }
	}
	
	public static void init(String mPass) throws Exception{
		Path ivPath = Paths.get("./iv.txt");
        Files.delete(ivPath);;
        Path saltPath = Paths.get("./salt.txt");
        Files.delete(saltPath);
        Path dataPath = Paths.get("./data.txt");
        Files.delete(dataPath);
		encrypt(mPass, "");
		System.out.println("Password manager initialized");
	}
	
	public static void put(String mPass, String address, String pass) throws Exception{
		String dataString = decrypt(mPass);

        Scanner sc = new Scanner(dataString);
        Map<String, String> map = new HashMap<>();
        while (sc.hasNext()) {
            String[] pair = sc.next().split(":");
            map.put(pair[0], pair[1]);
        }
        sc.close();
        map.put(address, pass);

        String dataToEncrypt = "";
        for (String key : map.keySet()) {
            dataToEncrypt += key + ":" + map.get(key) + "\n";
        }
        encrypt(mPass, dataToEncrypt);
        System.out.println("Storred password for " + address + ".");
	}
	
	public static String get(String mPass, String address) throws Exception {
		String dataString = decrypt(mPass);

        Scanner sc = new Scanner(dataString);
        Map<String, String> map = new HashMap<>();
        while (sc.hasNext()) {
            String[] pair = sc.next().split(":");
            map.put(pair[0], pair[1]);
        }
        sc.close();
        return map.get(address);
	}
	
	public static void encrypt(String mPass, String data) throws Exception {
        byte[] iv = new byte[IV_SIZE];
        random.nextBytes(iv);
        Path ivPath = Paths.get("./iv.txt");
        Files.write(ivPath, iv);
        
        byte[] salt = new byte[SALT_SIZE];
        random.nextBytes(salt);
        Path saltPath = Paths.get("./salt.txt");
        Files.write(saltPath, salt);
        
        SecretKey secretKey = generateSecretKey(mPass, salt);
        
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, secretKey, new IvParameterSpec(iv));

        byte[] encryptedData = cipher.doFinal(data.getBytes());
        Path dataPath = Paths.get("./data.txt");
        Files.write(dataPath, encryptedData);
	}
	
	public static String decrypt(String mPass) throws Exception {
		Path ivPath = Paths.get("./iv.txt");
        byte[] iv = Files.readAllBytes(ivPath);
        Path saltPath = Paths.get("./salt.txt");
        byte[] salt = Files.readAllBytes(saltPath);
        Path dataPath = Paths.get("./data.txt");
        byte[] encryptedData = Files.readAllBytes(dataPath);
		
        SecretKey secretKey = generateSecretKey(mPass, salt);
        
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, secretKey, new IvParameterSpec(iv));

        byte[] decryptedData = cipher.doFinal(encryptedData);

        String dataString = new String(decryptedData, StandardCharsets.UTF_8);

        return dataString;
	}
	
	public static SecretKey generateSecretKey(String mPass, byte[] salt) throws Exception {
		KeySpec spec = new PBEKeySpec(mPass.toCharArray(), salt, ITERATIONS, KEY_SIZE);
        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA512");
        byte[] keyBytes = factory.generateSecret(spec).getEncoded();
        return new SecretKeySpec(keyBytes, "AES");
	}

}
