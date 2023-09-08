#!/bin/bash

var_vbmanimport="C:\\Program/\Files\\Oracle\\VirtualBox\\VBoxManage.exe import"

while true; do
    echo "----------------------------------------"
    echo "Importation d'une machine virtuelle dans VirtualBox"
    echo "----------------------------------------"
                                                                                            # Demander le nom de la machine virtuelle
    read -p "Entrez le nom de la machine virtuelle : " vm_name
                                                                                            # Demander le chemin du dossier contenant la VM
    read -p "Entrez le chemin du dossier contenant la machine virtuelle : " vm_dir
                                                                                            # Vérifier si le dossier existe
    if [ ! -d "$vm_dir" ]; then
        echo "Erreur : Le dossier '$vm_dir' n'existe pas."
        continue
    fi
                                                                                            # Vérifier si le fichier OVA existe dans le dossier
    ova_file="$vm_dir\\$vm_name.ova"
    if [ ! -f "$ova_file" ]; then
        echo "Erreur : Le fichier '$ova_file' n'existe pas dans le dossier '$vm_dir'."
        continue
    fi
                                                                                            # Demander confirmation pour l'importation de la VM
    read -p "Voulez-vous installer la machine virtuelle '$vm_name' depuis le fichier OVA '$ova_file' ? (O/N) " confirm

    if [ "$confirm" == "O" ] || [ "$confirm" == "o" ]; then
        cmd.exe /C "\"$var_vbmanimport=\" $ova_file"
                                                                                            # Installer la machine virtuelle avec VBoxManage import
        if [ $? -eq 0 ]; then
            echo "Importation réussie de la machine virtuelle '$vm_name'."
        else
            echo "Une erreur s'est produite lors de l'importation de la machine virtuelle '$vm_name'."
        fi
    else
        echo "Importation annulée."
    fi
                                                                                            # Demander si l'utilisateur veut importer une autre VM
    read -p "Voulez-vous importer une autre machine virtuelle ? (O/N) " another_import

    if [ "$another_import" != "O" ] && [ "$another_import" != "o" ]; then
        break
    fi
done
