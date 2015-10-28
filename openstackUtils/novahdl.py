#!/usr/bin/env python

import novaclient.v1_1.servers as svclient
import novaclient.v1_1.client as nvclient
from credentials import get_nova_creds

creds = get_nova_creds()
nova = nvclient.Client(**creds)
svr = svclient.ServerManager(nova)


for server in nova.servers.list(search_opts={'all_tenants': 1}):
	if server.status == "ERROR":
		svr.reset_state(server.id,'active')
		svr.reboot(server.id,'SOFT')
