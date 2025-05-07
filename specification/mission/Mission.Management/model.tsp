import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

import "./resourcetypes/community/community.tsp";
import "./resourcetypes/virtualEnclave/virtualenclave.tsp";
import "./resourcetypes/workload/workload.tsp";
import "./resourcetypes/catalog/catalog.tsp";
import "./resourcetypes/postActions/checkaddressspaceavailability.tsp";
import "./resourcetypes/transitHub/transitHub.tsp";
import "./resourcetypes/enclaveConnection/enclaveConnection.tsp";
import "./resourcetypes/communityEndpoint/communityEndpoint.tsp";
import "./resourcetypes/enclaveEndpoint/enclaveEndpoint.tsp";
import "./resourcetypes/postActions/approvalcallback.tsp";
import "./resourcetypes/approvals/approvals.tsp";
import "./resourcetypes/postActions/initiatorcallback.tsp";
import "./resourcetypes/postActions/approvaldeletioncallback.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Arm resource update successful")
model ArmUpdatedResponse<TResource extends Azure.ResourceManager.Foundations.Resource>
  is ArmResponse<TResource>;

@doc("Community Model Resource")
model CommunityResource is TrackedResource<CommunityProperties> {
  @key("communityName")
  @segment("communities")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @path
  @doc("The name of the communityResource Resource")
  name: string;

  /** The managed service identity for this resource */
  ...ManagedServiceIdentityProperty;
}

@@added(CommunityResource.identity,
  Microsoft.Mission.Versions.v2024_06_01_preview
);

@doc("Virtual Enclave Model Resource")
model EnclaveResource is TrackedResource<VirtualEnclaveProperties> {
  @key("virtualEnclaveName")
  @segment("virtualEnclaves")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the enclaveResource Resource")
  @path
  name: string;

  /** The managed service identity for this resource */
  ...ManagedServiceIdentityProperty;
}

@@added(EnclaveResource.identity,
  Microsoft.Mission.Versions.v2024_06_01_preview
);

@doc("Workload Model Resource")
@parentResource(EnclaveResource)
model WorkloadResource is TrackedResource<WorkloadProperties> {
  @key("workloadName")
  @segment("workloads")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @path
  @doc("The name of the workloadResource Resource")
  name: string;
}

@added(Microsoft.Mission.Versions.v2024_06_01_preview)
@doc("TransitHub Model Resource")
@parentResource(CommunityResource)
model TransitHubResource is TrackedResource<TransitHubProperties> {
  @key("transitHubName")
  @segment("transitHubs")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-_]*[a-zA-Z0-9]$")
  @doc("The name of the TransitHub Resource")
  name: string;
}

@added(Microsoft.Mission.Versions.v2024_06_01_preview)
@doc("EnclaveConnection Model Resource")
model EnclaveConnectionResource
  is TrackedResource<EnclaveConnectionProperties> {
  @key("enclaveConnectionName")
  @segment("enclaveConnections")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-_]*[a-zA-Z0-9]$")
  @doc("The name of the Enclave Connection Resource")
  name: string;
}

@added(Microsoft.Mission.Versions.v2024_06_01_preview)
@doc("EnclaveEndpoint Model Resource")
@parentResource(EnclaveResource)
model EnclaveEndpointResource is TrackedResource<EnclaveEndpointProperties> {
  @key("enclaveEndpointName")
  @segment("enclaveEndpoints")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-_]*[a-zA-Z0-9]$")
  @doc("The name of the Enclave Endpoint Resource")
  name: string;
}

@added(Microsoft.Mission.Versions.v2024_06_01_preview)
@doc("CommunityEndpoint Model Resource")
@parentResource(CommunityResource)
model CommunityEndpointResource
  is TrackedResource<CommunityEndpointProperties> {
  @key("communityEndpointName")
  @segment("communityEndpoints")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-_]*[a-zA-Z0-9]$")
  @doc("The name of the Community Endpoint Resource")
  name: string;
}

@added(Microsoft.Mission.Versions.v2024_06_01_preview)
@doc("Approval Model Resource")
model ApprovalResource is ExtensionResource<ApprovalProperties> {
  @key("approvalName")
  @segment("approvals")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the approvals resource.")
  name: string;
}
