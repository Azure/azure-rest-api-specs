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

@doc("dstsApplication properties")
model DstsApplicationResourceProperties {
  @doc("Application.")
  applicationAccount: ApplicationAccount;

  @doc("The application group. Optional.")
  applicationGroup?: ApplicationGroup;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: dstsApplicationProvisioningState;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-invalid-chars" "Arm resource name must contain only alphanumeric characters"
@doc("dstsApplication Resource")
model DstsApplicationResource
  is ProxyResource<DstsApplicationResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("resourceName")
  @segment("dstsApplications") // start with lower case
  @visibility("read")
  @path
  name: string;
}

@doc("Application.")
model ApplicationAccount {
  @doc("The dSTS instance where the Application resides.")
  dstsInstance: string;

  @doc("The name of the Application.")
  name: string;

  @doc("Service Tree GUID of the service who owns the Application.")
  serviceTreeId: string;

  @doc("The realms of the application. Optional.")
  realms?: Array<string>;

  @doc("The Service Principal Names of the application. Optional.")
  servicePrincipalNames?: Array<string>;

  @doc("The Reply Addresses of application. Optional.")
  replyToAddresses?: Array<string>;

  @doc("GUID of the dSCM Application group to which the Application belongs. Optional.")
  groupId?: string;

  @doc("Group name of the dSCM Application group to which the Application belongs. Optional.")
  groupName?: string;

  @doc("If set to true, authenticating to the application requires MFA. Optional.")
  isMfaEnabled?: boolean = true;

  @doc("If it is null, full SAW enforcement will apply to the application. Optional.")
  sawDeviceEnforcement?: string;

  @doc("If you application (service) is exclusively limited to System Metadata, Read-Only access levels, set it to false. Optional.")
  isElevatedAccess?: boolean;

  @doc("If your application (service) is exclusively NonProduction, set it to false. Optional.")
  isProduction?: boolean = true;
}

@doc("The application group. Optional.")
model ApplicationGroup {
  @doc("Group id.")
  id?: string;

  @doc("Group service tree id.")
  serviceTreeId: string;

  @doc("Group name.")
  name: string;

  @doc("Group application name.")
  applicationName?: string;

  @doc("The Service Principal Names of the application. Optional.")
  servicePrincipalNames?: Array<string>;

  @doc("Actor realm.")
  realms?: Array<string>;

  @doc("The Reply Addresses of application. Optional.")
  replyToAddresses?: Array<string>;

  @doc("If set to true, authenticating to the application requires MFA. Optional.")
  isMfaEnabled?: boolean = true;

  @doc("If not set, default is regional service. Optional.")
  isGlobalService?: boolean;

  @doc("If it is null, full SAW enforcement will apply to the application. Optional.")
  sawDeviceEnforcement?: string;

  @doc("Change.Remove client token ip range.")
  clientTokenIpRangeRestrictions?: Array<IpRange>;

  @doc("Optional. If it is null, full SAW enforcement will apply to the application.")
  cloudId: string = "PROD";

  @doc("Optional.client subscriptions.")
  clientSubscriptions?: Array<string>;

  @doc("Specific dSTS instances to create applications on.")
  regions?: Array<string>;
}

@doc("Class for a contiguous range of IP Addresses.")
model IpRange {
  @doc("To IP address.")
  toIpAddress: string;
}

@doc("Provisioning status of the resource.")
enum dstsApplicationProvisioningState {
  ...ResourceProvisioningState,

  @doc("Accepted State")
  Accepted,
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DstsApplication {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DstsApplicationResource>;
  listBySubscription is ArmListBySubscription<DstsApplicationResource>;
  listByResourceGroup is ArmResourceListByParent<DstsApplicationResource>;
  get is ArmResourceRead<DstsApplicationResource>;
}
