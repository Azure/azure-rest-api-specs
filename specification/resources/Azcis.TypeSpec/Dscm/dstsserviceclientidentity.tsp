import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCIS;

@doc("dstsServiceClientIdentity properties")
model DstsServiceClientIdentityResourceProperties {
  @doc("Gets or sets the account name. This is case-insensitive. E.g. \"%(ArmRegionName).acs.%($CS.ComputeDnsSuffix)\".")
  accountName: string;

  @doc("Gets or sets the DSTS instance endpoint FQDN, in which the account is created. This is case-insensitive. E.g. \"co2agg04-dsts.dsts.core.azure-test.net\" for dogfood.")
  dstsInstance: string;

  @doc("Gets or sets a list of claim provisionings.")
  claimProvisionings?: Array<DstsClaimProvisioning>;

  @doc("Gets or sets a list of required IP ranges. Optional.")
  requiredIpRanges?: Array<RequiredIpRange>;

  @doc("Gets or sets the GroupId of the account. This is case-insensitive. This is optional, and the account is placed into default group when this is not specified. This can be the GroupId of an existing group, which can be found at dSCM web portal. E.g. \"76c46cf8-a5b4-40e6-a561-b0eb1c303cd9\".")
  groupId?: string;

  @doc("Gets or sets the GroupName of the account. This is case-insensitive. This is optional, and the service client identity is placed into default group when this is not specified. This can be the GroupName of an existing group, which can be found at dSCM web portal.")
  groupName?: string;

  @doc("Gets or sets the region for the SCI. This is optional. E.g. \"francec\" for France Central..")
  region?: string;

  @doc("Gets or sets the subscriptions for the SCI. This is optional. E.g. \"5d711910-92ea-4ff9-b70d-1e61307faaac,a524674c-7024-40f1-afe9-127ab5a2e1b0\".")
  subscriptions?: string;

  @doc("Subject names.")
  subjectNames: Array<string>;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: DscmProvisioningState;
}

@doc("This model represents a claim provisioning in SCI.")
model DstsClaimProvisioning {
  @doc("Gets or sets the type of identity in the target service. This is case-insensitive. E.g. \"http://schemas.microsoft.com/ws/2008/06/identity/claims/role\".")
  claimType: string;

  @doc("Gets or sets the name or ID in the target service. This is case-insensitive. E.g. \"PlatformServiceViewer\" or \"PlatformServiceOperator\".")
  claimValue: string;

  @doc("Gets or sets the service account name of the target service. This is case-insensitive. E.g. \"target-service-%(ArmRegionName).acs.%($CS.ComputeDnsSuffix)\".")
  scopedToServiceAccount: string;

  @doc("Gets or sets the service account group id of the target service name.")
  scopedServiceAccountGroupId: string;

  @doc("Gets or sets the service account group name of the target service name.")
  scopedServiceAccountGroupName: string;

  @doc("Gets or sets the service tree id of the scoped service account.")
  scopedServiceTreeId: string;

  @doc("Dstsinstance for the claim. This is case-insensitive. E.g. \"co2agg04-dsts.dsts.core.azure-test.net\" for dogfood.")
  dstsInstance: string;
}

@doc("This model represents an IP range in SCI.")
model RequiredIpRange {
  @doc("Gets or sets the start of IP range. E.g. \"172.1.1.1\".")
  fromIpAddress: string;

  @doc("Gets or sets the end of IP range. E.g. \"172.1.1.5\".")
  toIpAddress: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-invalid-chars" "Arm resource name must contain only alphanumeric characters"
@doc("dstsServiceClientIdentityResource Resource")
model DstsServiceClientIdentityResource
  is ProxyResource<DstsServiceClientIdentityResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dstsServiceClientIdentities") // Start with lower case. Should be plural
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DstsServiceClientIdentity {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DstsServiceClientIdentityResource>;
  listBySubscription is ArmListBySubscription<DstsServiceClientIdentityResource>;
  listByResourceGroup is ArmResourceListByParent<DstsServiceClientIdentityResource>;
  get is ArmResourceRead<DstsServiceClientIdentityResource>;
}
