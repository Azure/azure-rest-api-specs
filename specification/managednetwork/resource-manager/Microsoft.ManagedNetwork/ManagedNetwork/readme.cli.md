## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: managed-network
  namespace: azure.mgmt.managednetwork
  package-name: azure-mgmt-managednetwork
  cmd-override:
    "^.*[/]microsoft.managednetwork/scopeassignments([/][^/]*)?$": "managed-network scope-assignment"
    "^.*[/]managednetworkgroups([/][^/]*)?$": "managed-network group"
    "^.*[/]managednetworkpeeringpolicies([/][^/]*)?$": "managed-network peering-policy"
  option-override:
    "scope_management_groups_id":
      name: scope_management_groups
    "scope_subscriptions_id":
      name: scope_subscriptions
    "scope_virtual_networks_id":
      name: scope_virtual_networks
    "scope_subnets_id":
      name: scope_subnets
    "management_groups_id":
      name: management_groups
    "subscriptions_id":
      name: subscriptions
    "virtual_networks_id":
      name: virtual_networks
    "subnets_id":
      name: subnets
    "spokes_id":
      name: spokes
    "mesh_id":
      name: mesh
  flatten-all: true
  test-setup:
    - name: ManagedNetworksPut
    - name: ManagementNetworkGroupsPut
    - name: ScopeAssignmentsPut
    - name: ManagedNetworkPeeringPoliciesPut
    - name: ManagedNetworksGet
    - name: ManagedNetworksListByResourceGroup
    - name: ManagedNetworksListBySubscription
    - name: ScopeAssignmentsGet
    - name: ScopeAssignmentsList
    - name: ManagementNetworkGroupsGet
    - name: ManagedNetworksGroupsListByManagedNetwork
    - name: ManagedNetworkPeeringPoliciesGet
    - name: ManagedNetworkPeeringPoliciesListByManagedNetwork
    - name: ManagedNetworkPeeringPoliciesDelete
    - name: ScopeAssignmentsDelete
    - name: ManagementNetworkGroupsDelete
    - name: ManagedNetworksDelete
```
