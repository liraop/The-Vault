#!/usr/bin/env python

import cinderclient.v1 as cclient
import cinderclient.v1.volumes as volclient
import cinderclient.v1.services as svcclient
import os
import time

class CinderManager(object):

	def __init__(self):
		self.cinder = cclient.Client(os.environ['OS_USERNAME'],os.environ['OS_PASSWORD'],os.environ['OS_TENANT_NAME'],os.environ['OS_AUTH_URL'],service_type="volume")
		self.volmgmt = volclient.VolumeManager(self.cinder)
		self.svcmgmt = svcclient.ServiceManager(self.cinder)


	def resetErrorStatus(self):
		for volume in  self.cinder.volumes.list(search_opts={'all_tenants': 1}):
			if volume.status == 'error':
				print "reseting: "+volume.id
				self.volmgmt.reset_state(volume.id,'in-use')
				time.sleep(2)
                print "Done reseting volume states"

	def getVolumesStatus(self):
		for volume in self.cinder.volumes.list(search_opts={'all_tenants': 1}):
			print "ID: "+volume.id+"--- Status: "+ volume.status
                print "\n"
