import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ConfigurationModel.tsp";
import "./ConfigurationType.tsp";
import "./ProvisioningState.tsp";
import "./SchemaVersion.tsp";
import "./VersionParameter.tsp";
import "./RemoveVersionResponse.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

#suppress "@azure-tools/typespec-azure-resource-manager/empty-updateable-properties" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@doc("Schema Properties")
model SchemaProperties {
  @doc("Current Version of schema")
  @visibility(Lifecycle.Read)
  currentVersion?: string;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Schema Version With Update Type")
model SchemaVersionWithUpdateType {
  @doc("Update type")
  updateType?: UpdateType;

  @doc("Version to create")
  @pattern("^(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)$")
  version?: string;

  @doc("Schema Version")
  schemaVersion: SchemaVersion;
}

@doc("Schema Resource")
@resource("schemas")
model Schema is TrackedResource<SchemaProperties> {
  @doc("The name of the Schema")
  @pattern("^(?!.*\\.\\.)[a-zA-Z0-9-][a-zA-Z0-9._-]{1,68}[a-zA-Z0-9-]$")
  @path
  @key("schemaName")
  @segment("schemas")
  name: string;

  ...EntityTagProperty;
}

/** The type used for update operations of the Schema. */
model SchemaUpdate {
  @doc("The resource-specific properties for this resource.")
  properties?: SchemaUpdateProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@doc("The updatable properties of the Schema.")
model SchemaUpdateProperties {}

@armResourceOperations
interface Schemas {
  @doc("Get a Schema Resource")
  get is ArmResourceRead<Schema>;

  @doc("Create or update a Schema Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Schema>;

  @doc("update a Schema Resource")
  update is ArmCustomPatchSync<Schema, PatchModel = SchemaUpdate>;

  @doc("Delete a Schema Resource")
  delete is ArmResourceDeleteWithoutOkAsync<Schema>;

  @doc("Create a Schema Version Resource")
  createVersion is ArmResourceActionAsync<
    Schema,
    SchemaVersionWithUpdateType,
    SchemaVersion
  >;

  @doc("Remove Schema Version Resource")
  removeVersion is ArmResourceActionSync<
    Schema,
    VersionParameter,
    RemoveVersionResponse
  >;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<Schema>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<Schema>;
}
