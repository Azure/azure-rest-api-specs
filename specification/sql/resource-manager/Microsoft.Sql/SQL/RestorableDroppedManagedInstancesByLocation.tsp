import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Sql;

/**
 * A restorable dropped managed instance resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Feature metadata is required to emit this operation group as a separate Swagger file."
@added(Versions.v2026_11_01_preview)
@subscriptionResource
@Azure.ResourceManager.Legacy.feature(
  Microsoft.SqlFeatureRegistration.RestoreFromDroppedManagedInstanceFeatures.RestorableDroppedManagedInstancesByLocation
)
model RestorableDroppedManagedInstance
  is TrackedResource<RestorableDroppedManagedInstanceProperties> {
  ...ResourceNameParameter<
    Resource = RestorableDroppedManagedInstance,
    KeyName = "restorableDroppedManagedInstanceId",
    SegmentName = "restorableDroppedManagedInstances",
    NamePattern = ""
  >;
}

alias RestorableDroppedManagedInstanceLocationParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...Azure.ResourceManager.Legacy.Provider;

  /** The name of the location containing the dropped managed instances. */
  @path
  @segment("locations")
  @key
  locationName: Azure.Core.azureLocation;
};

alias RestorableDroppedManagedInstanceIdParameter = {
  /**
   * The dropped managed instance identifier, in the format 'instanceName,deletionTime',
   * where deletionTime is a Windows FILETIME value.
   */
  @path
  @segment("restorableDroppedManagedInstances")
  @key
  restorableDroppedManagedInstanceId: string;
};

alias RestorableDroppedManagedInstanceByLocationOps = Azure.ResourceManager.Legacy.LegacyOperations<
  RestorableDroppedManagedInstanceLocationParameters,
  RestorableDroppedManagedInstanceIdParameter,
  ResourceName = "RestorableDroppedManagedInstance"
>;

/**
 * Discovers restorable dropped managed instances in a location.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Feature metadata is required to emit this operation group as a separate Swagger file."
@added(Versions.v2026_11_01_preview)
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(
  Microsoft.SqlFeatureRegistration.RestoreFromDroppedManagedInstanceFeatures.RestorableDroppedManagedInstancesByLocation
)
interface RestorableDroppedManagedInstancesByLocation {
  /** Gets a restorable dropped managed instance in a location. */
  get is RestorableDroppedManagedInstanceByLocationOps.Read<RestorableDroppedManagedInstance>;

  /** Gets a list of restorable dropped managed instances in a location. */
  listByLocation is RestorableDroppedManagedInstanceByLocationOps.List<RestorableDroppedManagedInstance>;
}

@@doc(
  RestorableDroppedManagedInstance.name,
  "The identifier of the restorable dropped managed instance."
);
@@doc(RestorableDroppedManagedInstance.properties, "Resource properties.");
