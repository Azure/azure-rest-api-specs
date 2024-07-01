import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ToolchainOrchestrator;

@doc("The properties of the CatalogVersion.")
model CatalogVersionProperties {
  @doc("The provisioning state of the CatalogVersion.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
  @doc("The properties of the CatalogVersion.")
  properties: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The metadata of the CatalogVersion.")
  metadata?: Record<string>;

  @doc("The name of parent CatalogVersion")
  parentName?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
  @doc("The catalogType of the CatalogVersion.")
  catalogType: string;

  @doc("The status of the CatalogVersion.")
  @visibility("read")
  status?: CatalogStatusProperties;
}

@doc("The CatalogVersion entity.")
@resource("versions")
@parentResource(Catalog)
model CatalogVersion is TrackedResource<CatalogVersionProperties> {
  @doc("The name of Azure API Center service.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-z0-9]+(\\.[a-z0-9]+)*$")
  @path
  @key("versionName")
  @segment("versions")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the CatalogVersion.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface CatalogVersions {
  @doc("Returns the details of the CatalogVersion.")
  get is Azure.ResourceManager.ArmResourceRead<CatalogVersion>;
  @doc("Creates new or updates a CatalogVersion.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceSync<CatalogVersion>;
  @doc("Updates the existing CatalogVersion.")
  update is ArmCustomPatchSync<CatalogVersion>;
  @doc("Deletes the specified CatalogVersion.")
  delete is ArmResourceDeleteSync<CatalogVersion>;
  @doc("Lists CatalogVersions within a Catalog.")
  listByCatalog is ArmResourceListByParent<CatalogVersion>;
}
