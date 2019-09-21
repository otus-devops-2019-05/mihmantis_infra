#!/usr/bin/env python3

import json

with open('inventory.json', 'r') as f:
    inventory = f.read()

print(inventory)

