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

def main():
        cinder = CinderManager()
        nova = NovaManager()

        #reset volumes status
       # print "checking for volumes in error state"
       # cinder.resetErrorStatus()
       # print "done"
        #restart cinder services
       # print "restarting cinder service to ncc1701-d via ssh"
       # SSH('ncc1701-d')
       # print "done"
       # print "restarting cinder service to storage01 via ssh"
       # SSH('storage01')
       # print "done"
        #reset instances status
       # nova.resetErrorStatus()

	print cinder.getVolumesStatus()

if __name__ == "__main__":
        main()

