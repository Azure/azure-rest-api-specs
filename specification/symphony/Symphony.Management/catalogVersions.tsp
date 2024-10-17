import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
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
  properties?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The metadata of the CatalogVersion.")
  metadata?: Record<string>;

  @doc("The name of parent CatalogVersion")
  parentName?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
  @doc("The catalogType of the CatalogVersion.")
  catalogType?: string;

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
  @pattern("^(?!v-)(?!.*-v-)[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
  @path
  @key("versionName")
  @segment("versions")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the CatalogVersion.")
  @visibility("read", "create")
  @madeOptional(Versions.v2024_08_01_preview)
  extendedLocation?: ExtendedLocation;
}

@doc("The expression evaluation result response.")
@added(Versions.v2024_08_01_preview)
model EvalExpressionResponse {
  @doc("Operation Id")
  @visibility("read")
  id?: string;

  @doc("Operation Name")
  @visibility("read")
  name?: string;

  @doc("Provisioning state of the expression evaluation resource")
  @visibility("read")
  status?: ResourceProvisioningState;

  @doc("Error listing the expression evaluation response.")
  error?: EvalExpressionResponseError;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
  @doc("Properties of the expression evaluation response.")
  properties?: Record<unknown>;
}

@doc("The error evaluating the expression response")
@added(Versions.v2024_08_01_preview)
model EvalExpressionResponseError {
  @doc("The error code.")
  code?: string;

  @doc("The error message.")
  message?: string;
}

@armResourceOperations
interface CatalogVersions {
  @doc("Returns the details of the CatalogVersion.")
  get is Azure.ResourceManager.ArmResourceRead<CatalogVersion>;
  @doc("Creates new or updates a CatalogVersion.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceAsync<CatalogVersion>;
  @doc("Updates the existing CatalogVersion.")
  update is ArmCustomPatchAsync<CatalogVersion>;
  @doc("Deletes the specified CatalogVersion.")
  delete is ArmResourceDeleteWithoutOkAsync<CatalogVersion>;
  @doc("Lists CatalogVersions within a Catalog.")
  listByCatalog is ArmResourceListByParent<CatalogVersion>;
  @doc("Evaluate the CatalogVersion's properties")
  @added(Versions.v2024_08_01_preview)
  evalExpression is ArmResourceActionAsync<
    CatalogVersion,
    void,
    EvalExpressionResponse
  >;
}
