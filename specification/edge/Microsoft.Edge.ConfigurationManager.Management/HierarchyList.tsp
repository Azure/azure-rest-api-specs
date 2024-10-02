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

@doc("Hierarchy Properties")
model Hierarchy {
  @doc("Name of hierarchy level")
  name: string;

  @doc("Description of hierarchy level")
  description: string;
}

@doc("Hierarchy List Properties")
model HierarchyListProperties {
  @doc("List of hierarchy levels")
  @extension("x-ms-identifiers", [])
  hierarchyLevels: Hierarchy[];

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Hierarchy List Resource")
model HierarchyList is TrackedResource<HierarchyListProperties> {
  ...ResourceNameParameter<HierarchyList>;
}

@armResourceOperations
interface HierarchyLists {
  @doc("Get a Hierarchy List Resource")
  get is ArmResourceRead<HierarchyList>;

  @doc("Create or update a Hierarchy List Resource")
  createOrUpdate is ArmResourceCreateOrReplaceSync<HierarchyList>;

  @doc("update a Hierarchy List Resource")
  update is ArmResourcePatchSync<HierarchyList, HierarchyListProperties>;

  @doc("Delete a Hierarchy List Resource")
  delete is ArmResourceDeleteSync<HierarchyList>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<HierarchyList>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<HierarchyList>;
}
