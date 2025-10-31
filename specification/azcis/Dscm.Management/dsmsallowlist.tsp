import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

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

  @doc("The Azure location")
  @added(Versions.v2024_06_24_preview)
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: DscmProvisioningState;

  @added(Versions.v2024_06_24_preview)
  @doc("Request ID; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  requestId?: string;
}

@doc("dsmsAllowlist Resource")
model DsmsAllowlistResource
  is ProxyResource<DsmsAllowlistResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dsmsAllowlists") // Start with lower case. Should be plural
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DsmsAllowlist {
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "Fix on next update"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    DsmsAllowlistResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  listBySubscription is ArmListBySubscription<DsmsAllowlistResource>;
  listByResourceGroup is ArmResourceListByParent<DsmsAllowlistResource>;
  get is ArmResourceRead<DsmsAllowlistResource>;
}

@@visibility(DsmsAllowlistResource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
