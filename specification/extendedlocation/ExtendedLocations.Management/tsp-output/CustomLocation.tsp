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

namespace Microsoft.ExtendedLocation;
/**
 * Custom Locations definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(CustomLocationProperties)
model CustomLocation extends TrackedResourceBase {
  /**
   * Custom Locations name.
   */
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
  @path
  @key("resourceName")
  @segment("customLocations")
  @visibility("read")
  name: string;

  /**
   * The set of properties specific to a Custom Location
   */
  @extension("x-ms-client-flatten", true)
  properties?: CustomLocationProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface CustomLocations {
  /**
   * Gets the details of the customLocation with a specified resource group and name.
   */
  get is ArmResourceRead<CustomLocation>;

  /**
   * Creates or updates a Custom Location in the specified Subscription and Resource Group
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CustomLocation,
    BaseParameters<CustomLocation>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates a Custom Location with the specified Resource Name in the specified Resource Group and Subscription.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<CustomLocation, PatchableCustomLocations>;

  /**
   * Deletes the Custom Location with the specified Resource Name, Resource Group, and Subscription Id.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    CustomLocation,
    BaseParameters<CustomLocation>,
    ArmAsyncOperationHeader
  >;

  /**
   * Gets a list of Custom Locations in the specified subscription and resource group. The operation returns properties of each Custom Location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CustomLocations_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<CustomLocation>;

  /**
   * Gets a list of Custom Locations in the specified subscription. The operation returns properties of each Custom Location
   */
  listBySubscription is ArmListBySubscription<CustomLocation>;

  /**
   * Gets the list of the Enabled Resource Types.
   */
  // FIXME: CustomLocations_ListEnabledResourceTypes could not be converted to a resource operation
  @summary("Gets the list of Enabled Resource Types.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ExtendedLocation/customLocations/{resourceName}/enabledResourceTypes")
  @get
  listEnabledResourceTypes is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * Custom Locations name.
       */
      @maxLength(63)
      @minLength(1)
      @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
      @path
      resourceName: string;
    },
    EnabledResourceTypesListResult
  >;
}

@@projectedName(CustomLocations.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(CustomLocations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(CustomLocations.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update a Custom Location."
);
@@projectedName(CustomLocations.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(CustomLocations.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(CustomLocations.update::parameters.properties,
  "The updatable fields of an existing Custom Location."
);
