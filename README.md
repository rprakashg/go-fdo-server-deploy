# go fdo server deploy
Create Manufacturing, Rendezvous and Owner container images that leverages Intel's FDO server implementation [go-fdo-server](https://github.com/fido-device-onboard/go-fdo-server)

## Building Images
Container images are built in a github actions workflow. Workflow first builds a builder container where latest [source](https://github.com/fido-device-onboard/go-fdo-server) of Intel's implementation of go FDO server is cloned and run go build to build the binaries.
After that we are building Manufacturing, Rendezvous and Owner container images all of which runs an instance of server binaries built in the builder container. We are using multistate builds to simply grab the binary from the builder container and start instance with specific configuration for manufacturing, rendezvous and owner respectively

## Deploy
Use an ansible playbook to automate deploying these containers on a RHEL host and run them as podman quadlets

Playbook simply creates quadlet files for volume and containers. Volume is used to store the SQLLite database created by FDO servers for storing state. This way we don't lose the data when container dies as the SQLLite db files will be persisted on the RHEL host




