import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * The Private Endpoint Connection resource.
 */
@parentResource(ManagedEnvironment)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

alias PrivateEndpointConnectionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the managed environment. */
    @path
    @segment("managedEnvironments")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    environmentName: string;
  },
  {
    /** Name of the Private Endpoint Connection. */
    @path
    @segment("privateEndpointConnections")
    @key
    privateEndpointConnectionName: string;
  }
>;

@armResourceOperations
@tag("ManagedEnvironments")
@tag("PrivateEndpointConnections")
interface PrivateEndpointConnections {
  /**
   * Get a private endpoint connection for a given managed environment.
   */
  @summary("Get a private endpoint connection for a given managed environment.")
  get is PrivateEndpointConnectionOps.Read<PrivateEndpointConnection>;

  /**
   * Update the state of a private endpoint connection for a given managed environment.
   */
  @summary("Update the state of a private endpoint connection for a given managed environment.")
  createOrUpdate is PrivateEndpointConnectionOps.CreateOrUpdateAsync<
    PrivateEndpointConnection,
    LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a private endpoint connection for a given managed environment.
   */
  @summary("Delete a private endpoint connection for a given managed environment.")
  delete is PrivateEndpointConnectionOps.DeleteWithoutOkAsync<PrivateEndpointConnection>;

  /**
   * List private endpoint connections for a given managed environment.
   */
  @summary("List private endpoint connections for a given managed environment.")
  list is PrivateEndpointConnectionOps.List<PrivateEndpointConnection>;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection associated with the Azure resource."
);
@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The resource of private endpoint and its properties"
);
