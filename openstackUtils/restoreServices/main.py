#!/bin/env python

from cinderhdl import CinderManager
from novahdl import NovaManager
import subprocess

def SSH(host):
	ssh = subprocess.Popen(["ssh", "%s" % host, "service cinder-volume restart"],
		shell=False,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE)
	return ssh.communicate()[0]

def fixVolumes(cindermanager):
    #reset volumes status
    print "checking for volumes in error state"
    cindermanager.resetErrorStatus()
    print "done"

def rebootVolumeService(cindermgmt):
    #restart cinder services
    print "restarting cinder service to ncc1701-d via ssh"
    SSH('ncc1701-d')
    print "done"
    print "restarting cinder service to storage01 via ssh"
    SSH('storage01')
    print "done"

def printMenu():
    print "1 - show volumes"
    print "2 - fix volumes"
    print "3 - show instances state"
    print "4 - reboot error instances" 
    print "0 - exit"
    
def main(cindermgmt,novamgmt):
    while (True):
	printMenu()
	choice = int(input())
	if choice == 1:
            cindermgmt.getVolumesStatus()
	elif choice == 3:
            fixVolumes(cindermgmt)
            rebootVolumeService(cindermgmt)
            novamgmt.resetErrorStatus()
	elif choice == 0:
            exit()

if __name__ == "__main__":
    cinder = CinderManager()
    nova = NovaManager()
    main(cinder,nova)
