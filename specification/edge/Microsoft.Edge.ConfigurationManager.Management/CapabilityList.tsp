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

@doc("Capability Properties")
model Capability {
  @doc("Name of capability")
  name: string;

  @doc("Description of capability")
  description: string;
}

@doc("Capability List Properties")
model CapabilityListProperties {
  @doc("List of capabilities")
  @extension("x-ms-identifiers", [])
  capabilities: Capability[];

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Capability List Resource")
model CapabilityList is TrackedResource<CapabilityListProperties> {
  ...ResourceNameParameter<CapabilityList>;
}

@armResourceOperations
interface CapabilityLists {
  @doc("Get a Capability List Resource")
  get is ArmResourceRead<CapabilityList>;

  @doc("Create or update a Capability List Resource")
  createOrUpdate is ArmResourceCreateOrReplaceSync<CapabilityList>;

  @doc("update a Capability List Resource")
  update is ArmResourcePatchSync<CapabilityList, CapabilityListProperties>;

  @doc("Delete a Capability List Resource")
  delete is ArmResourceDeleteSync<CapabilityList>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<CapabilityList>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<CapabilityList>;
}
