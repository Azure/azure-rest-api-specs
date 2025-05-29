import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./namespace.tsp";
import "../Discovery.Shared/shared.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Microsoft.Discovery.Shared;

@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

/** The resource provisioning state. */
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  string,
}

/** For tracking mobo resources */
model WithMoboBrokerResources {
  @doc("Managed-On-Behalf-Of broker resources")
  // TODO: Azure.ResourceManager.CommonTypes.MoboBrokerResource was in common types v5 but not v6. Find out why.
  @visibility(Lifecycle.Read)
  moboBrokerResources?: Azure.ResourceManager.CommonTypes.MoboBrokerResource[];
}

@doc("Managed-On-Behalf-Of configuration properties. This configuration exists for the resources where a resource provider manages those resources on behalf of the resource owner.")
model MoboConfigurationWithMrg {
  @doc("The resource group for resources managed on behalf of customer.")
  @visibility(Lifecycle.Read)
  managedResourceGroup?: string;

  /** Managed-On-Behalf-Of configuration properties. This configuration exists for the resources where a resource provider manages those resources on behalf of the resource owner. */
  @visibility(Lifecycle.Read)
  managedOnBehalfOfConfiguration?: WithMoboBrokerResources;
}

@doc("For resource version")
model WithVersion {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The version of a resource definition")
  version: string;
}

@doc("For tracking he status of the last operation.")
model WithProvisioningState {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("For resource definition content")
model WithDefinitionContent {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Need flexibly content to match various use-cases"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The JSON content for defining a resource")
  definitionContent: Record<unknown>;
}

@doc("For Workspace managed identity")
model DiscoveryResourceProperties {
  ...WithProvisioningState;
  ...WithVersion;
}

@doc("For user assigned identity resource property.")
model Identity {
  @doc("The resource ID of the user assigned identity.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  id: Microsoft.Discovery.Shared.UserAssignedIdentityId;

  ...Azure.ResourceManager.CommonTypes.UserAssignedIdentity;
}

@doc("Standard Discovery resource interface")
interface DiscoveryResource<
  T extends Azure.ResourceManager.Foundations.TrackedResource,
  P extends {},
  L extends {} = T
> {
  get is ArmResourceRead<T>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<T>;
  update is ArmResourcePatchAsync<T, P>;
  delete is ArmResourceDeleteWithoutOkAsync<T>;
  listByResourceGroup is ArmResourceListByParent<T>;
  listBySubscription is ArmListBySubscription<T>;
}
