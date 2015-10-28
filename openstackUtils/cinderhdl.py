#!/usr/bin/env python

import cinderclient.v1 as cclient
from credentials import get_nova_creds

credentials = get_nova_creds
cinder = cclient.Client(credentials)
