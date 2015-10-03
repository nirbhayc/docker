## Docker scripts for MariaDB

### MariaDB Galera cluster
* Create an image
  ```
  sudo docker build -t mariadb-galera-cluster mariadb-galera-server/10.0/
  ```

* Set Docker's AppArmor profile to complain mode to avoid blocking of 'lsof' (used in wsrep_sst_rsync)
  ```
  sudo aa-complain /etc/apparmor.d/docker
  ```

* Run galera nodes (method 1)
  ```
  sudo docker run --detach=true --name="node1" mariadb-galera-cluster --wsrep-new-cluster --wsrep-cluster-address=gcomm://
  sudo docker run --detach=true --name="node2" mariadb-galera-cluster --wsrep-cluster-address=gcomm://`sudo docker inspect --format='{{.NetworkSettings.IPAddress}}' node1`
  ```

* Run galera nodes (method 2)
  ```
  sudo docker run --detach=true --name="node1" --hostname="host1" mariadb-galera-cluster --wsrep-new-cluster --wsrep-cluster-address=gcomm://
  sudo docker run --detach=true --name="node2" --hostname="host2" --link=node1:node1 mariadb-galera-cluster --wsrep-cluster-address=gcomm://host1
  ```

* Verify
  ```
  sudo docker exec -it node1 mysql -e "show status like 'wsrep_cluster_size'"
  sudo docker exec -it node1 mysql -e "show status like 'wsrep_local_state_comment'"
  ```

