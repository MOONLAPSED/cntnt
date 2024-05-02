import subprocess

subprocess.run(["conda", "jupyterjax", "create", "-f", "environment.yml"])
subprocess.run(["chsh", "-s", "$(which xonsh)"])