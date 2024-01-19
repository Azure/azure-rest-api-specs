import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
@doc("Custom entity store assignment")
model CustomEntityStoreAssignment
  is ProxyResource<CustomEntityStoreAssignmentProperties> {
  @doc("Name of the custom entity store assignment. Generated name is GUID.")
  @path
  @key("customEntityStoreAssignmentName")
  @segment("customEntityStoreAssignments")
  name: string;
}

@armResourceOperations
interface CustomEntityStoreAssignments {
  @doc("Gets a single custom entity store assignment by name for the provided subscription and resource group.")
  get is ArmResourceRead<CustomEntityStoreAssignment>;

  @doc("Creates a custom entity store assignment for the provided subscription, if not already exists.")
  create is ArmResourceCreateOrReplaceSync<CustomEntityStoreAssignment>;

  @doc("Delete a custom entity store assignment by name for a provided subscription")
  delete is ArmResourceDeleteSync<CustomEntityStoreAssignment>;

  @doc("List custom entity store assignments by a provided subscription and resource group")
  listByResourceGroup is ArmResourceListByParent<CustomEntityStoreAssignment>;

  @doc("List custom entity store assignments by provided subscription")
  listBySubscription is ArmListBySubscription<CustomEntityStoreAssignment>;
}

@@projectedName(CustomEntityStoreAssignments.create::parameters.resource,
  "json",
  "customEntityStoreAssignmentRequestBody"
);
@@extension(CustomEntityStoreAssignments.create::parameters.resource,
  "x-ms-client-name",
  "customEntityStoreAssignmentRequestBody"
);
@@doc(CustomEntityStoreAssignments.create::parameters.resource,
  "Custom entity store assignment body"
);
