import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("dstsServiceAccount properties")
model DstsServiceAccountResourceProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Duplicate property " id " found in the resource envelope and resource properties."
  @doc("Unique ID of the service account. Its value can be a GUID for a new account, or for an existing account created by CIS resource template or by other method. Or its value can be null or empty string for a new account, or for an existing account created by CIS resource template (but not by other method). In the latter case, CIS generates a GUID to be the new account's ID, and remembers the ID for future provisioning of the same service account. This is case-insensitive.")
  id?: string;

  @doc("Service Account name, which must be unique for a given dsts endpoint. This is case-insensitive. E.g. \"%(ArmRegionName).acs.%($CS.ComputeDnsSuffix)\".")
  accountName: string;

  @doc("DSTS instance in which the account is created. This is case-insensitive. E.g. \"co2agg04-dsts.dsts.core.azure-test.net\" for dogfood.")
  dstsInstance: string;

  @doc("Display Name of the account.")
  displayName?: string;

  @doc("GroupId of the account. This is case-insensitive. This is optional, and the account is placed into default group when this is not specified. This can be the GroupId of an existing group, which can be found at dSCM web portal.")
  groupId?: string;

  @doc("GroupName of the account. This is case-insensitive. This is optional, and the account is placed into default group when this is not specified. This can be the GroupName of an existing group, which can be found at dSCM web portal.")
  groupName?: string;

  @doc("list of authentication requirements.")
  @extension("x-ms-identifiers", [])
  authenticationRequirements?: Array<DstsAuthenticationRequirement>;

  @doc("list of realms.")
  @extension("x-ms-identifiers", [])
  realms?: Array<DstsRealm>;

  @doc("list of claim mappings.")
  @extension("x-ms-identifiers", [])
  claimMappings?: Array<DstsClaimMapping>;

  @doc("Tags to add to the account.")
  accountTags?: Array<string>;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: DscmProvisioningState;
}

@doc("dstsServiceAccount Resource")
model DstsServiceAccountResource
  is ProxyResource<DstsServiceAccountResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dstsServiceAccounts") // Start with lower case. Should be plural
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DstsServiceAccount {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DstsServiceAccountResource>;
  listBySubscription is ArmListBySubscription<DstsServiceAccountResource>;
  listByResourceGroup is ArmResourceListByParent<DstsServiceAccountResource>;
  get is ArmResourceRead<DstsServiceAccountResource>;
}

@doc("Authenticaiton requirement of the account.")
model DstsAuthenticationRequirement {
  @doc("Authentication requirement value. E.g. \"PTH\".")
  value: string;
}

@doc("Realm information of the account.")
model DstsRealm {
  @doc("Realm's name. This is case-insensitive. E.g. \"svc://crpadmin@%(ArmRegionName).acs.%($CS.ComputeDnsSuffix)/\".")
  name: string;

  @doc("Realm's redirection URL. This is case-insensitive. E.g. \"https://%(ArmRegionName).acs.%($CS.ComputeDnsSuffix)/\".")
  redirectionUrl?: string;
}

@doc("Claim mapping for authorization of the account.")
model DstsClaimMapping {
  @doc("Type of input identity. This is case-insensitive. E.g. \"http://sts.msft.net/user/Group\".")
  inputType: string;

  @doc("Name or ID of input identity. E.g. \"%($CS.CplatViewerGroup)\".")
  inputValue?: string;

  @doc("Type of output identity, which is mapped from input identity. This is case-insensitive. E.g. \"http://schemas.microsoft.com/ws/2008/06/identity/claims/role\".")
  outputType: string;

  @doc("Name or ID of output identity, which is mapped from input identity. E.g. \"PlatformServiceViewer\" or \"PlatformServiceOperator\".")
  outputValue?: string;

  @doc("Federation context for the mapping. E.g. \"MSIT-ADFS-Federation\" or \"BF-ADFS-Federation\".")
  federation?: string;
}
