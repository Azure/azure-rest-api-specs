# Hosted Agent Sessions

This folder contains TypeSpec definitions for **hosted agent session** operations
within the Foundry data-plane API.

## Scope

Session-scoped endpoints for hosted agents running on ADC (Azure Deployment Compute),

## Preview feature gate

All operations in this folder require the `HostedAgents=V1Preview` feature
opt-in via the `Foundry-Features` header.

## Files

- [models.tsp](./models.tsp) — Data models for session log streaming.
- [routes.tsp](./routes.tsp) — HTTP route definitions for session operations.
