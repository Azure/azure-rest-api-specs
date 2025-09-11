import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Fabric;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" ""
#suppress "@typespec/http/metadata-ignored" ""
@doc("PrivateEndpointConnection Object")
@parentResource(PrivateLinkServiceForFabric)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("Name")
  @key("privateEndpointConnectionName")
  @path
  @segment("privateEndpointConnections")
  @visibility(Lifecycle.Read)
  name: string;
}

@doc("PrivateEndpointConnection Properties")
model PrivateEndpointConnectionProperties {
  @doc("Private Endpoint")
  @visibility(Lifecycle.Read)
  privateEndpoint: PrivateEndpoint;

  @doc("Private Link Service Connection State")
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  @doc("Provisioning State")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("Private Link Service Connection")
model PrivateLinkServiceConnection {
  @doc("Private Link Service Connection Name")
  name: string;

  @doc("Group Ids")
  groupIds: string[];

  @doc("Request Message")
  requestMessage: string;
}

@doc("Private Endpoint")
model PrivateEndpoint {
  @doc("Resource Id")
  id: armResourceIdentifier;
}

@doc("Private Link Service Connection State")
model PrivateLinkServiceConnectionState {
  @doc("Connection Status")
  status: ConnectionStatus;

  @doc("Connection Status Description")
  description?: string;

  @doc("Required Actions")
  actionsRequired: ConnectionActions;
}

@doc("Connection Status")
union ConnectionStatus {
  string,

  @doc("Pending Status")
  Pending: "Pending",

  @doc("Approved Status")
  Approved: "Approved",

  @doc("Rejected Status")
  Rejected: "Rejected",

  @doc("Disconnected Status")
  Disconnected: "Disconnected",
}

@doc("Connection Actions")
union ConnectionActions {
  string,

  @doc("No Action Required")
  None: "None",

  @doc("Recreate Required")
  Recreate: "Recreate",
}

@armResourceOperations
interface CustomizedArmResourceOperation {
  @doc("Update")
  ArmUpdateWithBodyOperation<
    HttpParameters extends {},
    BodyParameter extends {},
    Response extends {},
    ErrorResponse extends {}
  >(
    ...HttpParameters,

    @doc("Resource to be updated.")
    @body
    resource: BodyParameter,
  ): Response | ErrorResponse;

  @autoRoute
  @doc("Update a {name}", Resource)
  @armResourceCreateOrUpdate(Resource)
  @put
  ArmResourceUpdateSync<
    Resource extends Azure.ResourceManager.Foundations.Resource,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Resource>,
    Parameters extends {} = {},
    Response extends {} = ArmResourceUpdatedResponse<Resource>,
    Error extends {} = ErrorResponse
  > is CustomizedArmResourceOperation.ArmUpdateWithBodyOperation<
    ResourceInstanceParameters<Resource, BaseParameters>,
    Resource,
    Response,
    Error
  >;

  @autoRoute
  @doc("Delete a {name}", Resource)
  @armResourceDelete(Resource)
  ArmResourceDeleteNoOkAsync<
    Resource extends Azure.ResourceManager.Foundations.Resource,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Resource>,
    LroHeaders extends TypeSpec.Reflection.Model = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    Parameters extends {} = {},
    Response extends {} = ArmDeleteAcceptedLroResponse<LroHeaders> | ArmDeletedNoContentResponse,
    Error extends {} = ErrorResponse
  > is ArmResourceDeleteAsyncBase<
    Resource,
    Response,
    BaseParameters,
    Parameters,
    Error
  >;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Get private endpoint connection")
  get is ArmResourceRead<PrivateEndpointConnection>;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" ""
  @doc("Update private endpoint connection")
  update is CustomizedArmResourceOperation.ArmResourceUpdateSync<PrivateEndpointConnection>;
  @doc("Delete private endpoint connection")
  delete is CustomizedArmResourceOperation.ArmResourceDeleteNoOkAsync<PrivateEndpointConnection>;
  #suppress "@azure-tools/typespec-azure-core/no-openapi" ""
  @doc("List private endpoint connections")
  @operationId("PrivateEndpointConnections_List")
  list is ArmResourceListAtScope<PrivateEndpointConnection>;
}
