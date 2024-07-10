#!/bin/bash
javac Main.java
echo "$ java Main init masterPassword"
java Main init masterPassword
echo "$ java Main put masterPassword fer.hr ferPassword"
java Main put masterPassword fer.hr ferPassword
echo "$ java Main put masterPassword boris.hr borisPassword"
java Main put masterPassword boris.hr borisPassword
echo "$ java Main get masterPassword fer.hr"
java Main get masterPassword fer.hr
echo "$ java Main get masterPassword boris.hr"
java Main get masterPassword boris.hr
echo "$ java Main get masterPassword unknown.hr"
java Main get masterPassword unknown.hr
echo "$ java Main put masterPassword fer.hr newPassword"
java Main put masterPassword fer.hr newPassword
echo "$ java Main get masterPassword fer.hr"
java Main get masterPassword fer.hr
echo "$ java Main get wrongPassword boris.hr"
java Main get wrongPassword boris.hr
echo "$ java Main get masterPassword boris.hr"
java Main get masterPassword boris.hr
echo "$ java Main init newMasterPassword"
java Main init newMasterPassword
echo "$ java Main get masterPassword fer.hr"
java Main get masterPassword fer.hr
echo "$ java Main get newMasterPassword fer.hr"
java Main get newMasterPassword fer.hr
read -p "Press Enter to continue."