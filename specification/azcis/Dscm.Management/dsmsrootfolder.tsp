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

@doc("dsmsRootFolder properties")
model DsmsRootFolderResourceProperties {
  @doc("The name of the root folder to add. This should be the full folder path starting with a \"$\", with \"$\" replacing all \"/\" characters")
  folderName: string;

  @doc("The cloud ID where the root folder should be added. Acceptable values: Public, Fairfax, Mooncake, USSec, USNat")
  cloudId?: string;

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

@doc("dsmsRootFolder Resource")
model DsmsRootFolderResource
  is ProxyResource<DsmsRootFolderResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dsmsRootFolders") // Start with lower case. Should be plural
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DsmsRootFolder {
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "Fix on next update"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    DsmsRootFolderResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  listBySubscription is ArmListBySubscription<DsmsRootFolderResource>;
  listByResourceGroup is ArmResourceListByParent<DsmsRootFolderResource>;
  get is ArmResourceRead<DsmsRootFolderResource>;
}

@@visibility(DsmsRootFolderResource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
