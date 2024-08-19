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
   tar -cvzf all_backup.tar.gz \
    -C /etc/letsencrypt . --transform 's,^,etc/letsencrypt/,' \
    -C /var/www/pterodactyl . --transform 's,^,var/www/pterodactyl/,' \
    -C /etc/nginx/sites-available pterodactyl.conf --transform 's,^,etc/nginx/sites-available/,' \
    -C / alldb.sql
   ```

### **VPS Kedua:**

1. Jalanin auto installer panel, jangan isi opsi HTTPS dan SSL:
    ```bash
    bash <(curl -s https://pterodactyl-installer.se)
    ```

2. Transfer file backup ke VPS baru:
    ```bash
    scp root@ip:/root/all_backup.tar.gz /
    ```

3. Ekstrak file backup:
    ```bash
    tar -xvzf /all_backup.tar.gz
    ```

4. Restart Nginx:
    ```bash
    systemctl restart nginx
    ```
5. Restore Database
    ```bash
    mysqldump -u root -p --all-databases > alldb.sql
    ```
6. Update DB IP
    ```bash
    mysql
    ```
    ```mysql
    UPDATE allocations
    SET ip = '147.182.182.136'
    WHERE ip = '178.128.29.230';
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

4. Update IP pada database:
    ```sql
    UPDATE allocations
    SET ip = 'ip baru'
    WHERE ip = 'ip lama';
    ```

5. Restart Wings:
    ```bash
    systemctl restart wings
    ```

---

masih banyak bug cuk,sebaiknya jangan dicoba🗿
