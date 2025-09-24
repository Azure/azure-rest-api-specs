import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./State.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.Edge;

@doc("Capability, to match in Solution Templates and Targets")
model Capability {
  @doc("Name of Capability")
  name: string;

  @doc("Description of Capability")
  description: string;

  @doc("State of resource")
  state?: ResourceState;
}

@doc("Hierarchy, to tag Sites / Hierarchy Provider nodes with what they represent")
model Hierarchy {
  @doc("Name of Hierarchy")
  name: string;

  @doc("Description of Hierarchy")
  description: string;
}

@doc("Context Properties")
model ContextProperties {
  @doc("List of Capabilities")
  @Azure.ResourceManager.identifiers(#[])
  capabilities: Capability[];

  @doc("List of Hierarchies")
  @Azure.ResourceManager.identifiers(#[])
  hierarchies: Hierarchy[];

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Context Resource")
model Context is Azure.ResourceManager.TrackedResource<ContextProperties> {
  @doc("The name of the Context.")
  @maxLength(61)
  @minLength(3)
  @pattern("^[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  @path
  @key("contextName")
  @segment("contexts")
  name: string;
}

@armResourceOperations
interface Contexts {
  @doc("Get Context Resource")
  get is ArmResourceRead<Context>;

  @doc("Create or update Context Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Context>;

  @doc("update an Context Resource")
  update is ArmCustomPatchAsync<
    Context,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Context,
      ContextProperties
    >
  >;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<Context>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<Context>;

  @doc("Delete Context Resource")
  delete is ArmResourceDeleteWithoutOkAsync<Context>;
}
