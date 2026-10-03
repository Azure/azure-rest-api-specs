using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.DigitalAssets;

@doc("An EVM contract address in canonical 0x-prefixed hex form.")
@pattern("^0x[a-fA-F0-9]{40}$")
scalar EvmContractAddress extends string;

@doc("Connection settings for the customer's source ledger.")
model ZkpRollupSource {
  @doc("Source configuration kind.")
  kind?: string;

  @doc("Boot node enode URLs used for peer discovery.")
  @maxItems(25)
  bootnodes?: string[];

  @doc("Static peer enode URLs used for ledger connectivity.")
  @maxItems(25)
  staticPeers?: string[];

  @doc("RPC endpoint URLs used to initialize the ledger.")
  @maxItems(25)
  rpcEndpoints?: string[];
}

@doc("Connection settings that may be changed in a rollup PATCH request.")
model ZkpRollupPatchSource {
  @doc("Source configuration kind.")
  kind?: string;

  @doc("Boot node enode URLs used for peer discovery.")
  @maxItems(25)
  bootnodes?: string[];

  @doc("Static peer enode URLs used for ledger connectivity.")
  @maxItems(25)
  staticPeers?: string[];

  @doc("RPC endpoint URLs used to initialize the ledger.")
  @maxItems(25)
  rpcEndpoints?: string[];
}

@doc("Details of the DigitalAssets ZkpRollup.")
model ZkpRollupProperties {
  @doc("Rollup-level list of token owner account addresses used for auto-discovery.")
  @minItems(1)
  @maxItems(100)
  tokenOwnerAccounts: EvmContractAddress[];

  @doc("Connection settings for the customer's source ledger.")
  source?: ZkpRollupSource;

  @doc("Rollup-level Key Vault reference used to resolve Besu node private keys.")
  keyVault: KeyVaultReference;

  @doc("User-assigned managed identity resource ID used for customer Key Vault reads.")
  keyVaultUserAssignedIdentityResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Number of L2 blocks batched into a single proof. Must be a power of 2 (runtime-enforced). Immutable after create; changing it requires deleting and recreating the rollup. Default is 2 when omitted on create.")
  @minValue(1)
  @maxValue(16384)
  blocksPerProof?: int32 = 2;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Public IPv4 address of the customer's VPN device. Set on create or replace; not updatable via PATCH.")
  customerVpnPublicIp?: string;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Customer on-premises address prefixes reachable across the VPN tunnel (the Local Network Gateway address space). Must not overlap the RP-reserved 10.128.0.0/10 block. Set on create or replace; not updatable via PATCH.")
  @maxItems(25)
  customerOnPremAddressPrefixes?: string[];

  @visibility(Lifecycle.Read)
  @doc("Read-only public IP address of this service's VPN Gateway. This is the far-end address the customer configures on their Local Network Gateway and Site-to-Site VPN connection. Populated once the service's VPN tunnel is provisioned.")
  serviceVpnPublicIp?: string;

  @visibility(Lifecycle.Read)
  @doc("Read-only address space (a /21 CIDR, e.g. 10.160.0.0/21) assigned to this service's end of the VPN tunnel. Populated once the service's VPN tunnel is provisioned.")
  serviceVpnAddressSpace?: string;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Enode id (public key) of the customer's L2 Besu boot node. Set on create or replace; not updatable via PATCH.")
  bootNodeId: string;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Private IPv4 address of the customer's L2 Besu boot node. Set on create or replace; not updatable via PATCH.")
  bootNodeIp: string;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("P2P (devp2p) port of the customer's L2 Besu boot node. Set on create or replace; not updatable via PATCH.")
  @minValue(1)
  @maxValue(65535)
  bootNodeP2pPort: int32;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("JSON-RPC (HTTP) port of the customer's L2 Besu boot node. Set on create or replace; not updatable via PATCH.")
  @minValue(1)
  @maxValue(65535)
  bootNodeRpcPort: int32;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Service Bus endpoint (URL) for customer access. Set on create or replace; not updatable via PATCH.")
  serviceBusEndpoint: url;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Queue name for customer Service Bus access. Set on create or replace; not updatable via PATCH.")
  serviceBusQueueName: string;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Optional customer-supplied Microsoft Entra object ID for the Service Bus consumer principal. Supply it on initial create; subsequent replacements preserve the original value. When provided, it must be a GUID. A role assignment is not guaranteed.")
  serviceBusConsumerPrincipalId?: string;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Properties that may be updated via PATCH on a ZkpRollup.")
model ZkpRollupPatchProperties {
  @doc("Rollup-level list of token owner account addresses used for auto-discovery.")
  @minItems(1)
  @maxItems(100)
  tokenOwnerAccounts?: EvmContractAddress[];

  @doc("Connection settings for the customer's source ledger.")
  source?: ZkpRollupPatchSource;

  @doc("Rollup-level Key Vault reference used to resolve Besu node private keys.")
  keyVault?: KeyVaultPatchReference;

  @doc("User-assigned managed identity resource ID used for customer Key Vault reads.")
  keyVaultUserAssignedIdentityResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

@doc("Key Vault reference properties that may be updated via PATCH.")
model KeyVaultPatchReference {
  @doc("The ARM resource ID of the Key Vault.")
  id?: armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A DigitalAssets ZKP rollup resource.")
model ZkpRollup is TrackedResource<ZkpRollupProperties> {
  @doc("The name of the ZKP rollup resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("zkpRollupName")
  @segment("zkpRollups")
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
}

@armResourceOperations(ZkpRollup)
interface ZkpRollups {
  get is ArmResourceRead<ZkpRollup>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ZkpRollup>;
  update is ArmCustomPatchSync<
    ZkpRollup,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ZkpRollup,
      ZkpRollupPatchProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ZkpRollup>;
  listByResourceGroup is ArmResourceListByParent<ZkpRollup>;
  listBySubscription is ArmListBySubscription<ZkpRollup>;
}
