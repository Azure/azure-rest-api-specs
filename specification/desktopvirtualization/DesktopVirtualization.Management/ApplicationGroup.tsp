import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
/**
 * Represents a ApplicationGroup definition.
 */
model ApplicationGroup
  is Azure.ResourceManager.TrackedResource<ApplicationGroupProperties, false> {
  ...ResourceNameParameter<
    Resource = ApplicationGroup,
    KeyName = "applicationGroupName",
    SegmentName = "applicationGroups",
    NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
  >;
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
  @parameterVisibility
  update is ArmCustomPatchSync<ApplicationGroup, ApplicationGroupPatch>;

  /**
   * Remove an applicationGroup.
   */
  delete is ArmResourceDeleteSync<ApplicationGroup>;

  /**
   * List applicationGroups.
   */
  listByResourceGroup is ArmResourceListByParent<
    ApplicationGroup,
    Parameters = {
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
    },
    Response = ApplicationGroupList
  >;

  /**
   * List applicationGroups in subscription.
   */
  listBySubscription is ArmListBySubscription<
    ApplicationGroup,
    Parameters = {
      /**
       * OData filter expression. Valid properties for filtering are applicationGroupType.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ApplicationGroupList
  >;

  /**
   * List start menu items in the given application group.
   */
  @get
  list is ArmResourceActionSync<
    ApplicationGroup,
    void,
    StartMenuItemList,
    Parameters = {
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
}

@@maxLength(ApplicationGroup.name, 64);
@@minLength(ApplicationGroup.name, 3);
@@doc(ApplicationGroup.name, "The name of the application group");
@@doc(ApplicationGroup.properties, "Detailed properties for ApplicationGroup");
@@doc(ApplicationGroups.createOrUpdate::parameters.resource,
  "Object containing ApplicationGroup definitions."
);
@@doc(ApplicationGroups.update::parameters.properties,
  "Object containing ApplicationGroup definitions."
);
