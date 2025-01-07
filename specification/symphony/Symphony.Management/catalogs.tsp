import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ToolchainOrchestrator;

@doc("The properties of the Catalog.")
model CatalogProperties {
  @doc("Provisioning state of the Catalog.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The Catalog entity.")
model Catalog is TrackedResource<CatalogProperties> {
  @doc("The name of Azure API Center service.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
  @path
  @key("catalogName")
  @segment("catalogs")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the Catalog.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Catalogs {
  @doc("Returns details of the Catalog.")
  get is Azure.ResourceManager.ArmResourceRead<Catalog>;
  @doc("Creates new or updates the Catalog.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceAsync<Catalog>;
  @doc("Updates the existing Catalog.")
  update is ArmCustomPatchAsync<Catalog>;
  @doc("Deletes specified Catalog.")
  delete is ArmResourceDeleteWithoutOkAsync<Catalog>;
  @doc("Returns a collection of Catalogs within the resource group.")
  listByResourceGroup is Azure.ResourceManager.ArmResourceListByParent<Catalog>;
  @doc("Lists Catalogs within an Azure subscription.")
  listBySubscription is ArmListBySubscription<Catalog>;
}
