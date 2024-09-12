# Concordium

This helm chart deploys a Concordium node on a Kubernetes cluster.

## Base of Corcodium documentation

Documentation on run it using Docker was used to create this chart,
Concordiums documentation can be found [here](https://developer.concordium.software/en/mainnet/net/guides/run-node.html).

## Configuration

To specify which network the node should connect to, set the `network` value in the `values.yaml` file.
This can be either `mainnet` or `testnet`:

```yaml
network: mainnet
```

### Collector

The collector is a separate service that collects metrics from the node and sends them to the [ccdscan](https://ccdscan.io).

To enable the collector, set the `collector.enabled` value in the `values.yaml` file to `true` and set the `collector.nodeName` to the name of the node that should be displayed in the explorer.

```yaml
# collector configures the collector that collects statistics from the node and publishes them to the network dashboard.
collector:
  # enabled specifies if the collector should run or not.
  enabled: true
  # nodeName contains the name to report to the network dashboard. https://concordium.com/block-explorers/
  nodeName:
```

### Important note

The node can take days to catch up and sync with the rest of the network, so be patient.
