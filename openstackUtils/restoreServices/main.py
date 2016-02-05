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

def fixVolumes(cindermgmt):
    #reset volumes status
    print "checking for volumes in error state"
    cindermgmt.resetErrorStatus()
    print "done"

def rebootVolumeService(cindermgmt):
    #restart cinder services
    print "restarting cinder service to ncc1701-d via ssh"
    SSH('ncc1701-d')
    print "done"
    print "restarting cinder service to storage01 via ssh"
    SSH('storage01')
    print "done"

def mainMenu():
    print "1 - show volumes"
    print "2 - fix error volumes"
    print "3 - show instances state"
    print "4 - fix error instances" 
    print "0 - exit"

def main(cindermgmt,novamgmt):
    while (True):
	mainMenu()
	choice = int(input())
	if choice == 1:
            cindermgmt.getVolumesStatus()
        elif choice == 2:
            fixVolumes(cindermgmt)
            rebootVolumeService(cindermgmt)
	elif choice == 3:
            novamgmt.getVmStatus()
        elif choice == 4:
            choice = int(input("Reboot type: 0 - Soft 1 - Hard\n"))
            novamgmt.restoreVmStatus(choice)
	elif choice == 0:
            exit()
	else:
            print "invalid choice"

if __name__ == "__main__":
    cinder = CinderManager()
    nova = NovaManager()
    main(cinder,nova)
