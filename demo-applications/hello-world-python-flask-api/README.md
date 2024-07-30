
# Deploying a Python Flask Application with Docker on AWS EC2

## Introduction

### What is Docker?

**Docker** is an open-source platform that automates the deployment, scaling, and management of applications. Docker packages software into standardized units called containers that have everything the software needs to run, including libraries, system tools, code, and runtime.

### What is a Container?

A **container** is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, libraries, and settings. Containers are isolated from one another and the host system, ensuring that they work uniformly despite differences between development and staging.

## Example: Python Flask Application with Endpoints

In this article, we will deploy a Python Flask application with Docker on an AWS EC2 instance. This application includes the following endpoints:
- `/`: Returns a "Hello World" message.
- `/authenticate`: Takes a username and password in the body of a JSON request and returns a token if the credentials are correct.

### app.py

```python
from flask import Flask, request, jsonify
import logging

app = Flask(__name__)

# Setup logging
logging.basicConfig(level=logging.DEBUG)

@app.route('/')
def hello():
    app.logger.info("Serving the Hello World response")
    app.logger.info("Diagnostic Message : Inside the Hello Method.......")
    return "Hello World! This is from Container Deployed using Docker"

@app.route('/authenticate', methods=['POST'])
def authenticate():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    if username == "Ameet" and password == "Parse":
        app.logger.info(f"Successful login for user: {username}")
        return jsonify({"token": "some-token-value"}), 200
    else:
        app.logger.warning(f"Failed login attempt for user: {username}")
        return jsonify({"error": "Invalid username or password"}), 401

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80, debug=True)
```

### Dockerfile

```Dockerfile
FROM python:3.8-slim-buster

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

CMD ["python3", "app.py"]
```

### requirements.txt

```txt
Flask==2.1.1
```

## How to Build and Run the Docker Container

### Prerequisites

- Docker and AWS CLI should already be installed and configured on your system.
- An EC2 instance running on AWS.

### Steps

1. **Create and Upload Files**

   Ensure you have the `app.py`, `Dockerfile`, and `requirements.txt` files in your project directory.

2. **Build the Docker Image**

   Open a terminal and navigate to your project directory. Build the Docker image with the following command:

   ```sh
   docker build -t my-flask-app .
   ```

3. **Run the Docker Container**

   Run the Docker container on port 80 using the following command:

   ```sh
   docker run -d -p 80:80 my-flask-app
   ```

4. **Verify the Application**

   Open your web browser and navigate to your EC2 instance's public IP address. You should see the "Hello World" message.

   To test the `/authenticate` endpoint, you can use a tool like `curl` or Postman:

   ```sh
   curl -X POST http://<your-ec2-public-ip>/authenticate -H "Content-Type: application/json" -d '{"username": "Ameet", "password": "Parse"}'
   ```

### Managing Docker Containers

1. **List Running Containers**

   To list all running Docker containers, use the following command:

   ```sh
   docker ps
   ```

2. **Stop a Running Container**

   To stop a running Docker container, use the following command with the container ID or name:

   ```sh
   docker stop <container_id_or_name>
   ```

3. **Stop All Running Containers**

   To stop all running Docker containers, use the following command:

   ```sh
   docker stop $(docker ps -q)
   ```

4. **Remove a Docker Container**

   To remove a stopped Docker container, use the following command with the container ID or name:

   ```sh
   docker rm <container_id_or_name>
   ```

5. **Remove All Stopped Containers**

   To remove all stopped Docker containers, use the following command:

   ```sh
   docker rm $(docker ps -a -q)
   ```

6. **View Logs of a Container**

   To view the logs of a running Docker container, use the following command with the container ID or name:

   ```sh
   docker logs <container_id_or_name>
   ```

7. **Execute a Command in a Running Container**

   To execute a command inside a running Docker container, use the following command with the container ID or name:

   ```sh
   docker exec -it <container_id_or_name> <command>
   ```

8. **Get Detailed Information about a Container**

   To get detailed information about a Docker container, use the following command with the container ID or name:

   ```sh
   docker inspect <container_id_or_name>
   ```

## Conclusion

In this article, we've covered the basics of Docker and containers and provided a step-by-step guide to deploying a Python Flask application using Docker on an AWS EC2 instance. We also covered how to manage Docker containers, including starting, stopping, and removing containers, as well as viewing logs and executing commands within containers. By following these steps, you can efficiently deploy and manage containerized applications using Docker.
