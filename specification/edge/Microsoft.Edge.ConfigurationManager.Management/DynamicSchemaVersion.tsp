import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./DynamicSchemaVersion.tsp";
import "./SchemaVersion.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Dynamic Schema Version Resource")
@parentResource(DynamicSchema)
@resource("versions")
model DynamicSchemaVersion is SchemaVersion;

@armResourceOperations
interface DynamicSchemaVersions {
  @doc("Get a Dynamic Schema Version Resource")
  get is ArmResourceRead<DynamicSchemaVersion>;

  @doc("Create or update a Dynamic Schema Version Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DynamicSchemaVersion>;

  @doc("update a Dynamic Schema Version Resource")
  update is ArmResourcePatchSync<DynamicSchemaVersion, SchemaVersionProperties>;

  @doc("Delete a Dynamic Schema Version Resource")
  delete is ArmResourceDeleteWithoutOkAsync<DynamicSchemaVersion>;

  @doc("List by Dynamic Schema")
  listByDynamicSchema is ArmResourceListByParent<DynamicSchemaVersion>;
}
