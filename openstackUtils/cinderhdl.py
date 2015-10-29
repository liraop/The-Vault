#!/usr/bin/env python

import cinderclient.v1 as cclient
import cinderclient.v1.volumes as volclient
import os

cinder = cclient.Client(os.environ['OS_USERNAME'],os.environ['OS_PASSWORD'],os.environ['OS_TENANT_NAME'],os.environ['OS_AUTH_URL'],service_type="volume")
volmgmt = volclient.VolumeManager(cinder)

for volume in  cinder.volumes.list(search_opts={'all_tenants': 1}):
	if volume.status == 'error':
		volmgmt.reset_state(volume.id,'in-use')
