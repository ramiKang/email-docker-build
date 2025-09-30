# Email Analysis Docker Environment

## Environment
This Docker environment is built on top of:
- **OS**: Ubuntu 22.04  
- **CUDA**: 12.5.1  
- **cuDNN**: 9.3.0.75  
- **Python**: 3.9  
- **PyTorch**: 2.4.1 (CUDA 12.6 wheels)  
- **TensorFlow**: 2.20.0  
- **JupyterLab**: latest  

The base image (`email-analysis-base:latest`) is already built with the above configuration.

## docker-compose.yml Configuration
When using `docker-compose.yml`, the following fields can be customized:

- **container_name**

  ```yaml
  container_name: email_env_xxx # e.g) email_env_haram, email_env_phoebe
  ```
  This difines the actual name of the container that will be created and shown when you run `docker ps`

- **volumes**

  ```yaml
  volumes:
  - ./your_local_dir:/workspace # e.g) - home/haram/phishing-analysis:/workspace
  ```
  This maps a local directory (`./your_local_dir`) to a directory inside the container (`./workspace`).
  Any files you add, delete, or modify in the local folder will be reflected inside the container, and vice versa.

- **ports**

  ```yaml
  ports:
  - "13000:8888" # This is {host_port}:{jupyter_port in docker} e.g) 12300:8888, 12301:8888
  ```
  This configuration is required for using JupyterLab via SSH port forwarding.
  If you plan to use JupyterLab, this mapping is essential because it allows you to access the service running inside the container through your web browser on the host machine.
  Note: Make sure that the chosen host port (e.g., 13000) is not already in use on your local machine or on the remote server. Otherwise, port conflicts may occur.

## How to Run
  ### 0. Connect to the GenAI Server
  ```bash
  ssh {user_name}@unlv-genAI.cs.unlv.edu
  ```
  
  ### 1. Clone the repository
  ```bash
  git clone https://github.com/your-repo/email-docker-env.git
  cd email-docker-env
  ```

  ### 2. Adjust docker-compose.yml
  Open docker-compose.yml and update the following fields to match your setup:
  * **container_name** → the actual container name that will be created
  * **volumes** → map your local project directory to /workspace inside the container
  * **ports** → set a host port that is available both locally and on the remote server

  ### 3. Re-connect to the GenAI Server for SSH Port Forwarding
  ```bash
  ssh -L {jupyter_port}:localhost:{host_port} {user_name}@unlv-genAI.cs.unlv.edu # e.g ) ssh -L 8888:localhost:12300 haramkang@unlv-genAI.cs.unlv.edu
  ```

  ### 4. Start the container
  ```bash
  cd email-docker-env
  docker compose up -d
  ```

  ### 5. Access the container
  ```bash
  docker exec -it {container_name} bash # e.g) docker exec -it email_env_haram bash
  ```

  #### 6. (Option) Launch JupyterLab inside the container (in Docker Env)
  ```bash
  jupyter lab --ip=0.0.0.0 --port={jupyter_port} --allow-root # e.g) jupyter lab --ip=0.0.0.0 --port=8888 --allow-root
  ```bash
