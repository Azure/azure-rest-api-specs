import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * The result of the Service Fabric runtime versions
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model ManagedClusterCodeVersionResult
  is Azure.ResourceManager.ProxyResource<ManagedClusterVersionDetails> {
  ...ResourceNameParameter<
    Resource = ManagedClusterCodeVersionResult,
    KeyName = "clusterVersion",
    SegmentName = "managedClusterVersions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ManagedClusterCodeVersionResultOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...LocationParameter,

        /** environments */
        @path @segment("environments") environment: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = ManagedClusterCodeVersionResult,
        KeyName = "clusterVersion",
        SegmentName = "managedClusterVersions",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ManagedClusterCodeVersionResults {
  /**
   * Gets information about an available Service Fabric cluster code version by environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Backwards compatibility with non-standard operation id"
  @operationId("ManagedClusterVersion_GetByEnvironment")
  getByEnvironment is ManagedClusterCodeVersionResultOps.Read<ManagedClusterCodeVersionResult>;

  /**
   * Gets all available code versions for Service Fabric cluster resources by environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Backwards compatibility with non-standard operation id"
  @operationId("ManagedClusterVersion_ListByEnvironment")
  listByEnvironment is ManagedClusterCodeVersionResultOps.List<
    ManagedClusterCodeVersionResult,
    Response = ManagedClusterCodeVersionListResult
  >;
}

@armResourceOperations
interface ManagedClusterVersionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...LocationParameter,
      },
      KeysOf<ResourceNameParameter<
        Resource = ManagedClusterCodeVersionResult,
        KeyName = "clusterVersion",
        SegmentName = "managedClusterVersions",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ManagedClusterVersion {
  /**
   * Gets information about an available Service Fabric managed cluster code version.
   */
  get is ManagedClusterVersionOps.Read<ManagedClusterCodeVersionResult>;

  /**
   * Gets all available code versions for Service Fabric cluster resources by location.
   */
  list is ManagedClusterVersionOps.List<
    ManagedClusterCodeVersionResult,
    Response = ManagedClusterCodeVersionListResult
  >;
}

@@doc(ManagedClusterCodeVersionResult.name, "The cluster code version.");
@@doc(ManagedClusterCodeVersionResult.properties,
  "The detail of the Service Fabric runtime version result"
);

/**
 * The list results of the Service Fabric runtime versions.
 */
model ManagedClusterCodeVersionListResult {
  /**
   *  The list results of the Service Fabric runtime versions.
   */
  @body body: ManagedClusterCodeVersionResult[];
}
