import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./ResourceTypeRegistration.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.ProviderHub;

/**
 * An independently managed endpoint definition for a Resource Type Registration.
 */
@added(Versions.v2026_09_01_preview)
@parentResource(ResourceTypeRegistration)
model EndpointRegistration is Azure.ResourceManager.ProxyResource<
  ResourceTypeEndpoint,
  false
> {
  ...ResourceNameParameter<
    Resource = EndpointRegistration,
    KeyName = "endpointName",
    SegmentName = "endpoints",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;
}

/**
 * A page of Endpoint Registrations.
 */
@added(Versions.v2026_09_01_preview)
model EndpointRegistrationArrayResponseWithContinuation {
  /**
   * The Endpoint Registrations on this page.
   */
  @pageItems
  value?: EndpointRegistration[];

  /**
   * The URL to get to the next set of results, if there are any.
   */
  @nextLink
  nextLink?: url;
}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface EndpointRegistrationTopLevelOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the resource provider hosted within ProviderHub. */
        @path
        @segment("providerRegistrations")
        @key
        providerNamespace: string,

        /** The resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        resourceType: string,
      },
      {},
      {
        /** The endpoint name. */
        @path
        @segment("endpoints")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        endpointName: string,
      }
    > {}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface EndpointRegistrationNestedResourceTypeFirstOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the resource provider hosted within ProviderHub. */
        @path
        @segment("providerRegistrations")
        @key
        providerNamespace: string,

        /** The resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        resourceType: string,

        /** The first child resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        nestedResourceTypeFirst: string,
      },
      {},
      {
        /** The endpoint name. */
        @path
        @segment("endpoints")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        endpointName: string,
      }
    > {}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface EndpointRegistrationNestedResourceTypeSecondOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the resource provider hosted within ProviderHub. */
        @path
        @segment("providerRegistrations")
        @key
        providerNamespace: string,

        /** The resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        resourceType: string,

        /** The first child resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        nestedResourceTypeFirst: string,

        /** The second child resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        nestedResourceTypeSecond: string,
      },
      {},
      {
        /** The endpoint name. */
        @path
        @segment("endpoints")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        endpointName: string,
      }
    > {}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface EndpointRegistrationNestedResourceTypeThirdOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the resource provider hosted within ProviderHub. */
        @path
        @segment("providerRegistrations")
        @key
        providerNamespace: string,

        /** The resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        resourceType: string,

        /** The first child resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        nestedResourceTypeFirst: string,

        /** The second child resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        nestedResourceTypeSecond: string,

        /** The third child resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        nestedResourceTypeThird: string,
      },
      {},
      {
        /** The endpoint name. */
        @path
        @segment("endpoints")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        endpointName: string,
      }
    > {}

@added(Versions.v2026_09_01_preview)
@tag("EndpointRegistration")
@armResourceOperations(#{ omitTags: true })
interface EndpointRegistrations {
  /**
   * Gets an Endpoint Registration for the given resource type.
   */
  get is EndpointRegistrationTopLevelOps.Read<EndpointRegistration>;

  /**
   * Creates or updates an Endpoint Registration for the given resource type.
   */
  createOrUpdate is EndpointRegistrationTopLevelOps.CreateOrUpdateSync<EndpointRegistration>;

  /**
   * Deletes an Endpoint Registration for the given resource type.
   */
  delete is EndpointRegistrationTopLevelOps.DeleteSync<EndpointRegistration>;

  /**
   * Gets the list of Endpoint Registrations for the given resource type.
   */
  listByResourceTypeRegistration is EndpointRegistrationTopLevelOps.List<
    EndpointRegistration,
    Response = ArmResponse<EndpointRegistrationArrayResponseWithContinuation>
  >;

  /**
   * Gets an Endpoint Registration for the first nested resource type.
   */
  getNestedResourceTypeFirst is EndpointRegistrationNestedResourceTypeFirstOps.Read<EndpointRegistration>;

  /**
   * Creates or updates an Endpoint Registration for the first nested resource type.
   */
  createOrUpdateNestedResourceTypeFirst is EndpointRegistrationNestedResourceTypeFirstOps.CreateOrUpdateSync<EndpointRegistration>;

  /**
   * Deletes an Endpoint Registration for the first nested resource type.
   */
  deleteNestedResourceTypeFirst is EndpointRegistrationNestedResourceTypeFirstOps.DeleteSync<EndpointRegistration>;

  /**
   * Gets the list of Endpoint Registrations for the first nested resource type.
   */
  listByResourceTypeRegistrationNestedResourceTypeFirst is EndpointRegistrationNestedResourceTypeFirstOps.List<
    EndpointRegistration,
    Response = ArmResponse<EndpointRegistrationArrayResponseWithContinuation>
  >;

  /**
   * Gets an Endpoint Registration for the second nested resource type.
   */
  getNestedResourceTypeSecond is EndpointRegistrationNestedResourceTypeSecondOps.Read<EndpointRegistration>;

  /**
   * Creates or updates an Endpoint Registration for the second nested resource type.
   */
  createOrUpdateNestedResourceTypeSecond is EndpointRegistrationNestedResourceTypeSecondOps.CreateOrUpdateSync<EndpointRegistration>;

  /**
   * Deletes an Endpoint Registration for the second nested resource type.
   */
  deleteNestedResourceTypeSecond is EndpointRegistrationNestedResourceTypeSecondOps.DeleteSync<EndpointRegistration>;

  /**
   * Gets the list of Endpoint Registrations for the second nested resource type.
   */
  listByResourceTypeRegistrationNestedResourceTypeSecond is EndpointRegistrationNestedResourceTypeSecondOps.List<
    EndpointRegistration,
    Response = ArmResponse<EndpointRegistrationArrayResponseWithContinuation>
  >;

  /**
   * Gets an Endpoint Registration for the third nested resource type.
   */
  getNestedResourceTypeThird is EndpointRegistrationNestedResourceTypeThirdOps.Read<EndpointRegistration>;

  /**
   * Creates or updates an Endpoint Registration for the third nested resource type.
   */
  createOrUpdateNestedResourceTypeThird is EndpointRegistrationNestedResourceTypeThirdOps.CreateOrUpdateSync<EndpointRegistration>;

  /**
   * Deletes an Endpoint Registration for the third nested resource type.
   */
  deleteNestedResourceTypeThird is EndpointRegistrationNestedResourceTypeThirdOps.DeleteSync<EndpointRegistration>;

  /**
   * Gets the list of Endpoint Registrations for the third nested resource type.
   */
  listByResourceTypeRegistrationNestedResourceTypeThird is EndpointRegistrationNestedResourceTypeThirdOps.List<
    EndpointRegistration,
    Response = ArmResponse<EndpointRegistrationArrayResponseWithContinuation>
  >;
}

@@doc(EndpointRegistration.name, "The endpoint name.");
@@doc(
  EndpointRegistrations.createOrUpdate::parameters.resource,
  "The Endpoint Registration supplied to the CreateOrUpdate operation."
);
