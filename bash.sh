#!/bin/bash
cd entA
echo "Content of Entity A"
ls

read -p "Enter public key of B: " public_keyB
read -p "Enter file to encrypt: " clear_txt
read -p "Write a message to the file: " message

echo $message > $clear_txt

ls

#Encryption in Entity A (sender)
openssl pkeyutl -encrypt -pubin -inkey $public_keyB -in $clear_txt -out encrypted1.dat

echo "Forwarding the encrypted data...."
cp encrypted1.dat ../entB

cd
cd ent2

echo "Content of Entity B: "
ls

#Decryption on Entity B (recepient)
read -p "Enter private key of B: " private_keyB
openssl pkeyutl -decrypt -inkey $private_keyB -in encrypted1.dat -out decrypted1.txt

echo "The file has been decrypted: "
cat decrypted1.txt
