import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./namespace.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

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
