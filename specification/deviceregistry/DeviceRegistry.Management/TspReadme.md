``` yaml
isArm: true
isAzureSpec: true
library-name: DeviceRegistry
require: https://github.com/Azure/azure-rest-api-specs/blob/main/specification/deviceregistry/resource-manager/readme.md
tag: package-preview-2023-11
skip-csproj: true
modelerfour:
  lenient-model-deduplication: true
#   flatten-payloads: false
use-model-reader-writer: true

# format-by-name-rules:
#   'tenantId': 'uuid'
#   'ETag': 'etag'
#   'location': 'azure-location'
#   '*Uri': 'Uri'
#   '*Uris': 'Uri'

# no-property-type-replacement:
# - ManagedHsmVirtualNetworkRule

# acronym-mapping:
#   CPU: Cpu
#   CPUs: Cpus
#   Os: OS
#   Ip: IP
#   Ips: IPs|ips
#   ID: Id
#   IDs: Ids
#   VM: Vm
#   VMs: Vms
#   Vmos: VmOS
#   VMScaleSet: VmScaleSet
#   DNS: Dns
#   VPN: Vpn
#   NAT: Nat
#   WAN: Wan
#   Ipv4: IPv4|ipv4
#   Ipv6: IPv6|ipv6
#   Ipsec: IPsec|ipsec
#   SSO: Sso
#   URI: Uri
#   Etag: ETag|etag
#   Managecontacts: ManageContacts
#   Getissuers: GetIssuers
#   Listissuers: ListIssuers
#   Setissuers: SetIssuers
#   Deleteissuers: DeleteIssuers
#   Manageissuers: ManageIssuers
#   Regeneratekey: RegenerateKey
#   Deletesas: DeleteSas
#   Getsas: GetSas
#   Listsas: ListSas
#   Setsas: SetSas
#   Mhsm: ManagedHsm

# rename-mapping:
#   CheckMhsmNameAvailabilityResult: ManagedHsmNameAvailabilityResult
#   CheckMhsmNameAvailabilityResult.nameAvailable : IsNameAvailable
#   CheckMhsmNameAvailabilityParameters: MhsmNameAvailabilityParameters
#   Reason: ManagedHsmNameUnavailableReason
#   ActivationStatus: ManagedHSMSecurityDomainActivationStatus
#   Attributes: SecretBaseAttributes
#   GeoReplicationRegionProvisioningState: ManagedHsmGeoReplicatedRegionProvisioningState
#   ManagedHsmPrivateEndpointConnectionItemData.id: -|arm-id
#   Secret: KeyVaultSecret
#   MhsmPrivateEndpointConnectionItem: ManagedHsmPrivateEndpointConnectionItemData
#   MhsmPrivateEndpointConnectionItem.id: -|arm-id
#   MhsmPrivateLinkResource: ManagedHsmPrivateLinkResourceData
#   ActionsRequired: ManagedHsmActionsRequiredMessage
#   NetworkRuleAction: ManagedHsmNetworkRuleAction
#   NetworkRuleBypassOptions: ManagedHsmNetworkRuleBypassOption
#   MhsmVirtualNetworkRule.id: SubnetId|arm-id
#   PublicNetworkAccess: ManagedHsmPublicNetworkAccess
#   CreateMode: ManagedHsmCreateMode
#   ManagedHsmProperties.networkAcls: NetworkRuleSet
#   MhsmipRule: ManagedHsmIPRule
#   DeletedManagedHsmProperties.mhsmId: -|arm-id
#   DeletedVaultProperties: DeletedKeyVaultProperties
#   DeletedVault: DeletedKeyVault
#   MhsmipRule.value: AddressRange
#   PrivateLinkResource: KeyVaultPrivateLinkResourceData
#   AccessPolicyEntry: KeyVaultAccessPolicy
#   NetworkRuleSet: KeyVaultNetworkRuleSet
#   VaultCheckNameAvailabilityParameters: KeyVaultNameAvailabilityContent
#   VaultAccessPolicyProperties: KeyVaultAccessPolicyProperties
#   PrivateEndpointConnectionItem: KeyVaultPrivateEndpointConnectionItemData
#   VaultCheckNameAvailabilityParameters.type: -|resource-type
#   VaultPatchProperties: KeyVaultPatchProperties
#   VaultAccessPolicyParameters: KeyVaultAccessPolicyParameters
#   VaultPatchProperties.networkAcls: NetworkRuleSet
#   VaultProperties: KeyVaultProperties
#   VaultProperties.networkAcls: NetworkRuleSet
#   Vault: KeyVault
#   VirtualNetworkRule: KeyVaultVirtualNetworkRule
#   DeletedVaultProperties.vaultId: -|arm-id
#   Permissions: IdentityAccessPermissions
#   IPRule: KeyVaultIPRule
#   KeyPermissions: IdentityAccessKeyPermission
#   SecretPermissions: IdentityAccessSecretPermission
#   StoragePermissions: IdentityAccessStoragePermission
#   CertificatePermissions: IdentityAccessCertificatePermission
#   IPRule.value: AddressRange
#   CheckNameAvailabilityResult: KeyVaultNameAvailabilityResult

# prompted-enum-values: Default
```
