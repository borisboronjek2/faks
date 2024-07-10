import java.io.BufferedWriter;
import java.io.Console;
import java.io.File;
import java.io.FileWriter;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.security.spec.KeySpec;
import java.util.Arrays;
import java.util.Base64;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;

import javax.crypto.AEADBadTagException;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

public class Main {
	
	private static Console console = System.console();
	private static SecureRandom secureRandom = new SecureRandom();
	private static final int KEY_SIZE = 256; //AES-256
	private static final int ITERATIONS = 10000; // PBKDF2 number of iterations
	private static final int SALT_SIZE = 32; // salt size in bytes
	private static final int IV_SIZE = 16; // iv size in bytes
	private static final String PASSWORD = "mPass";

	public static void main(String[] args) throws Exception {
		if (!(new File("./passwords.txt").isFile())) {
            initialize();
        }
		try {
			if(args[0].equals("usermgmt")) {
				if(args[1].equals("add")) {
					String password = enterPasswordUsermgmt();
					add(args[2], password);
				}
				if(args[1].equals("passwd")) {
					String password = enterPasswordUsermgmt();
	                updatePassword(args[2], password);
				}
				if(args[1].equals("forcepass")) {
					forcePasswordChange(args[2]);
				}
				if(args[1].equals("del")) {
					deleteUser(args[2]);
				}
			} else if (args[0].equals("login")) {
				String password = enterPasswordLogin();
				Login(args[1], password);
			}
		} catch (NullPointerException e) {
			if (args[0].equals("login")) {
				System.err.println("User " + args[1] + " does not exist.");
			}
			if(args[1].equals("usermgmt")) {
				System.err.println("User " + args[2] + " does not exist.");
			}
		} catch (IllegalArgumentException e) {
			System.err.println("Database has been attacked.");
		} catch (AEADBadTagException e2) {
			System.err.println("Database has been attacked.");
		}
	}
	public static void add(String username, String password) throws Exception {
		byte[] salt = new byte[32];
        secureRandom.nextBytes(salt);
        
        MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
        messageDigest.reset();
        messageDigest.update(salt);
        byte[] hashedPassword = messageDigest.digest(password.getBytes());
        
        Set<User> users = new HashSet<>();
        users.addAll(loadUsers().values());
        users.add(new User(username, hashedPassword, salt, false));
        saveUsers(users);
        System.out.println("User " + username + " successfuly added.");
	}
	
	public static void updatePassword(String username, String newPassword) throws Exception	{
		byte[] salt = new byte[32];
		secureRandom.nextBytes(salt);

		MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
		messageDigest.reset();
		messageDigest.update(salt);
		byte[] hashedPassword = messageDigest.digest(newPassword.getBytes());

		Map<String, User> users = loadUsers();
		User user = users.get(username);
	    user.hashedPassword = hashedPassword;
	    user.salt = salt;

	    Set<User> updatedUsers = new HashSet<>();
	    updatedUsers.addAll(users.values());
	    saveUsers(updatedUsers);
	    System.out.println("Password change successful.");
	}
	
	public static void forcePasswordChange(String username) throws Exception{
        Map<String, User> map = loadUsers();
        User user = map.get(username);
        user.changePasswordFlag = true;
        Set<User> updatedUsers = new HashSet<>();
        updatedUsers.addAll(map.values());
        saveUsers(updatedUsers);
        System.out.println("User will be requested to change password on next login.");
    }
	
	public static void deleteUser(String username) throws Exception {
        Map<String, User> map = loadUsers();
        map.remove(username);
        Set<User> updatedUsers = new HashSet<>();
        updatedUsers.addAll(map.values());
        saveUsers(updatedUsers);
        System.out.println("User successfuly removed.");
    }
	
	public static void Login(String username, String password) throws Exception {
        Map<String, User> users = loadUsers();
        User user = users.get(username);

        MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
        messageDigest.reset();
        messageDigest.update(user.salt);
        byte[] hashedPassword = messageDigest.digest(password.getBytes());
        String userPassword = Base64.getEncoder().encodeToString(user.hashedPassword);
        String enteredPass = Base64.getEncoder().encodeToString(hashedPassword);

        if (userPassword.equals(enteredPass)) {
            if (user.changePasswordFlag) {
                changePassword(user.username);
            }
            System.out.println("bash$");
        }
        else {
            System.out.println("Username or password incorrect.");
        }
    }
	
	public static void changePassword(String username) throws Exception{
		String password = enterPasswordChange();

        Map<String, User> users = loadUsers();
        User user = users.get(username);
        SecureRandom secureRandom = new SecureRandom();
        byte[] salt = new byte[32];
        secureRandom.nextBytes(salt);

        MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
        messageDigest.reset();
        messageDigest.update(salt);
        byte[] hashedPassword = messageDigest.digest(password.getBytes());

        user.hashedPassword = hashedPassword;
        user.salt = salt;
        user.changePasswordFlag = false;

        Set<User> updatedUsers = new HashSet<>();
        updatedUsers.addAll(users.values());
        saveUsers(updatedUsers);
    }
	
	public static String enterPasswordUsermgmt() {
        char[] password = console.readPassword("Password: ");
        char[] confirmPassword = console.readPassword("Repeat password: ");
        if (!Arrays.equals(password, confirmPassword)) {
            System.out.println("Passwords mismatch.");
            System.exit(0);
        }
        return new String(password);
    }
	
	public static String enterPasswordLogin() {
        char[] password = console.readPassword("Password: ");
        return new String(password);
    }
	
	public static String enterPasswordChange() {
        char[] password = console.readPassword("New password: ");
        char[] confirmPassword = console.readPassword("Repeat new password: ");
        if (!Arrays.equals(password, confirmPassword)) {
            System.out.println("Passwords mismatch.");
            System.exit(0);
        }
        return new String(password);
    }
	
	public static Map<String, User> loadUsers() throws Exception {
        Map<String, Boolean> usernameFlag = new HashMap<>();
        Map<String, User> usersMap = new HashMap<>();

        String flagData = decryptFlags();
        Scanner flagSc = new Scanner(flagData);

        while (flagSc.hasNextLine()) {
            String userFlag = flagSc.nextLine();
            String[] userFlagPair = userFlag.split(":");
            usernameFlag.put(userFlagPair[0], Boolean.valueOf(userFlagPair[1]));
        }
        flagSc.close();

        Scanner sc = new Scanner(new File("./passwords.txt"));
        while (sc.hasNextLine()) {
            String usersInfo = sc.nextLine();
            String[] usersInfoSplit = usersInfo.split(",");
            byte[] hashedPassword = Base64.getDecoder().decode(usersInfoSplit[1].getBytes(StandardCharsets.UTF_8));
            byte[] salt = Base64.getDecoder().decode(usersInfoSplit[2].getBytes(StandardCharsets.UTF_8));
            User user = (new User(
                    usersInfoSplit[0],
                    hashedPassword,
                    salt,
                    usernameFlag.get(usersInfoSplit[0])
            ));
            usersMap.put(user.username, user);
        }
        sc.close();
        return usersMap;

    }
    public static void saveUsers(Set<User> users) throws Exception {
        String flagStr = "";
        String passwordStr = "";
        for (User user : users) {
            flagStr += user.username + ":" + user.changePasswordFlag + "\n";
            passwordStr += user.username + "," +
                    Base64.getEncoder().encodeToString(user.hashedPassword) + "," +
                    Base64.getEncoder().encodeToString(user.salt) + "\n";
        }
        encryptFlags(flagStr);

        BufferedWriter writer = new BufferedWriter(new FileWriter("./passwords.txt", false));
        writer.write(passwordStr);
        writer.close();
    }
	
	public static byte[] encryptFlags(String data) throws Exception {
        byte[] iv = new byte[IV_SIZE];
        secureRandom.nextBytes(iv);
        Path ivPath = Paths.get("./iv.txt");
        Files.write(ivPath, iv);
        
        byte[] salt = new byte[SALT_SIZE];
        secureRandom.nextBytes(salt);
        Path saltPath = Paths.get("./salt.txt");
        Files.write(saltPath, salt);
        
        SecretKey secretKey = generateSecretKey(PASSWORD, salt);
        
        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
        cipher.init(Cipher.ENCRYPT_MODE, secretKey, new GCMParameterSpec(128, iv));

        byte[] encryptedData = cipher.doFinal(data.getBytes());
        Path dataPath = Paths.get("./flags.txt");
        Files.write(dataPath, encryptedData);
        
        return encryptedData;
	}
	
	public static String decryptFlags() throws Exception {
		Path ivPath = Paths.get("./iv.txt");
        byte[] iv = Files.readAllBytes(ivPath);
        Path saltPath = Paths.get("./salt.txt");
        byte[] salt = Files.readAllBytes(saltPath);
        Path dataPath = Paths.get("./flags.txt");
        byte[] encryptedData = Files.readAllBytes(dataPath);
		
        SecretKey secretKey = generateSecretKey(PASSWORD, salt);
        
        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
        cipher.init(Cipher.DECRYPT_MODE, secretKey, new GCMParameterSpec(128, iv));

        byte[] decryptedData = cipher.doFinal(encryptedData);

        String dataString = new String(decryptedData, StandardCharsets.UTF_8);

        return dataString;
	}
	
	public static SecretKey generateSecretKey(String password, byte[] salt) throws Exception {
		KeySpec spec = new PBEKeySpec(password.toCharArray(), salt, ITERATIONS, KEY_SIZE);
        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA512");
        byte[] keyBytes = factory.generateSecret(spec).getEncoded();
        return new SecretKeySpec(keyBytes, "AES");
	}
	
	public static void initialize() throws Exception {
        File passwordsFile = new File("passwords.txt");
        passwordsFile.createNewFile();

        File flagFile = new File("flags.txt");
        flagFile.createNewFile();

        File ivFile = new File("iv.txt");
        ivFile.createNewFile();

        File saltFile = new File("salt.txt");
        saltFile.createNewFile();

        Set<User> users = new HashSet<>();
        SecureRandom secureRandom = new SecureRandom();
        byte[] salt = new byte[32];
        secureRandom.nextBytes(salt);
        users.add(new User("",salt,salt,false));
        saveUsers(users);
    }
	
	public static class User {
	    String username;
	    byte[] hashedPassword;
	    byte[] salt;
	    Boolean changePasswordFlag;

	    public User(String username, byte[] hashedPassword, byte[] salt, Boolean changePasswordFlag) {
	        this.username = username;
	        this.hashedPassword = hashedPassword;
	        this.salt = salt;
	        this.changePasswordFlag = changePasswordFlag;
	    }
	}
}
