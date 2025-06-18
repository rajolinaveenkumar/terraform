### Real-Time Uses for remote-exec:

| Scenario               | `remote-exec` Command                  |
| ---------------------- | -------------------------------------- |
| Install packages       | `sudo yum install -y nginx`            |
| Start services         | `sudo systemctl start backend`         |
| Pull code from Git     | `git clone https://github.com/my/repo` |
| Run shell scripts      | `bash setup.sh`                        |
| Run Ansible playbook   | `ansible-playbook backend.yml`         |
| Register in monitoring | `curl -X POST to monitoring system`    |
