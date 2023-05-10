# Deprecated

The umbrel-dev CLI is now deprecated. To virtualize a local Umbrel instance for development we recommend using [Multipass](https://multipass.run/).

Once Multipass is installed you can run an Umbrel VM with:

```shell
multipass launch --name umbrel-dev --disk 10G
multipass exec umbrel-dev -- sh -c 'curl -L https://umbrel.sh | bash'
```

You can get an interactive shell inside the VM with:

```shell
multipass shell umbrel-dev
```