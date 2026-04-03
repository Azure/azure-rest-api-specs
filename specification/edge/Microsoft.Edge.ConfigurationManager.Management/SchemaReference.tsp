import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@removed(Versions.v2026_03_01)
@doc("Schema Reference Properties")
model SchemaReferenceProperties {
  @doc("Schema Id of schema reference")
  schemaId: string;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@removed(Versions.v2026_03_01)
@doc("Schema Reference Resource")
model SchemaReference is ExtensionResource<SchemaReferenceProperties> {
  ...ResourceNameParameter<SchemaReference, NamePattern = "^default$">;
  ...EntityTagProperty;
}

@removed(Versions.v2026_03_01)
@armResourceOperations
interface SchemaReferences {
  @doc("Get a Schema Reference Resource")
  get is ArmResourceRead<SchemaReference>;

  @doc("Create or update a Schema Reference Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SchemaReference>;

  @doc("update a Schema Reference Resource")
  update is ArmResourcePatchSync<SchemaReference, SchemaReferenceProperties>;

  @doc("Delete a Schema Reference Resource")
  delete is ArmResourceDeleteWithoutOkAsync<SchemaReference>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<SchemaReference>;
}
