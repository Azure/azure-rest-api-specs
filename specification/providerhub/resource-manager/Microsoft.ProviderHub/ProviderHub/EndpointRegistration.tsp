import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./ResourceTypeRegistration.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface EndpointRegistrationOps
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
        /** The endpoint registration name. */
        @path
        @segment("endpoints")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        endpointName: string,
      }
    > {}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface NestedResourceTypeFirstEndpointRegistrationOps
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
        /** The endpoint registration name. */
        @path
        @segment("endpoints")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        endpointName: string,
      }
    > {}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface NestedResourceTypeSecondEndpointRegistrationOps
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
        /** The endpoint registration name. */
        @path
        @segment("endpoints")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        endpointName: string,
      }
    > {}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface NestedResourceTypeThirdEndpointRegistrationOps
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
        /** The endpoint registration name. */
        @path
        @segment("endpoints")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        endpointName: string,
      }
    > {}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface EndpointRegistrations {
  /** Gets an endpoint registration. */
  get is EndpointRegistrationOps.Read<EndpointRegistration>;

  /** Creates or replaces an endpoint registration. */
  createOrUpdate is EndpointRegistrationOps.CreateOrUpdateSync<EndpointRegistration>;

  /** Deletes an endpoint registration. */
  delete is EndpointRegistrationOps.DeleteSync<EndpointRegistration>;

  /** Lists endpoint registrations for a resource type registration. */
  listByResourceTypeRegistration is EndpointRegistrationOps.List<
    EndpointRegistration,
    Response = ArmResponse<EndpointRegistrationArrayResponseWithContinuation>
  >;

  /** Gets an endpoint registration for a first-level nested resource type. */
  getNestedResourceTypeFirst is NestedResourceTypeFirstEndpointRegistrationOps.Read<EndpointRegistration>;

  /** Creates or replaces an endpoint registration for a first-level nested resource type. */
  createOrUpdateNestedResourceTypeFirst is NestedResourceTypeFirstEndpointRegistrationOps.CreateOrUpdateSync<EndpointRegistration>;

  /** Deletes an endpoint registration for a first-level nested resource type. */
  deleteNestedResourceTypeFirst is NestedResourceTypeFirstEndpointRegistrationOps.DeleteSync<EndpointRegistration>;

  /** Lists endpoint registrations for a first-level nested resource type. */
  listByResourceTypeRegistrationNestedResourceTypeFirst is NestedResourceTypeFirstEndpointRegistrationOps.List<
    EndpointRegistration,
    Response = ArmResponse<EndpointRegistrationArrayResponseWithContinuation>
  >;

  /** Gets an endpoint registration for a second-level nested resource type. */
  getNestedResourceTypeSecond is NestedResourceTypeSecondEndpointRegistrationOps.Read<EndpointRegistration>;

  /** Creates or replaces an endpoint registration for a second-level nested resource type. */
  createOrUpdateNestedResourceTypeSecond is NestedResourceTypeSecondEndpointRegistrationOps.CreateOrUpdateSync<EndpointRegistration>;

  /** Deletes an endpoint registration for a second-level nested resource type. */
  deleteNestedResourceTypeSecond is NestedResourceTypeSecondEndpointRegistrationOps.DeleteSync<EndpointRegistration>;

  /** Lists endpoint registrations for a second-level nested resource type. */
  listByResourceTypeRegistrationNestedResourceTypeSecond is NestedResourceTypeSecondEndpointRegistrationOps.List<
    EndpointRegistration,
    Response = ArmResponse<EndpointRegistrationArrayResponseWithContinuation>
  >;

  /** Gets an endpoint registration for a third-level nested resource type. */
  getNestedResourceTypeThird is NestedResourceTypeThirdEndpointRegistrationOps.Read<EndpointRegistration>;

  /** Creates or replaces an endpoint registration for a third-level nested resource type. */
  createOrUpdateNestedResourceTypeThird is NestedResourceTypeThirdEndpointRegistrationOps.CreateOrUpdateSync<EndpointRegistration>;

  /** Deletes an endpoint registration for a third-level nested resource type. */
  deleteNestedResourceTypeThird is NestedResourceTypeThirdEndpointRegistrationOps.DeleteSync<EndpointRegistration>;

  /** Lists endpoint registrations for a third-level nested resource type. */
  listByResourceTypeRegistrationNestedResourceTypeThird is NestedResourceTypeThirdEndpointRegistrationOps.List<
    EndpointRegistration,
    Response = ArmResponse<EndpointRegistrationArrayResponseWithContinuation>
  >;
}

@@doc(EndpointRegistration.name, "The endpoint registration name.");
@@doc(EndpointRegistration.properties, "The endpoint configuration.");
@@doc(
  EndpointRegistrations.createOrUpdate::parameters.resource,
  "The endpoint registration supplied to the CreateOrUpdate operation."
);
@@doc(
  EndpointRegistrations.createOrUpdateNestedResourceTypeFirst::parameters.resource,
  "The endpoint registration supplied to the CreateOrUpdate operation."
);
@@doc(
  EndpointRegistrations.createOrUpdateNestedResourceTypeSecond::parameters.resource,
  "The endpoint registration supplied to the CreateOrUpdate operation."
);
@@doc(
  EndpointRegistrations.createOrUpdateNestedResourceTypeThird::parameters.resource,
  "The endpoint registration supplied to the CreateOrUpdate operation."
);
