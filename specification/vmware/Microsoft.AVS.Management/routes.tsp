import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ClientGenerator.Core;
using OpenAPI;

namespace Microsoft.AVS;

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Locations {
  @doc("Return trial status for subscription by region")
  @armResourceAction(Location)
  checkTrialAvailability(
    ...ResourceInstanceParameters<Location>,

    @doc("Optionally, check for a specific SKU")
    @bodyRoot
    sku?: Sku,
  ): ArmResponse<Trial> | ErrorResponse;

  @doc("Return quota for subscription by region")
  @armResourceAction(Location)
  @post
  checkQuotaAvailability(
    ...ResourceInstanceParameters<Location>,
  ): ArmResponse<Quota> | ErrorResponse;
}

alias PrivateCloudList = ResourceList<PrivateCloud>;
@armResourceOperations
interface PrivateClouds {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("PrivateClouds_List")
  list is ArmResourceListByParent<
    PrivateCloud,
    Response = ArmResponse<PrivateCloudList>
  >;

  listInSubscription is ArmListBySubscription<
    PrivateCloud,
    Response = ArmResponse<PrivateCloudList>
  >;

  get is ArmResourceRead<PrivateCloud>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    PrivateCloud,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  // This could be modeled with ArmCustomPatchAsync if a 202 response with no body is used instead of a 201.
  // update is ArmCustomPatchAsync<PrivateCloud, PrivateCloudUpdate>;
  @doc("Update a PrivateCloud")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  @armResourceUpdate(PrivateCloud)
  @patch
  update(
    ...ResourceInstanceParameters<PrivateCloud>,

    @bodyRoot
    @doc("The private cloud properties to be updated.")
    privateCloudUpdate: PrivateCloudUpdate,
  ): ArmResponse<PrivateCloud> | {
    // @doc("Resource update request created.")
    ...CreatedResponse;

    ...Azure.Core.Foundations.RetryAfterHeader;
    ...ArmLroLocationHeader;

    @bodyRoot
    @doc("The updated private cloud.")
    placementPolicy: PrivateCloud;
  } | ErrorResponse;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<PrivateCloud>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Existing API"
  @doc("Rotate the vCenter password")
  rotateVcenterPassword is ArmResourceActionNoContentAsyncNoRequestBody<PrivateCloud>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Existing API"
  @doc("Rotate the NSX-T Manager password")
  rotateNsxtPassword is ArmResourceActionNoContentAsyncNoRequestBody<PrivateCloud>;

  @doc("List the admin credentials for the private cloud")
  listAdminCredentials is ArmResourceActionSyncNoRequestBody<
    PrivateCloud,
    AdminCredentials
  >;
}

@@encodedName(PrivateClouds.createOrUpdate::parameters.resource,
  "application/json",
  "privateCloud"
);
@@OpenAPI.extension(PrivateClouds.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "privateCloud"
);
@@clientName(PrivateClouds.createOrUpdate::parameters.resource, "privateCloud");

@armResourceOperations
interface Clusters {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("Clusters_List")
  list is ArmResourceListByParent<
    Cluster,
    Response = ArmResponse<ResourceList<Cluster>>
  >;

  get is ArmResourceRead<Cluster>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Cluster,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  // This could be modeled with ArmCustomPatchAsync if a 202 response with no body is used instead of a 201.
  // update is ArmCustomPatchAsync<Cluster, ClusterUpdate>;
  @doc("Update a Cluster")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  @armResourceUpdate(Cluster)
  @patch
  update(
    ...ResourceInstanceParameters<Cluster>,

    @bodyRoot
    @doc("The cluster properties to be updated.")
    clusterUpdate: ClusterUpdate,
  ): ArmResponse<Cluster> | {
    // @doc("Resource update request created.")
    ...CreatedResponse;

    ...Azure.Core.Foundations.RetryAfterHeader;
    ...ArmLroLocationHeader;

    @bodyRoot
    @doc("The updated cluster.")
    cluster: Cluster;
  } | ErrorResponse;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<Cluster>;

  @doc("List hosts by zone in a cluster")
  listZones is ArmResourceActionSyncNoRequestBody<Cluster, ClusterZoneList>;
}

@@encodedName(Clusters.createOrUpdate::parameters.resource,
  "application/json",
  "cluster"
);
@@OpenAPI.extension(Clusters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "cluster"
);
@@clientName(Clusters.createOrUpdate::parameters.resource, "cluster");

@armResourceOperations
interface Datastores {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("Datastores_List")
  list is ArmResourceListByParent<
    Datastore,
    Response = ArmResponse<ResourceList<Datastore>>
  >;

  get is ArmResourceRead<Datastore>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Datastore,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<Datastore>;
}

@@encodedName(Datastores.createOrUpdate::parameters.resource,
  "application/json",
  "datastore"
);
@@clientName(Datastores.createOrUpdate::parameters.resource, "datastore");
@@OpenAPI.extension(Datastores.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "datastore"
);

@armResourceOperations
interface HcxEnterpriseSites {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("HcxEnterpriseSites_List")
  list is ArmResourceListByParent<
    HcxEnterpriseSite,
    Response = ArmResponse<ResourceList<HcxEnterpriseSite>>
  >;

  get is ArmResourceRead<HcxEnterpriseSite>;

  createOrUpdate is ArmResourceCreateOrReplaceSync<HcxEnterpriseSite>;

  delete is ArmResourceDeleteSync<HcxEnterpriseSite>;
}

@@encodedName(HcxEnterpriseSites.createOrUpdate::parameters.resource,
  "application/json",
  "hcxEnterpriseSite"
);
@@clientName(HcxEnterpriseSites.createOrUpdate::parameters.resource,
  "hcxEnterpriseSite"
);
@@OpenAPI.extension(HcxEnterpriseSites.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "hcxEnterpriseSite"
);

@armResourceOperations
interface Authorizations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("Authorizations_List")
  list is ArmResourceListByParent<
    ExpressRouteAuthorization,
    Response = ArmResponse<ResourceList<ExpressRouteAuthorization>>
  >;

  get is ArmResourceRead<ExpressRouteAuthorization>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST REMOVE AT NEXT API VERSION UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ExpressRouteAuthorization,
    BaseParameters<PrivateCloud>,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<ExpressRouteAuthorization>;
}

@@encodedName(Authorizations.createOrUpdate::parameters.resource,
  "application/json",
  "authorization"
);
@@clientName(Authorizations.createOrUpdate::parameters.resource,
  "authorization"
);
@@OpenAPI.extension(Authorizations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "authorization"
);

@armResourceOperations
interface GlobalReachConnections {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("GlobalReachConnections_List")
  list is ArmResourceListByParent<
    GlobalReachConnection,
    Response = ArmResponse<ResourceList<GlobalReachConnection>>
  >;

  get is ArmResourceRead<GlobalReachConnection>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    GlobalReachConnection,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<GlobalReachConnection>;
}

@@encodedName(GlobalReachConnections.createOrUpdate::parameters.resource,
  "application/json",
  "globalReachConnection"
);
@@clientName(GlobalReachConnections.createOrUpdate::parameters.resource,
  "globalReachConnection"
);
@@OpenAPI.extension(GlobalReachConnections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "globalReachConnection"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation"
interface WorkloadNetworks {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_Get")
  @tag("WorkloadNetworks")
  @autoRoute
  get is ArmResourceRead<WorkloadNetwork>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_List")
  @tag("WorkloadNetworks")
  @autoRoute
  list is ArmResourceListByParent<
    WorkloadNetwork,
    Response = ArmResponse<ResourceList<WorkloadNetwork>>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListSegments")
  @tag("WorkloadNetworkSegments")
  @autoRoute
  listSegments is ArmResourceListByParent<
    WorkloadNetworkSegment,
    Response = ArmResponse<ResourceList<WorkloadNetworkSegment, "{name}sList">>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetSegment")
  @tag("WorkloadNetworkSegments")
  @autoRoute
  getSegment is ArmResourceRead<WorkloadNetworkSegment>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @operationId("WorkloadNetworks_CreateSegments")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @tag("WorkloadNetworkSegments")
  @autoRoute
  createSegment is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkSegment,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_UpdateSegments")
  @parameterVisibility
  @tag("WorkloadNetworkSegments")
  @autoRoute
  updateSegment is ArmCustomPatchAsync<
    WorkloadNetworkSegment,
    WorkloadNetworkSegment
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_DeleteSegment")
  @tag("WorkloadNetworkSegments")
  @autoRoute
  deleteSegment is ArmResourceDeleteAsync<WorkloadNetworkSegment>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListDhcp")
  @autoRoute
  listDhcp is ArmResourceListByParent<
    WorkloadNetworkDhcp,
    Response = ArmResponse<ResourceList<WorkloadNetworkDhcp>>
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "DhcpIdParameter should be last, but it is breaking to correct it."
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetDhcp")
  // get is ArmResourceRead<WorkloadNetworkDhcp>;
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dhcpConfigurations/{dhcpId}")
  @doc("Get a {name}", WorkloadNetworkDhcp)
  @get
  getDhcp(
    ...BaseParameters<WorkloadNetworkDhcp>,
    ...DhcpIdParameter,
    ...PrivateCloudNameParameter,
  ): ArmResponse<WorkloadNetworkDhcp> | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @operationId("WorkloadNetworks_CreateDhcp")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @autoRoute
  createDhcp is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkDhcp,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_UpdateDhcp")
  @parameterVisibility
  @autoRoute
  updateDhcp is ArmCustomPatchAsync<WorkloadNetworkDhcp, WorkloadNetworkDhcp>;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_DeleteDhcp")
  @autoRoute
  deleteDhcp is ArmResourceDeleteAsync<WorkloadNetworkDhcp>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListGateways")
  @tag("WorkloadNetworkGateways")
  @autoRoute
  listGateways is ArmResourceListByParent<
    WorkloadNetworkGateway,
    Response = ArmResponse<ResourceList<WorkloadNetworkGateway>>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetGateway")
  @tag("WorkloadNetworkGateways")
  @autoRoute
  getGateway is ArmResourceRead<WorkloadNetworkGateway>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListPortMirroring")
  @autoRoute
  listPortMirroring is ArmResourceListByParent<
    WorkloadNetworkPortMirroring,
    Response = ArmResponse<ResourceList<WorkloadNetworkPortMirroring>>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetPortMirroring")
  @autoRoute
  getPortMirroring is ArmResourceRead<WorkloadNetworkPortMirroring>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @operationId("WorkloadNetworks_CreatePortMirroring")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @autoRoute
  createPortMirroring is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkPortMirroring,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_UpdatePortMirroring")
  @parameterVisibility
  @autoRoute
  updatePortMirroring is ArmCustomPatchAsync<
    WorkloadNetworkPortMirroring,
    WorkloadNetworkPortMirroring
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "PortMirroringProfileParameter should be last, but it is breaking to correct it."
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_DeletePortMirroring")
  // delete is ArmResourceDeleteAsync<WorkloadNetworkPortMirroring>;
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/portMirroringProfiles/{portMirroringId}")
  @doc("Delete a {name}", WorkloadNetworkPortMirroring)
  @delete
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  deletePortMirroring(
    ...BaseParameters<WorkloadNetworkPortMirroring>,
    ...PortMirroringProfileParameter,
    ...PrivateCloudNameParameter,
  ):
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
    | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListVMGroups")
  @autoRoute
  listVMGroups is ArmResourceListByParent<
    WorkloadNetworkVMGroup,
    Response = ArmResponse<ResourceList<WorkloadNetworkVMGroup, "{name}sList">>
  >;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetVMGroup")
  @autoRoute
  getVMGroup is ArmResourceRead<WorkloadNetworkVMGroup>;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @operationId("WorkloadNetworks_CreateVMGroup")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @autoRoute
  createVMGroup is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkVMGroup,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_UpdateVMGroup")
  @parameterVisibility
  @autoRoute
  updateVMGroup is ArmCustomPatchAsync<
    WorkloadNetworkVMGroup,
    WorkloadNetworkVMGroup
  >;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "VmGroupIdParameter should be last, but it is breaking to correct it."
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_DeleteVMGroup")
  // delete is ArmResourceDeleteAsync<WorkloadNetworkVMGroup>;
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/vmGroups/{vmGroupId}")
  @doc("Delete a {name}", WorkloadNetworkVMGroup)
  @delete
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  deleteVMGroup(
    ...BaseParameters<WorkloadNetworkVMGroup>,
    ...VmGroupIdParameter,
    ...PrivateCloudNameParameter,
  ):
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
    | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListVirtualMachines")
  @tag("WorkloadNetworkVirtualMachines")
  @autoRoute
  listVirtualMachines is ArmResourceListByParent<
    WorkloadNetworkVirtualMachine,
    Response = ArmResponse<ResourceList<
      WorkloadNetworkVirtualMachine,
      "{name}sList"
    >>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetVirtualMachine")
  @tag("WorkloadNetworkVirtualMachines")
  @autoRoute
  getVirtualMachine is ArmResourceRead<WorkloadNetworkVirtualMachine>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListDnsServices")
  @autoRoute
  listDnsServices is ArmResourceListByParent<
    WorkloadNetworkDnsService,
    Response = ArmResponse<ResourceList<
      WorkloadNetworkDnsService,
      "{name}sList"
    >>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetDnsService")
  @autoRoute
  getDnsService is ArmResourceRead<WorkloadNetworkDnsService>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @operationId("WorkloadNetworks_CreateDnsService")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @autoRoute
  createDnsService is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkDnsService,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_UpdateDnsService")
  @parameterVisibility
  @autoRoute
  updateDnsService is ArmCustomPatchAsync<
    WorkloadNetworkDnsService,
    WorkloadNetworkDnsService
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "DnsServiceIdParameter should be last, but it is breaking to correct it."
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_DeleteDnsService")
  // delete is ArmResourceDeleteAsync<WorkloadNetworkDnsService>;
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dnsServices/{dnsServiceId}")
  @doc("Delete a {name}", WorkloadNetworkDnsService)
  @delete
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  deleteDnsService(
    ...BaseParameters<WorkloadNetworkDnsService>,
    ...DnsServiceIdParameter,
    ...PrivateCloudNameParameter,
  ):
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
    | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListDnsZones")
  @autoRoute
  listDnsZones is ArmResourceListByParent<
    WorkloadNetworkDnsZone,
    Response = ArmResponse<ResourceList<WorkloadNetworkDnsZone, "{name}sList">>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetDnsZone")
  @autoRoute
  getDnsZone is ArmResourceRead<WorkloadNetworkDnsZone>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @operationId("WorkloadNetworks_CreateDnsZone")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @autoRoute
  createDnsZone is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkDnsZone,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_UpdateDnsZone")
  @parameterVisibility
  @autoRoute
  updateDnsZone is ArmCustomPatchAsync<
    WorkloadNetworkDnsZone,
    WorkloadNetworkDnsZone
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "DnsZoneIdParameter should be last, but it is breaking to correct it."
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_DeleteDnsZone")
  // delete is ArmResourceDeleteAsync<WorkloadNetworkDnsZone>;
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dnsZones/{dnsZoneId}")
  @doc("Delete a {name}", WorkloadNetworkDnsZone)
  @delete
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  deleteDnsZone(
    ...BaseParameters<WorkloadNetworkDnsZone>,
    ...DnsZoneIdParameter,
    ...PrivateCloudNameParameter,
  ):
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
    | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListPublicIPs")
  @autoRoute
  listPublicIPs is ArmResourceListByParent<
    WorkloadNetworkPublicIP,
    Response = ArmResponse<ResourceList<WorkloadNetworkPublicIP, "{name}sList">>
  >;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetPublicIP")
  @autoRoute
  getPublicIP is ArmResourceRead<WorkloadNetworkPublicIP>;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @operationId("WorkloadNetworks_CreatePublicIP")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @autoRoute
  createPublicIP is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkPublicIP,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "PublicIPIdParameter should be last, but it is breaking to correct it."
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_DeletePublicIP")
  // delete is ArmResourceDeleteAsync<WorkloadNetworkPublicIP>;
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/publicIPs/{publicIPId}")
  @doc("Delete a {name}", WorkloadNetworkPublicIP)
  @delete
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  deletePublicIP(
    ...BaseParameters<WorkloadNetworkPublicIP>,
    ...PublicIPIdParameter,
    ...PrivateCloudNameParameter,
  ):
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
    | ErrorResponse;
}

@@encodedName(WorkloadNetworks.createSegment::parameters.resource,
  "application/json",
  "workloadNetworkSegment"
);
@@clientName(WorkloadNetworks.createSegment::parameters.resource,
  "workloadNetworkSegment"
);
@@OpenAPI.extension(WorkloadNetworks.createSegment::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkSegment"
);

@@encodedName(WorkloadNetworks.updateSegment::parameters.properties,
  "application/json",
  "workloadNetworkSegment"
);
@@clientName(WorkloadNetworks.updateSegment::parameters.properties,
  "application/json",
  "workloadNetworkSegment"
);
@@OpenAPI.extension(WorkloadNetworks.updateSegment::parameters.properties,
  "x-ms-client-name",
  "workloadNetworkSegment"
);

@@encodedName(WorkloadNetworks.createDhcp::parameters.resource,
  "application/json",
  "workloadNetworkDhcp"
);
@@clientName(WorkloadNetworks.createDhcp::parameters.resource,
  "workloadNetworkDhcp"
);
@@OpenAPI.extension(WorkloadNetworks.createDhcp::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkDhcp"
);

@@encodedName(WorkloadNetworks.updateDhcp::parameters.properties,
  "application/json",
  "workloadNetworkDhcp"
);
@@clientName(WorkloadNetworks.updateDhcp::parameters.properties,
  "workloadNetworkDhcp"
);
@@OpenAPI.extension(WorkloadNetworks.updateDhcp::parameters.properties,
  "x-ms-client-name",
  "workloadNetworkDhcp"
);

@@encodedName(WorkloadNetworks.createPortMirroring::parameters.resource,
  "application/json",
  "workloadNetworkPortMirroring"
);
@@clientName(WorkloadNetworks.createPortMirroring::parameters.resource,
  "workloadNetworkPortMirroring"
);
@@OpenAPI.extension(WorkloadNetworks.createPortMirroring::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkPortMirroring"
);

@@encodedName(WorkloadNetworks.updatePortMirroring::parameters.properties,
  "application/json",
  "workloadNetworkPortMirroring"
);
@@clientName(WorkloadNetworks.updatePortMirroring::parameters.properties,
  "workloadNetworkPortMirroring"
);
@@OpenAPI.extension(WorkloadNetworks.updatePortMirroring::parameters.properties,
  "x-ms-client-name",
  "workloadNetworkPortMirroring"
);

@@encodedName(WorkloadNetworks.createVMGroup::parameters.resource,
  "application/json",
  "workloadNetworkVMGroup"
);
@@clientName(WorkloadNetworks.createVMGroup::parameters.resource,
  "application/json",
  "workloadNetworkVMGroup"
);
@@OpenAPI.extension(WorkloadNetworks.createVMGroup::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkVMGroup"
);

@@encodedName(WorkloadNetworks.updateVMGroup::parameters.properties,
  "application/json",
  "workloadNetworkVMGroup"
);
@@clientName(WorkloadNetworks.updateVMGroup::parameters.properties,
  "workloadNetworkVMGroup"
);
@@OpenAPI.extension(WorkloadNetworks.updateVMGroup::parameters.properties,
  "x-ms-client-name",
  "workloadNetworkVMGroup"
);

@@encodedName(WorkloadNetworks.createDnsService::parameters.resource,
  "application/json",
  "workloadNetworkDnsService"
);
@@clientName(WorkloadNetworks.createDnsService::parameters.resource,
  "workloadNetworkDnsService"
);
@@OpenAPI.extension(WorkloadNetworks.createDnsService::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkDnsService"
);

@@encodedName(WorkloadNetworks.updateDnsService::parameters.properties,
  "application/json",
  "workloadNetworkDnsService"
);
@@clientName(WorkloadNetworks.updateDnsService::parameters.properties,
  "workloadNetworkDnsService"
);
@@OpenAPI.extension(WorkloadNetworks.updateDnsService::parameters.properties,
  "x-ms-client-name",
  "workloadNetworkDnsService"
);

@@encodedName(WorkloadNetworks.createDnsZone::parameters.resource,
  "application/json",
  "workloadNetworkDnsZone"
);
@@clientName(WorkloadNetworks.createDnsZone::parameters.resource,
  "workloadNetworkDnsZone"
);
@@OpenAPI.extension(WorkloadNetworks.createDnsZone::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkDnsZone"
);

@@encodedName(WorkloadNetworks.updateDnsZone::parameters.properties,
  "application/json",
  "workloadNetworkDnsZone"
);
@@clientName(WorkloadNetworks.updateDnsZone::parameters.properties,
  "workloadNetworkDnsZone"
);
@@OpenAPI.extension(WorkloadNetworks.updateDnsZone::parameters.properties,
  "x-ms-client-name",
  "workloadNetworkDnsZone"
);

@@encodedName(WorkloadNetworks.createPublicIP::parameters.resource,
  "application/json",
  "workloadNetworkPublicIP"
);
@@clientName(WorkloadNetworks.createPublicIP::parameters.resource,
  "workloadNetworkPublicIP"
);
@@OpenAPI.extension(WorkloadNetworks.createPublicIP::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkPublicIP"
);

@armResourceOperations
interface CloudLinks {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("CloudLinks_List")
  list is ArmResourceListByParent<
    CloudLink,
    Response = ArmResponse<ResourceList<CloudLink>>
  >;

  get is ArmResourceRead<CloudLink>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    CloudLink,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<CloudLink>;
}

@@encodedName(CloudLinks.createOrUpdate::parameters.resource,
  "application/json",
  "cloudLink"
);
@@clientName(CloudLinks.createOrUpdate::parameters.resource, "cloudLink");
@@OpenAPI.extension(CloudLinks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "cloudLink"
);

@armResourceOperations
interface Addons {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("Addons_List")
  list is ArmResourceListByParent<
    Addon,
    Response = ArmResponse<ResourceList<Addon>>
  >;

  get is ArmResourceRead<Addon>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Addon,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<Addon>;
}

@@encodedName(Addons.createOrUpdate::parameters.resource,
  "application/json",
  "addon"
);
@@clientName(Addons.createOrUpdate::parameters.resource, "addon");
@@OpenAPI.extension(Addons.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "addon"
);

@armResourceOperations
interface VirtualMachines {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("VirtualMachines_List")
  list is ArmResourceListByParent<
    VirtualMachine,
    Response = ArmResponse<ResourceList<VirtualMachine, "{name}sList">>
  >;

  get is ArmResourceRead<VirtualMachine>;

  // restrictMovement should be a ArmResourceActionNoContentAsync, but does not respond with a 204.
  @doc("Enable or disable DRS-driven VM movement restriction")
  @armResourceAction(Location)
  @post
  @extension("x-ms-long-running-operation", true)
  restrictMovement(
    ...ResourceInstanceParameters<VirtualMachine>,

    @bodyRoot
    @doc("The body type of the operation request.")
    restrictMovement: VirtualMachineRestrictMovement,
  ): ArmAcceptedLroResponse | ErrorResponse;
}

@armResourceOperations
interface PlacementPolicies {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("PlacementPolicies_List")
  list is ArmResourceListByParent<
    PlacementPolicy,
    Response = ArmResponse<ResourceList<
      PlacementPolicy,
      "PlacementPoliciesList"
    >>
  >;

  get is ArmResourceRead<PlacementPolicy>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    PlacementPolicy,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  // 202 response has a body, but it should not to match ArmCustomPatchAsync.
  // update is ArmCustomPatchAsync<PlacementPolicy, PlacementPolicyUpdate>;
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body"
  @doc("Update a PlacementPolicy")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  @armResourceUpdate(PlacementPolicy)
  @patch
  update(
    ...ResourceInstanceParameters<PlacementPolicy>,

    @bodyRoot
    @doc("The placement policy properties to be updated.")
    placementPolicyUpdate: PlacementPolicyUpdate,
  ): ArmResponse<PlacementPolicy> | {
    ...AcceptedResponse;
    ...Azure.Core.Foundations.RetryAfterHeader;
    ...ArmLroLocationHeader;

    @bodyRoot
    @doc("The updatd placement policy.")
    placementPolicy: PlacementPolicy;
  } | ErrorResponse;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<PlacementPolicy>;
}

@@encodedName(PlacementPolicies.createOrUpdate::parameters.resource,
  "application/json",
  "placementPolicy"
);
@@clientName(PlacementPolicies.createOrUpdate::parameters.resource,
  "placementPolicy"
);
@@OpenAPI.extension(PlacementPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "placementPolicy"
);

@armResourceOperations
interface ScriptPackages {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("ScriptPackages_List")
  list is ArmResourceListByParent<
    ScriptPackage,
    Response = ArmResponse<ResourceList<ScriptPackage, "{name}sList">>
  >;

  get is ArmResourceRead<ScriptPackage>;
}

@armResourceOperations
interface ScriptCmdlets {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("ScriptCmdlets_List")
  list is ArmResourceListByParent<
    ScriptCmdlet,
    Response = ArmResponse<ResourceList<ScriptCmdlet, "{name}sList">>
  >;

  get is ArmResourceRead<ScriptCmdlet>;
}

@armResourceOperations
interface ScriptExecutions {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("ScriptExecutions_List")
  list is ArmResourceListByParent<
    ScriptExecution,
    Response = ArmResponse<ResourceList<ScriptExecution, "{name}sList">>
  >;

  get is ArmResourceRead<ScriptExecution>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ScriptExecution,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<ScriptExecution>;

  @doc("Return the logs for a script execution resource")
  @autoRoute
  @armResourceAction(ScriptExecution)
  @post
  getExecutionLogs(
    ...ResourceInstanceParameters<ScriptExecution>,

    #suppress "@azure-tools/typespec-azure-core/request-body-problem"
    @bodyRoot
    @doc("Name of the desired output stream to return. If not provided, will return all. An empty array will return nothing.")
    scriptOutputStreamType?: ScriptOutputStreamType[],
  ): ArmResponse<ScriptExecution> | ErrorResponse;
}

@@encodedName(ScriptExecutions.createOrUpdate::parameters.resource,
  "application/json",
  "scriptExecution"
);
@@clientName(ScriptExecutions.createOrUpdate::parameters.resource,
  "scriptExecution"
);
@@OpenAPI.extension(ScriptExecutions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "scriptExecution"
);

@armResourceOperations
interface IscsiPaths {
  listByPrivateCloud is ArmResourceListByParent<IscsiPath>;

  get is ArmResourceRead<IscsiPath>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    IscsiPath,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<IscsiPath>;
}

// use { @bodyRoot _: void } with the next version of typespec-azure
// https://github.com/Azure/typespec-azure/issues/3759

// Just like ArmResourceActionSync, but with no request body.
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@autoRoute
@armResourceAction(TResource)
@post
op ArmResourceActionSyncNoRequestBody<
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TResponse extends TypeSpec.Reflection.Model,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,
): ArmResponse<TResponse> | ErrorResponse;

// Just like ArmResourceActionAsync, but with no request body.
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
op ArmResourceActionNoContentAsyncNoRequestBody<
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TBaseParameters extends TypeSpec.Reflection.Model = BaseParameters<TResource>
> is ArmResourceActionAsyncBaseNoRequestBody<
  TResource,
  ArmAcceptedLroResponse | ArmNoContentResponse<"Action completed successfully.">,
  TBaseParameters
>;

// Just like ArmResourceActionAsyncBase, but with no request body.
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@autoRoute
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "location",
  }
)
@armResourceAction(TResource)
@post
op ArmResourceActionAsyncBaseNoRequestBody<
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TResponse,
  TBaseParameters extends TypeSpec.Reflection.Model
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,
): TResponse | ErrorResponse;
