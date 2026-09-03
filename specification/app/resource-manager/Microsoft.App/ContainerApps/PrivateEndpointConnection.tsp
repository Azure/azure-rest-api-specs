import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./ContainerApp.tsp";
import "./ManagedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.App;

model ContainerAppsPrivateLinkResourceNameParameter
  is Azure.ResourceManager.CommonTypes.PrivateLinkResourceNameParameter;

@@path(
  ContainerAppsPrivateLinkResourceNameParameter.name,
  "privateLinkResourceName"
);

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

alias ContainerAppPrivateEndpointConnectionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Container App. */
    @path
    @segment("containerApps")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    containerAppName: string;
  },
  {
    /** Name of the Private Endpoint Connection. */
    @path
    @segment("privateEndpointConnections")
    @key
    privateEndpointConnectionName: string;
  }
>;

alias ContainerAppPrivateLinkResourceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Container App. */
    @path
    @segment("containerApps")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    containerAppName: string;
  },
  {
    ...ContainerAppsPrivateLinkResourceNameParameter;
  }
>;

alias ManagedEnvironmentPrivateLinkResourceOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    ...ContainerAppsPrivateLinkResourceNameParameter;
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

@added(Versions.v2026_07_01)
@armResourceOperations(#{ omitTags: true })
@tag("ContainerApps")
@tag("PrivateEndpointConnections")
interface ContainerAppPrivateEndpointConnections {
  /**
   * Gets the details of a private endpoint connection associated with a Container App.
   */
  @summary("Get a private endpoint connection for a given Container App.")
  get is ContainerAppPrivateEndpointConnectionOps.Read<PrivateEndpointConnection>;

  /**
   * Creates a private endpoint connection or updates its connection state for a Container App.
   */
  @summary("Update the state of a private endpoint connection for a given Container App.")
  createOrUpdate is ContainerAppPrivateEndpointConnectionOps.CreateOrUpdateAsync<
    PrivateEndpointConnection,
    LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the specified private endpoint connection associated with a Container App.
   */
  @summary("Delete a private endpoint connection for a given Container App.")
  delete is ContainerAppPrivateEndpointConnectionOps.DeleteWithoutOkAsync<PrivateEndpointConnection>;

  /**
   * Lists all private endpoint connections associated with a Container App.
   */
  @summary("List private endpoint connections for a given Container App.")
  list is ContainerAppPrivateEndpointConnectionOps.List<PrivateEndpointConnection>;
}

@added(Versions.v2026_07_01)
@armResourceOperations(#{ omitTags: true })
@tag("ContainerApps")
@tag("PrivateLinkResources")
interface ContainerAppPrivateLinkResources {
  /**
   * Lists the private link resources supported by a Container App.
   */
  @summary("List private link resources for a given Container App.")
  list is ContainerAppPrivateLinkResourceOps.List<
    PrivateLinkResource,
    Response = ArmResponse<PrivateLinkResourceListResult>
  >;

  /**
   * Gets the details of a private link resource supported by a Container App.
   */
  @summary("Get a private link resource for a given Container App.")
  get is ContainerAppPrivateLinkResourceOps.Read<PrivateLinkResource>;
}

@added(Versions.v2026_07_01)
@armResourceOperations(#{ omitTags: true })
@tag("ManagedEnvironments")
@tag("PrivateLinkResources")
interface ManagedEnvironmentPrivateLinkResources {
  /**
   * Gets the details of a private link resource supported by a managed environment.
   */
  @summary("Get a private link resource for a given managed environment.")
  get is ManagedEnvironmentPrivateLinkResourceOps.Read<PrivateLinkResource>;
}

@@doc(
  PrivateEndpointConnection.name,
  "The name of the private endpoint connection associated with the Azure resource."
);
@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(
  PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The resource of private endpoint and its properties"
);
@@doc(
  ContainerAppPrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The resource of private endpoint and its properties"
);
