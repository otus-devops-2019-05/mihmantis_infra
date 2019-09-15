#!/usr/bin/env python3

import json
import argparse
import subprocess
from collections import OrderedDict


def arg_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('--list', dest='list_flag', action='store_true')
    return parser.parse_args()


def main():
    list_flag = arg_parser().list_flag
    inventory = {
        "app": {"vars": {}},
        "db": {"vars": {}},
        "_meta": {}
    }

    for gcloud_server_name, server_name, server_group in [('reddit-app', 'appserver', 'app'),
                                                          ('reddit-db', 'dbserver', 'db')]:
        cmd = [
            'gcloud', 'compute', 'instances', 'list', '--filter', 'name:( {} )'.format(gcloud_server_name)
        ]
        proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        output, error = proc.communicate()

        if output:
            server_ip = output.splitlines()[1].split()[4].decode()
            inventory[server_group]["hosts"] = [server_ip]

    if list_flag:
        print(json.dumps(inventory))


if __name__ == '__main__':
    main()

