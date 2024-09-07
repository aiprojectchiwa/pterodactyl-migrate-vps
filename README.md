# **Cara Pindah Pterodactyl Panel dan Node ke VPS Baru**

Sebelum mulai, alangkah baiknya bikin kopi terlebih dahulu dan siapkan sebungkus rokok biar work 😊

> **Syarat Work**: Bilang **chiwa kawaii** dulu >\\< mwehehe, yang ga bilang ga work :3

> **Catatan**: Cara ini baru diuji dan berhasil pada dua distro dengan versi yang sama.

---

## **Langkah-Langkah Pindah Panel**

### **VPS Pertama:**

1. Backup database:
    ```bash
    mysqldump -u root -p --all-databases > /alldb.sql
    ```

2. Backup file Pterodactyl
   ```bash
   tar -cvpzf backup.tar.gz /etc/letsencrypt /var/www/pterodactyl /etc/nginx/sites-available/pterodactyl.conf /alldb.sql
   ```

### **VPS Kedua:**

1. Jalanin auto installer panel, jangan isi opsi HTTPS dan SSL:
    ```bash
    bash <(curl -s https://pterodactyl-installer.se)
    ```

2. Transfer file backup ke VPS baru:
    ```bash
    scp root@ip:/root/backup.tar.gz /
    ```

3. Ekstrak file backup:
    ```bash
    tar -xvpzf /backup.tar.gz -C /
    ```

4. Restart Nginx:
    ```bash
    systemctl restart nginx
    ```
---

## **Langkah-Langkah Pindah Node**

### **VPS Pertama:**

1. Backup data Node:
    ```bash
    tar -cvzf node.tar.gz /var/lib/pterodactyl /etc/pterodactyl
    ```

2. Stop Wings:
    ```bash
    systemctl stop wings
    ```

### **VPS Kedua:**

1. Jalanin auto installer node, jangan isi opsi SSL atau yang membutuhkan sertifikat:
    ```bash
    bash <(curl -s https://pterodactyl-installer.se)
    ```

2. Transfer file backup ke VPS baru:
    ```bash
    scp root@ip:/root/node.tar.gz /
    ```

3. Ekstrak file backup:
    ```bash
    tar -xvzf /node.tar.gz
    ```

4. Restore Database
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
    WHERE ip = 'IP LAM';
    ```


6. Restart Wings:
    ```bash
    systemctl restart wings
    ```

---

masih banyak bug cuk,sebaiknya jangan dicoba🗿
