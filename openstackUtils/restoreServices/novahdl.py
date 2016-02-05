import novaclient.v1_1.servers as svclient
import novaclient.v1_1.client as nvclient
from credentials import get_nova_creds
import time

class NovaManager(object): 

	def __init__(self):
		self.creds = get_nova_creds()
		self.nova = nvclient.Client(**self.creds)
		self.svr = svclient.ServerManager(self.nova)
		
	def resetErrorStatus(self):
		for server in self.nova.servers.list(search_opts={'all_tenants': 1}):
			if server.status == "ERROR":
				try:
					print "reseting "+server.name
					self.svr.reset_state(server.id,'active')
					print "rebooting "+server.name
					self.svr.reboot(server.id,'SOFT')
				except:
					pass
				time.sleep(10)
				
