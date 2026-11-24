using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.DigitalAssets;

@doc("An EVM contract address in canonical 0x-prefixed hex form.")
@pattern("^0x[a-fA-F0-9]{40}$")
scalar EvmContractAddress extends string;

@doc("Details of the DigitalAssets ZkpRollup.")
model ZkpRollupProperties {
  @doc("Rollup-level owner accounts used for contract discovery. Updates affect future discovery after configuration is applied; existing checkpoints and discovered contracts are preserved.")
  @minItems(1)
  @maxItems(100)
  tokenOwnerAccounts: EvmContractAddress[];

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The fully qualified resource ID of the customer Key Vault used to resolve Besu node private keys. Required on PUT and immutable after creation.")
  keyVaultId: armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("User-assigned managed identity resource ID used for customer Key Vault reads. Immutable after creation; this identity must remain attached to the rollup.")
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
  @doc("Public IPv4 address of the customer's VPN device. Set on create and immutable afterward.")
  customerVpnPublicIp?: string;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Customer on-premises address prefixes reachable across the VPN tunnel (the Local Network Gateway address space). Must not overlap the RP-reserved 10.128.0.0/10 block. Set on create and immutable afterward.")
  @maxItems(25)
  customerOnPremAddressPrefixes?: string[];

  @visibility(Lifecycle.Read)
  @doc("Read-only public IP address of this service's VPN Gateway. This is the far-end address the customer configures on their Local Network Gateway and Site-to-Site VPN connection. Populated once the service's VPN tunnel is provisioned.")
  serviceVpnPublicIp?: string;

  @visibility(Lifecycle.Read)
  @doc("Read-only address space (a /21 CIDR, e.g. 10.160.0.0/21) assigned to this service's end of the VPN tunnel. Populated once the service's VPN tunnel is provisioned.")
  serviceVpnAddressSpace?: string;

  @doc("Enode id (public key) of the customer's L2 Besu boot node. Required on PUT. Updates reconcile the existing partition and must remain on the same ledger.")
  bootNodeId: string;

  @doc("Private IPv4 address of the customer's L2 Besu boot node. Required on PUT. Updates reconcile the existing partition.")
  bootNodeIp: string;

  @doc("P2P (devp2p) port of the customer's L2 Besu boot node. Required on PUT. Updates reconcile the existing partition.")
  @minValue(1)
  @maxValue(65535)
  bootNodeP2pPort: int32;

  @doc("JSON-RPC (HTTP) port of the customer's L2 Besu boot node. Required on PUT. Updates reconcile the existing partition.")
  @minValue(1)
  @maxValue(65535)
  bootNodeRpcPort: int32;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("URL of the customer-provided Service Bus namespace to which proofs are published. Required on PUT. Set only on initial creation; cannot be changed by PUT or PATCH.")
  serviceBusEndpoint: url;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Name of the customer-provided Service Bus queue to which proofs are published. Required on PUT. Set only on initial creation; cannot be changed by PUT or PATCH.")
  serviceBusQueueName: string;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("Operational status of the rollup.")
  operationalStatus?: OperationalStatus;
}

@doc("Properties that may be updated via PATCH on a ZkpRollup.")
model ZkpRollupPatchProperties {
  @doc("Replacement list of owner accounts for future contract discovery. Omission preserves the current list; existing checkpoints and discovered contracts are retained.")
  @minItems(1)
  @maxItems(100)
  tokenOwnerAccounts?: EvmContractAddress[];

  @doc("Replacement boot-node public key on the same ledger. Omission preserves the current value.")
  bootNodeId?: string;

  @doc("Replacement boot-node IPv4 address. Omission preserves the current value.")
  bootNodeIp?: string;

  @doc("Replacement boot-node P2P port. Omission preserves the current value.")
  @minValue(1)
  @maxValue(65535)
  bootNodeP2pPort?: int32;

  @doc("Replacement boot-node JSON-RPC port. Omission preserves the current value.")
  @minValue(1)
  @maxValue(65535)
  bootNodeRpcPort?: int32;
}

@doc("Partial managed-identity update. Omitted attachments remain; object entries add or retain an identity and null entries remove it. The selected Key Vault identity must remain attached.")
model ZkpRollupIdentityUpdate
  is OptionalProperties<UpdateableProperties<Azure.ResourceManager.Foundations.ManagedServiceIdentity>>;

@doc("Rollup update payload. Omitted fields are preserved. Configuration changes may restart partition containers; tags and identity-only changes complete synchronously.")
model ZkpRollupUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  @doc("Managed-identity attachment changes.")
  identity?: ZkpRollupIdentityUpdate;

  @doc("Mutable rollup configuration fields.")
  properties?: ZkpRollupPatchProperties;
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
  @doc("Creates or replaces a ZKP rollup.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ZkpRollup>;
  @doc("Updates rollup tags, identity attachments or configuration. Metadata-only updates complete synchronously. Configuration changes reconcile the rollup and existing partition asynchronously, preserving checkpoints and discovered contracts.")
  @finalOperation(ZkpRollups.get)
  update is ArmCustomPatchAsync<
    ZkpRollup,
    ZkpRollupUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ZkpRollup> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    ZkpRollup,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
  listByResourceGroup is ArmResourceListByParent<ZkpRollup>;
  listBySubscription is ArmListBySubscription<ZkpRollup>;
}
