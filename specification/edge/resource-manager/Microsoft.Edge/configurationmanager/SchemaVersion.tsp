import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./Schema.tsp";
import "./ProvisioningState.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Schema Version Properties")
model SchemaVersionProperties {
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Suppress no-unnamed-union since property represents a flexible configuration value"
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "Union of string | Record<unknown> is required to support both legacy string-encoded JSON and structured object payloads during client migration from prior API versions"
  @doc("Value of schema version")
  @typeChangedFrom(Versions.v2026_05_01_preview, string)
  value: string | Record<unknown>;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Schema Version Resource")
@parentResource(Schema)
@resource("versions")
model SchemaVersion is ProxyResource<SchemaVersionProperties> {
  ...ResourceNameParameter<
    SchemaVersion,
    NamePattern = "^[0-9]+\\.[0-9]+\\.[0-9]+$"
  >;
  ...EntityTagProperty;
}

@armResourceOperations
interface SchemaVersions {
  @doc("Get a Schema Version Resource")
  get is ArmResourceRead<SchemaVersion>;

  @doc("Create or update a Schema Version Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SchemaVersion>;

  @doc("update a Schema Version Resource")
  update is ArmResourcePatchSync<SchemaVersion, SchemaVersionProperties>;

  @doc("Delete a Schema Version Resource")
  delete is ArmResourceDeleteWithoutOkAsync<SchemaVersion>;

  @doc("List by specified resource group")
  listBySchema is ArmResourceListByParent<SchemaVersion>;
}
