
# Introduction to Docker

Docker is an open platform for developing, shipping, and running applications. It enables you to separate your applications from your infrastructure so you can deliver software quickly. With Docker, you can manage your infrastructure in the same ways you manage your applications. By taking advantage of Docker’s methodologies for shipping, testing, and deploying code quickly, you can significantly reduce the delay between writing code and running it in production.

## Installing Docker

### Step 1: Update Your Package Index

Updating the package index ensures you have the latest information about available packages:

```bash
sudo apt-get update
```

### Step 2: Install Required Packages

Install packages that allow apt to use packages over HTTPS and manage certificates:

```bash
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
```

### Step 3: Add Docker’s Official GPG Key

This step adds Docker's official GPG key, which is used to verify the integrity of the packages:

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

### Step 4: Add the Docker Repository

Adding Docker’s repository to your sources list allows you to install Docker from Docker's repositories:

```bash
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

### Step 5: Update Your Package Index Again

After adding Docker's repository, update your package index again to include packages from the new repository:

```bash
sudo apt-get update
```

### Step 6: Install Docker

Finally, install Docker:

```bash
sudo apt-get install docker-ce
```

### Step 7: Verify Docker Installation

Verify that Docker is installed correctly by running the hello-world image:

```bash
sudo docker run hello-world
```

## Docker Commands Cheat Sheet

Here are the top 50 Docker commands with descriptions and examples:

### 1. Check Docker Version

```bash
docker --version
```
Displays the installed Docker version.

### 2. Pull an Image from Docker Hub

```bash
docker pull <image_name>
```
Example:

```bash
docker pull nginx
```
Pulls the NGINX image from Docker Hub.

### 3. List Docker Images

```bash
docker images
```
Lists all Docker images on your local machine.

### 4. Run a Docker Container

```bash
docker run <image_name>
```
Example:

```bash
docker run nginx
```
Runs a container from the NGINX image.

### 5. List Running Containers

```bash
docker ps
```
Lists all currently running Docker containers.

### 6. List All Containers

```bash
docker ps -a
```
Lists all Docker containers, including stopped ones.

### 7. Start a Container

```bash
docker start <container_id>
```
Starts a stopped Docker container.

### 8. Stop a Container

```bash
docker stop <container_id>
```
Stops a running Docker container.

### 9. Remove a Container

```bash
docker rm <container_id>
```
Removes a stopped Docker container.

### 10. Remove an Image

```bash
docker rmi <image_id>
```
Removes a Docker image from your local machine.

### 11. Display Container Logs

```bash
docker logs <container_id>
```
Displays the logs from a Docker container.

### 12. Access a Running Container

```bash
docker exec -it <container_id> /bin/bash
```
Gives you access to the running container's shell.

### 13. Display Container Details

```bash
docker inspect <container_id>
```
Displays detailed information about a Docker container.

### 14. Display Image Details

```bash
docker inspect <image_id>
```
Displays detailed information about a Docker image.

### 15. List Container Processes

```bash
docker top <container_id>
```
Displays the running processes inside a Docker container.

### 16. Pause a Container

```bash
docker pause <container_id>
```
Pauses all processes in a running container.

### 17. Unpause a Container

```bash
docker unpause <container_id>
```
Unpauses all processes in a paused container.

### 18. Restart a Container

```bash
docker restart <container_id>
```
Restarts a running or stopped container.

### 19. Rename a Container

```bash
docker rename <old_name> <new_name>
```
Renames a Docker container.

### 20. Stop All Running Containers

```bash
docker stop $(docker ps -q)
```
Stops all running Docker containers.

### 21. Remove All Stopped Containers

```bash
docker rm $(docker ps -a -q)
```
Removes all stopped Docker containers.

### 22. Remove All Images

```bash
docker rmi $(docker images -q)
```
Removes all Docker images from your local machine.

### 23. Build an Image from a Dockerfile

```bash
docker build -t <image_name> .
```
Builds a Docker image from a Dockerfile in the current directory.

### 24. Tag an Image

```bash
docker tag <image_id> <repository>/<image_name>:<tag>
```
Tags a Docker image.

### 25. Push an Image to Docker Hub

```bash
docker push <repository>/<image_name>:<tag>
```
Pushes a tagged image to Docker Hub.

### 26. Save an Image to a Tar File

```bash
docker save -o <path_to_tar_file> <image_name>
```
Saves a Docker image to a tar file.

### 27. Load an Image from a Tar File

```bash
docker load -i <path_to_tar_file>
```
Loads a Docker image from a tar file.

### 28. Show Docker System Information

```bash
docker info
```
Displays system-wide information about Docker.

### 29. Prune Unused Containers, Networks, and Images

```bash
docker system prune
```
Removes all stopped containers, unused networks, and dangling images.

### 30. Prune Unused Volumes

```bash
docker volume prune
```
Removes all unused local volumes.

### 31. Create a Volume

```bash
docker volume create <volume_name>
```
Creates a Docker volume.

### 32. List Volumes

```bash
docker volume ls
```
Lists all Docker volumes.

### 33. Inspect a Volume

```bash
docker volume inspect <volume_name>
```
Displays detailed information about a Docker volume.

### 34. Remove a Volume

```bash
docker volume rm <volume_name>
```
Removes a Docker volume.

### 35. Create a Network

```bash
docker network create <network_name>
```
Creates a Docker network.

### 36. List Networks

```bash
docker network ls
```
Lists all Docker networks.

### 37. Inspect a Network

```bash
docker network inspect <network_name>
```
Displays detailed information about a Docker network.

### 38. Connect a Container to a Network

```bash
docker network connect <network_name> <container_id>
```
Connects a container to a Docker network.

### 39. Disconnect a Container from a Network

```bash
docker network disconnect <network_name> <container_id>
```
Disconnects a container from a Docker network.

### 40. Remove a Network

```bash
docker network rm <network_name>
```
Removes a Docker network.

### 41. Export a Container to a Tar File

```bash
docker export <container_id> -o <path_to_tar_file>
```
Exports a container’s filesystem to a tar file.

### 42. Import a Container from a Tar File

```bash
docker import <path_to_tar_file>
```
Imports the contents of a tar file as a Docker image.

### 43. Commit Changes to a Container

```bash
docker commit <container_id> <new_image_name>
```
Creates a new image from a container’s changes.

### 44. Run a Container in Detached Mode

```bash
docker run -d <image_name>
```
Runs a container in the background.

### 45. Map Ports from Host to Container

```bash
docker run -p <host_port>:<container_port> <image_name>
```
Maps a port on the host to a port on the container.

### 46. Set Environment Variables

```bash
docker run -e <env_var>=<value> <image_name>
```
Sets environment variables in a container.

### 47. Mount a Host Directory as a Data Volume

```bash
docker run -v <host_dir>:<container_dir> <image_name>
```
Mounts a host directory as a data volume in a container.

### 48. Display Disk Usage

```bash
docker system df
```
Displays Docker disk usage.

### 49. Check for Docker Updates

```bash
docker version
```
Displays installed Docker version and checks for updates.

### 50. Monitor Docker Events

```bash
docker events
```
Displays real-time events from the Docker server.
