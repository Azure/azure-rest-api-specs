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

@doc("dsmsAllowlist properties")
model DsmsAllowlistResourceProperties {
  @doc("The name of the folder to apply allowlist changes to. This should be the full folder path starting with a '$', with '$' replacing all '/' characters. Example: '/my-folder/root-folder' should be passed as '$my-folder$root-folder")
  folderName: string; // camel case for the parameter name

  @doc("The dSMS endpoints to apply allowlist changes to. The folder specified in FolderName will be updated on each of the TargetDsmsEndpoints. If this is left null, this will default to all the dSMS endpoints used for the root folder.")
  targetDsmsEndpoints?: Array<string>;

  @doc("Dns domain patterns in the allowlist. Patterns with '*' are accepted values here.")
  dnsPatterns?: Array<string>;

  @doc("Guids of Azure deployment subscriptions in allowlist.")
  deploymentSubscriptions?: Array<string>;

  @doc("Guids of Azure storage subscriptions in allowlist.")
  storageSubscriptions?: Array<string>;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: DscmProvisioningState;
}

@doc("dsmsAllowlist Resource")
model DsmsAllowlistResource
  is ProxyResource<DsmsAllowlistResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dsmsAllowlists") // Start with lower case. Should be plural
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DsmsAllowlist {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DsmsAllowlistResource>;
  listBySubscription is ArmListBySubscription<DsmsAllowlistResource>;
  listByResourceGroup is ArmResourceListByParent<DsmsAllowlistResource>;
  get is ArmResourceRead<DsmsAllowlistResource>;
}
