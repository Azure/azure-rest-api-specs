import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./Context.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.Edge;

@doc("Site Reference Properties")
model SiteReferenceProperties {
  @doc("Azure Resource ID for Site")
  siteId: string;

  @doc("Provisioning State")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Site Reference Resource")
@parentResource(Context)
@resource("siteReferences")
model SiteReference
  is Azure.ResourceManager.ProxyResource<SiteReferenceProperties> {
  ...ResourceNameParameter<SiteReference>;
}

@armResourceOperations
interface SiteReferences {
  @doc("Get Site Reference Resource")
  get is ArmResourceRead<SiteReference>;

  @doc("Get Site Reference Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SiteReference>;

  @doc("Get Site Reference Resource")
  update is ArmResourcePatchAsync<SiteReference, SiteReferenceProperties>;

  @doc("Get Site Reference Resource")
  delete is ArmResourceDeleteWithoutOkAsync<SiteReference>;

  @doc("List Site Reference Resources")
  listByContext is ArmResourceListByParent<SiteReference>;
}
