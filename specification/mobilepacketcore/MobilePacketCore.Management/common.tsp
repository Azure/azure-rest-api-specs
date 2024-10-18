using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.MobilePacketCore;

/** Compliant create or update template */
/**
 * A long-running resource CreateOrUpdate (PUT)
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "This is a valid template"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - migrate to LRO apis"
@autoRoute
@doc("Create a {name}", TResource)
@OpenAPI.extension("x-ms-long-running-operation", true)
@OpenAPI.extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "azure-async-operation",
  }
)
@armResourceCreateOrUpdate(TResource)
@put
op ArmResourceCreateOrUpdate2Async<
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TBaseParameters = Azure.ResourceManager.Foundations.BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @bodyRoot
  resource: TResource,
): ArmUpdatedResponse<TResource> | ArmCreatedResponse<TResource> | ErrorResponse;

@doc("ARM resource update successful")
model ArmUpdatedResponse<TResource extends Azure.ResourceManager.Foundations.Resource>
  is ArmResponse<TResource>;

@doc("Provisioning state of the resource")
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Resource is getting provisioned")
  Provisioning: "Provisioning",

  @doc("Resource is updating")
  Updating: "Updating",

  @doc("Resource is getting deleted")
  Deleting: "Deleting",

  @doc("Resource has been accepted")
  Accepted: "Accepted",
}

@doc("ARM resource ID of a cluster.")
scalar ClusterServiceIdProperty
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.MobilePacketCore/clusterServices",
    }
  ]>;

@doc("ARM resource ID of a VNF Agent deployment.")
scalar VnfAgentDeploymentIdProperty
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.MobilePacketCore/vnfAgentDeployments",
    }
  ]>;

@doc("ARM resource ID of a custom location.")
scalar CustomLocationIdProperty
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ExtendedLocation/customLocations",
    }
  ]>;

@doc("Operational Status of the resource")
model OperationalStatus {
  @doc("Status of the deployed workload")
  @visibility("read")
  workload?: string;

  @doc("Health check results")
  @visibility("read")
  healthCheck?: string;
}

@doc("Infrastructure Type Definitions")
union InfrastructureType {
  string,

  @doc("Azure Core")
  "AzureCore",

  @doc("Azure Operator Nexus")
  "AzureOperatorNexus",
}

@doc("Deployment Type Definitions")
union SkuDeploymentType {
  string,

  @doc("Production Deployment")
  "Production",

  @doc("Lab Deployment")
  "Lab",
}

@doc("Cluster Type Definitions")
union ClusterType {
  string,

  @doc("Azure Kubernetes Service")
  Aks: "Aks",

  @doc("Azure Operator Nexus Kubernetes Service")
  NexusAks: "NexusAks",
}

@doc("Usage SKU Definition")
scalar UsageSku extends string;

@doc("Mobile Core Scaling Unit SKU Definition")
scalar MobileCoreScalingUnitSku extends string;

@doc("Azure for Operators 5G Core Release Version.")
scalar ReleaseVersion extends string;

@doc("Containerized Network Function (CNF) Component Deployment Parameters")
scalar ComponentDeploymentParameters extends string;

@doc("Containerized Network Function (CNF) Component Secrets")
scalar ComponentDeploymentSecrets extends string;

@doc("Containerized Network Function (CNF) Component Deployment Type")
scalar ComponentDeploymentType extends string;

@doc("Containerized Network Function (CNF) Qualified Deployment Parameters")
model QualifiedComponentDeploymentParameters {
  @doc("Federation Type")
  type: ComponentDeploymentType;

  @doc("Deployment Parameters")
  parameters?: ComponentDeploymentParameters;

  @doc("Deployment secrets")
  @secret
  secrets?: ComponentDeploymentSecrets;
}

@doc("ManagedResourceGroupConfiguration represents the configuration of the resource group managed by Azure.")
model ManagedResourceGroupConfiguration {
  @doc("The name for the managed resource group. If not specified, the unique name is automatically generated.")
  @visibility("create", "read")
  @maxLength(75)
  name?: string;

  @doc("The location of the managed resource group. If not specified, the location of the parent resource is chosen.")
  @visibility("create", "read")
  location?: string;
}
