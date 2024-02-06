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
 * Asset definition.
 */
model Asset is TrackedResource<AssetProperties> {
  /**
   * Asset name parameter.
   */
  @maxLength(63)
  @minLength(3)
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @key("assetName")
  @segment("assets")
  name: string;

  /**
   * The extended location.
   */
  @visibility("read", "create")
  extendedLocation: AssetExtendedLocation;
}

@armResourceOperations
interface Assets {
  /**
   * Retrieve a single asset.
   */
  get is ArmResourceRead<Asset>;

  /**
   * Create a new asset or replace an existing asset.
   */
  createOrReplace is ArmResourceCreateOrReplaceAsync<Asset>;

  /**
   * Update specific asset properties.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<Asset, AssetPatchPayload>;

  /**
   * Delete an asset.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Asset>;

  /**
   * List all assets in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Assets_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Asset>;

  /**
   * List all assets in a subscription.
   */
  listBySubscription is ArmListBySubscription<Asset>;
}

@@projectedName(Assets.createOrReplace::parameters.resource, "json", "asset");
@@extension(Assets.createOrReplace::parameters.resource,
  "x-ms-client-name",
  "asset"
);
@@doc(Assets.createOrReplace::parameters.resource,
  "Resource create or replace parameters."
);
@@projectedName(Assets.update::parameters.properties, "json", "asset");
@@extension(Assets.update::parameters.properties, "x-ms-client-name", "asset");
@@doc(Assets.update::parameters.properties, "Resource Update parameters.");
