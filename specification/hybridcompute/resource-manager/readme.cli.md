# CLI HybridCompute

This directory contains the Cli common model for the Hybrid Compute service.

> Metadata
``` yaml
title: 'ConnectedMachine'

cli:
    cli-directive:
      - select: 'operationGroup'
        where:
            operationGroup: 'operations'
        hidden: true
      - select: 'operation'
        where:
            operationGroup: 'machines'
            operation: '(reconnect|createOrUpdate|update)'
        removed: true
      - where:
            param: ^.*instance-view.*$
        json: true
        hidden: true
```
