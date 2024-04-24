import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Symphony;

@doc("The properties of the service.")
model CatalogVersionProperties {
  @doc("Provisioning state of the service.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  properties: Record<unknown>;

  metadata?: Record<string>;

  parentName?: string;

  type: string;
}

@doc("The service entity.")
@resource("versions")
@parentResource(Catalog)
model CatalogVersion is ProxyResource<CatalogVersionProperties> {
  @doc("The name of Azure API Center service.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]{3,90}$")
  @path
  @key("versionName")
  @segment("versions")
  name: string;
  
  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface CatalogVersions {
  @doc("Returns details of the service.")
  get is Azure.ResourceManager.ArmResourceRead<CatalogVersion>;
  @doc("Creates new or updates existing API.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceSync<CatalogVersion>;
  @doc("Updates existing service.")
  update is ArmResourcePatchSync<CatalogVersion, CatalogVersionProperties>;
  @doc("Deletes specified service.")
  delete is ArmResourceDeleteSync<CatalogVersion>;

  listByParent is ArmResourceListByParent<CatalogVersion>;
}