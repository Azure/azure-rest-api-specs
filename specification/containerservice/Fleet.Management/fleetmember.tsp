import "@typespec/rest";
import "./helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;

@doc("A member of the Fleet. It contains a reference to an existing Kubernetes cluster on Azure.")
@resource("members")
@parentResource(Fleet)
model FleetMember is ProxyResource<FleetMemberProperties> {
  @doc("The name of the Fleet member resource.")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(50)
  @key("fleetMemberName")
  @path
  @segment("members")
  @visibility("create", "read")
  name: string;

  ...EntityTagProperty;
}

scalar ClusterResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/managedClusters",
    }
  ]>;

@doc("A member of the Fleet. It contains a reference to an existing Kubernetes cluster on Azure.")
model FleetMemberProperties {
  // adding a response header in the model currently impacts the model used in the List result model.
  // omitting it for now as response headers do not impact SDK generation.
  // ...EtagResponseEnvelope;

  @visibility("create", "read")
  @doc("The ARM resource id of the cluster that joins the Fleet. Must be a valid Azure resource id. e.g.: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerService/managedClusters/{clusterName}'.")
  clusterResourceId: ClusterResourceId;

  @doc("The group this member belongs to for multi-cluster update management.")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(50)
  @added(Versions.v2023_03_15_preview)
  group?: string;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: FleetMemberProvisioningState;
}

@lroStatus
@doc("The provisioning state of the last accepted operation.")
union FleetMemberProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The provisioning state of a member joining a fleet.")
  Joining: "Joining",

  @doc("The provisioning state of a member leaving a fleet.")
  Leaving: "Leaving",

  @doc("The provisioning state of a member being updated.")
  Updating: "Updating",
}

@armResourceOperations
interface FleetMembers {
  get is ArmResourceRead<FleetMember>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "must change at next release"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrUpdateAsync<
    FleetMember,
    Azure.ResourceManager.Foundations.BaseParameters<FleetMember> &
      IfMatchParameters<FleetMember> &
      IfNoneMatchParameters<FleetMember>,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "Actual breaking change"
  @sharedRoute
  @added(Versions.v2023_03_15_preview)
  @removed(Versions.v2023_06_15_preview)
  update is ArmCustomPatchSync<
    FleetMember,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      FleetMember,
      FleetMemberProperties
    >,
    Azure.ResourceManager.Foundations.BaseParameters<FleetMember> &
      IfMatchParameters<FleetMember>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Use operationId to keep same name as deprecated sync operation"
  @sharedRoute
  @added(Versions.v2023_06_15_preview)
  @operationId("FleetMembers_Update")
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "original-uri",
    }
  )
  updateAsync is ArmCustomPatchAsync<
    FleetMember,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      FleetMember,
      FleetMemberProperties
    >,
    Azure.ResourceManager.Foundations.BaseParameters<FleetMember> &
      IfMatchParameters<FleetMember>
  >;

  #suppress "deprecated" "Existing API"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing API"
  @sharedRoute // why do we need to set shared route on delete? compiler complains with an error
  // All shared routes must agree on the value of the shared parameter.TypeSpec(@typespec/http/shared-inconsistency)
  delete is ArmResourceDeleteAsync<
    FleetMember,
    Azure.ResourceManager.Foundations.BaseParameters<FleetMember> &
      IfMatchParameters<FleetMember>
  >;

  /** List FleetMember resources by Fleet */
  listByFleet is ArmResourceListByParent<FleetMember>;
}
