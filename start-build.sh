#! /bin/bash
docker run -d -t -p 3522:22 --volume=/Users/yknx4/.ssh/id_rsa.pub:/root/.ssh/authorized_keys --name=aleworld-builder aleworld-build
