from cinderhdl import CinderManager
from novahdl import NovaManager
import subprocess

def SSH(host):
	ssh = subprocess.Popen(["ssh", "%s" % host, "service cinder-volume restart"],
		shell=False,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE)
	return ssh.communicate()[0]

def main():
	cinder = CinderManager()
	nova = NovaManager()
	
	#reset volumes status
	cinder.resetErrorStatus()
	#restart cinder services
	SSH('ncc1701-d')
	SSH('storage01')
	#reset instances status
	nova.resetErrorStatus()

if __name__ == "__main__":
	main()
