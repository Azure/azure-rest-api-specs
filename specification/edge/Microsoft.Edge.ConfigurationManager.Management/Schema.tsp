import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Schema Properties")
model SchemaProperties {
  @doc("Current Version of schema")
  currentVersion: string;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("Schema Resource")
@resource("schema")
model Schema is TrackedResource<SchemaProperties> {
  ...ResourceNameParameter<Schema>;
}

@armResourceOperations
interface Schemas {
  @doc("Get a Schema Resource")
  get is ArmResourceRead<Schema>;

  @doc("Create or update a Schema Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Schema>;

  @doc("update a Schema Resource")
  update is ArmResourcePatchSync<Schema, SchemaProperties>;

  @doc("Delete a Schema Resource")
  delete is ArmResourceDeleteSync<Schema>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<Schema>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<Schema>;
}
