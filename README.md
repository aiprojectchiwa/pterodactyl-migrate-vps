# **Cara Pindah Pterodactyl Panel dan Node ke VPS Baru**

Sebelum mulai, alangkah baiknya bikin kopi terlebih dahulu dan siapkan sebungkus rokok biar work 😊

> **Syarat Work**: Bilang **chiwa kawaii** dulu >\\< mwehehe, yang ga bilang ga work :3

> **Catatan**: Cara ini baru diuji dan berhasil pada dua distro dengan versi yang sama.

---

## **Langkah-Langkah Pindah Panel**

### **VPS Pertama:**

1. Backup Database:
    ```bash
    mysqldump -u root -p --all-databases > /alldb.sql
    ```

2. Backup File Pterodactyl,SSL,nginx, dan konfigurasinya
   ```bash
   tar -cvpzf backup.tar.gz /etc/letsencrypt /var/www/pterodactyl /etc/nginx/sites-available/pterodactyl.conf /alldb.sql
   ```
3. Backup Data Node:
    ```bash
    tar -cvzf node.tar.gz /var/lib/pterodactyl /etc/pterodactyl
    ```
    
### **VPS Kedua:**

1. Jalanin Auto Installer Panel Sama Node, Jangan Isi Opsi HTTPS dan SSL:
    ```bash
    bash <(curl -s https://pterodactyl-installer.se)
    ```

2. Transfer File Backup Panel dan Node Ke VPS Baru:
    ```bash
    scp root@ip:/root/{backup.tar.gz,node.tar.gz} /
    ```
    
3. Ekstrak File Backup Panel:
    ```bash
    tar -xvpzf /backup.tar.gz -C /
    ```

4. Restart Nginx:
    ```bash
    systemctl restart nginx
    ```
    
5. Ekstrak File Backup Node:
    ```bash
    tar -xvzf /node.tar.gz -C /
    ```

6. Restore Database
    ```bash
    mysql -u root -p < /alldb.sql
    ```

5. Update DB IP
    ```bash
    mysql
    ```
    ```mysql
    UPDATE allocations
    SET ip = 'IP BARU'
    WHERE ip = 'IP LAMA';
    ```
6. Restart Wings:
    ```bash
    systemctl restart wings
    ```
---

## **Langkah-Langkah Pindah Node**

### **VPS Pertama:**


### **VPS Kedua:**

1. Jalanin auto installer node, jangan isi opsi SSL atau yang membutuhkan sertifikat:
    ```bash
    bash <(curl -s https://pterodactyl-installer.se)
    ```







---

masih banyak bug cuk,sebaiknya jangan dicoba🗿
