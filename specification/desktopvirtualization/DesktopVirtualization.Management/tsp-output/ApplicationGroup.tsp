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

namespace Microsoft.DesktopVirtualization;
/**
 * Represents a ApplicationGroup definition.
 */
model ApplicationGroup is TrackedResource<ApplicationGroupProperties> {
  /**
   * The name of the application group
   */
  @maxLength(64)
  @minLength(3)
  @path
  @key("applicationGroupName")
  @segment("applicationGroups")
  name: string;
}

@armResourceOperations
interface ApplicationGroups {
  /**
   * Get an application group.
   */
  get is ArmResourceRead<ApplicationGroup>;

  /**
   * Create or update an applicationGroup.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<ApplicationGroup>;

  /**
   * Update an applicationGroup.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<ApplicationGroup, ApplicationGroupPatch>;

  /**
   * Remove an applicationGroup.
   */
  delete is ArmResourceDeleteSync<ApplicationGroup>;

  /**
   * List applicationGroups.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApplicationGroups_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    ApplicationGroup,
    {
      ...BaseParameters<ApplicationGroup>;

      /**
       * OData filter expression. Valid properties for filtering are applicationGroupType.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of items per page.
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      @query("initialSkip")
      initialSkip?: int32;
    }
  >;

  /**
   * List applicationGroups in subscription.
   */
  listBySubscription is ArmListBySubscription<ApplicationGroup>;

  /**
   * List start menu items in the given application group.
   */
  // FIXME: StartMenuItems_List could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StartMenuItems_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/applicationGroups/{applicationGroupName}/startMenuItems")
  @get
  list is Azure.Core.Foundations.Operation<
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
       * The name of the application group
       */
      @maxLength(64)
      @minLength(3)
      @path
      applicationGroupName: string;

      /**
       * Number of items per page.
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      @query("initialSkip")
      initialSkip?: int32;
    },
    StartMenuItemList
  >;
}

@@projectedName(ApplicationGroups.createOrUpdate::parameters.resource,
  "json",
  "applicationGroup"
);
@@extension(ApplicationGroups.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "applicationGroup"
);
@@doc(ApplicationGroups.createOrUpdate::parameters.resource,
  "Object containing ApplicationGroup definitions."
);
@@projectedName(ApplicationGroups.update::parameters.properties,
  "json",
  "applicationGroup"
);
@@extension(ApplicationGroups.update::parameters.properties,
  "x-ms-client-name",
  "applicationGroup"
);
@@doc(ApplicationGroups.update::parameters.properties,
  "Object containing ApplicationGroup definitions."
);
