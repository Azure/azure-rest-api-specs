import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DeviceRegistry;
/**
 * Asset Endpoint Profile definition.
 */
model AssetEndpointProfile is TrackedResource<AssetEndpointProfileProperties> {
  /**
   * Asset Endpoint Profile name parameter.
   */
  @maxLength(63)
  @minLength(3)
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @key("assetEndpointProfileName")
  @segment("assetEndpointProfiles")
  name: string;

  /**
   * The extended location.
   */
  @visibility("read", "create")
  extendedLocation: AssetEndpointProfileExtendedLocation;
}

@armResourceOperations
interface AssetEndpointProfiles {
  /**
   * Retrieve a single Asset Endpoint Profile.
   */
  get is ArmResourceRead<AssetEndpointProfile>;

  /**
   * Create a new Asset Endpoint Profile or replace an existing Asset Endpoint Profile.
   */
  createOrReplace is ArmResourceCreateOrReplaceAsync<AssetEndpointProfile>;

  /**
   * Update specific Asset Endpoint Profile properties.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    AssetEndpointProfile,
    AssetEndpointProfilePatchPayload
  >;

  /**
   * Delete an Asset Endpoint Profile.
   */
  delete is ArmResourceDeleteWithoutOkAsync<AssetEndpointProfile>;

  /**
   * List all Asset Endpoint Profiles in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AssetEndpointProfiles_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AssetEndpointProfile>;

  /**
   * List all Asset Endpoint Profiles in a subscription.
   */
  listBySubscription is ArmListBySubscription<AssetEndpointProfile>;
}

@@projectedName(AssetEndpointProfiles.createOrReplace::parameters.resource,
  "json",
  "assetEndpointProfile"
);
@@extension(AssetEndpointProfiles.createOrReplace::parameters.resource,
  "x-ms-client-name",
  "assetEndpointProfile"
);
@@doc(AssetEndpointProfiles.createOrReplace::parameters.resource,
  "Resource create or replace parameters."
);
@@projectedName(AssetEndpointProfiles.update::parameters.properties,
  "json",
  "assetEndpointProfile"
);
@@extension(AssetEndpointProfiles.update::parameters.properties,
  "x-ms-client-name",
  "assetEndpointProfile"
);
@@doc(AssetEndpointProfiles.update::parameters.properties,
  "Resource Update parameters."
);
