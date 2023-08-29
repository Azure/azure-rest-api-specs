import "./Common/PrivateEndpointEnums.tsp";
import "./Common/AzureResourceProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Private endpoint connection resource.")
@parentResource(AssessmentProject)
model PrivateEndpointConnection
    is ProxyResource<PrivateEndpointConnectionProperties> {
    @doc("Private endpoint connection ARM name")
    @key("privateEndpointConnectionName")
    @segment("privateEndpointConnections")
    @path
    name: string;
}

@doc("Private endpoint connection properties.")
model PrivateEndpointConnectionProperties extends AzureResourceProperties {
    // @doc("Indicates whether there is an ongoing operation on the private endpoint.")
    // @visibility("read")
    // provisioningState?: PrivateEndpointConnectionPropertiesProvisioningState;

    @doc("ARM id for the private endpoint resource corresponding to the connection.")
    @visibility("read")
    privateEndpoint?: ResourceId;

    @doc("State of the private endpoint connection.")
    privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;
}

@doc("ARM id for a resource.")
model ResourceId {
    @visibility("read")
    @doc("Gets the relative URL to get to this REST resource.")
    id?: string;
}

@doc("State of a private endpoint connection.")
model PrivateLinkServiceConnectionState {
    @doc("Connection status of the private endpoint connection.")
    status?: PrivateLinkServiceConnectionStateStatus;

    @doc("Description of the private endpoint connection.")
    description?: string;

    @doc("Actions required on the private endpoint connection.")
    actionsRequired?: string;
}
