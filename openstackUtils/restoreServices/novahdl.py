import novaclient.v1_1.servers as svclient
import novaclient.v1_1.client as nvclient
from credentials import get_nova_creds
import time
import sys

class NovaManager(object): 

    def __init__(self):
       self.creds = get_nova_creds()
       self.nova = nvclient.Client(**self.creds)
       self.svr = svclient.ServerManager(self.nova)

    def restoreVmStatus(self,rebootType):
        for server in self.nova.servers.list(search_opts={'all_tenants': 1}):
            if server.status == "ERROR":
                try:
                    print "reseting "+server.name
                    self.svr.reset_state(server.id,'active')
                    rebootVm(server.id,rebootType)
                except:
                    print "ERROR: ", sys.exc_info()[0]
                time.sleep(2)
        print "done restoring vm status"  


    def rebootVm(self,vmname,rebootType):
        print "rebooting "+server.name
        if rebootType == 0:
            rebootMode = 'SOFT'
        else:
            rebootMode = 'HARD'
        self.svr.reboot(server.id,rebootMode)

         
    def getVmStatus(self):
        for server in self.nova.servers.list(search_opts={'all_tenants': 1}):
            print "Server: ",server.name,"--- Status: ",server.status
	print "\n"

