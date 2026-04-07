import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Resources;
/**
 * Resource group information.
 */
@subscriptionResource
model ResourceGroup
  is Azure.ResourceManager.TrackedResource<ResourceGroupProperties> {
  ...ResourceNameParameter<
    Resource = ResourceGroup,
    KeyName = "resourceGroupName",
    SegmentName = "resourceGroups",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;

  /**
   * The ID of the resource that manages this resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  managedBy?: string;
}

@armResourceOperations(#{ omitTags: true })
interface ResourceGroups {
  /**
   * Gets a resource group.
   */
  @tag("ResourceGroups")
  get is ArmResourceRead<ResourceGroup, Provider = {}, Error = CloudError>;

  /**
   * Checks whether a resource group exists.
   */
  @tag("ResourceGroups")
  checkExistence is ArmResourceCheckExistence<
    ResourceGroup,
    Provider = {},
    Error = CloudError
  >;

  /**
   * Creates or updates a resource group.
   */
  @tag("ResourceGroups")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ResourceGroup,
    Provider = {},
    Error = CloudError
  >;

  /**
   * Resource groups can be updated through a simple PATCH operation to a group address. The format of the request is the same as that for creating a resource group. If a field is unspecified, the current value is retained.
   */
  @patch(#{ implicitOptionality: false })
  @tag("ResourceGroups")
  update is ArmCustomPatchSync<
    ResourceGroup,
    PatchModel = ResourceGroupPatchable,
    Provider = {},
    Error = CloudError
  >;

  /**
   * When you delete a resource group, all of its resources are also deleted. Deleting a resource group deletes all of its template deployments and currently stored operations.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @tag("ResourceGroups")
  delete is ArmResourceDeleteWithoutOkAsync<
    ResourceGroup,
    Parameters = {
      /**
       * The resource types you want to force delete. Currently, only the following is supported: forceDeletionTypes=Microsoft.Compute/virtualMachines,Microsoft.Compute/virtualMachineScaleSets
       */
      @query("forceDeletionTypes")
      forceDeletionTypes?: string;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse,
    Provider = {},
    Error = CloudError
  >;

  /**
   * Gets all the resource groups for a subscription.
   */
  @segment("resourcegroups")
  @tag("ResourceGroups")
  list is ArmResourceListByParent<
    ResourceGroup,
    Parameters = {
      /**
       * The filter to apply on the operation.<br><br>You can filter by tag names and values. For example, to filter for a tag name and value, use $filter=tagName eq 'tag1' and tagValue eq 'Value1'
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to return. If null is passed, returns all resource groups.
       */
      @query("$top")
      $top?: int32;
    },
    Provider = {},
    Error = CloudError
  >;

  /**
   * Get all the resources for a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Resources_ListByResourceGroup")
  @tag("ResourceGroups")
  @list
  @get
  @action("resources")
  listByResourceGroup is ArmResourceActionSync<
    ResourceGroup,
    void,
    ArmResponse<ResourceListResult>,
    Parameters = {
      /**
       * The filter to apply on the operation.<br><br>The properties you can use for eq (equals) or ne (not equals) are: location, resourceType, name, resourceGroup, identity, identity/principalId, plan, plan/publisher, plan/product, plan/name, plan/version, and plan/promotionCode.<br><br>For example, to filter by a resource type, use: $filter=resourceType eq 'Microsoft.Network/virtualNetworks'<br><br>You can use substringof(value, property) in the filter. The properties you can use for substring are: name and resourceGroup.<br><br>For example, to get all resources with 'demo' anywhere in the name, use: $filter=substringof('demo', name)<br><br>You can link more than one substringof together by adding and/or operators.<br><br>You can filter by tag names and values. For example, to filter for a tag name and value, use $filter=tagName eq 'tag1' and tagValue eq 'Value1'. When you filter by a tag name and value, the tags for each resource are not returned in the results.<br><br>You can use some properties together when filtering. The combinations you can use are: substringof and/or resourceType, plan and plan/publisher and plan/name, identity and identity/principalId.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Comma-separated list of additional properties to be included in the response. Valid values include `createdTime`, `changedTime` and `provisioningState`. For example, `$expand=createdTime,changedTime`.
       */
      @query("$expand")
      $expand?: string;

      /**
       * The number of results to return. If null is passed, returns all resources.
       */
      @query("$top")
      $top?: int32;
    },
    Provider = {},
    Error = CloudError
  >;

  /**
   * The resources to be moved must be in the same source resource group in the source subscription being used. The target resource group may be in a different subscription. When moving resources, both the source group and the target group are locked for the duration of the operation. Write and delete operations are blocked on the groups until the move completes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Resources_MoveResources")
  @tag("Resources")
  @Azure.ResourceManager.Legacy.renamePathParameter(
    "resourceGroupName",
    "sourceResourceGroupName"
  )
  moveResources is ArmResourceActionAsync<
    ResourceGroup,
    ResourcesMoveInfo,
    NoContentResponse,
    Provider = {},
    Error = CloudError
  >;

  /**
   * This operation checks whether the specified resources can be moved to the target. The resources to be moved must be in the same source resource group in the source subscription being used. The target resource group may be in a different subscription. If validation succeeds, it returns HTTP response code 204 (no content). If validation fails, it returns HTTP response code 409 (Conflict) with an error message. Retrieve the URL in the Location header value to check the result of the long-running operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Resources_ValidateMoveResources")
  @tag("Resources")
  @Azure.ResourceManager.Legacy.renamePathParameter(
    "resourceGroupName",
    "sourceResourceGroupName"
  )
  validateMoveResources is ArmResourceActionAsync<
    ResourceGroup,
    ResourcesMoveInfo,
    NoContentResponse,
    Provider = {},
    Error = CloudError
  >;

  /**
   * Captures the specified resource group as a template.
   */
  @tag("ResourceGroups")
  exportTemplate is ArmResourceActionAsync<
    ResourceGroup,
    ExportTemplateRequest,
    ResourceGroupExportResult,
    Provider = {},
    Error = CloudError
  >;
}

@@maxLength(ResourceGroup.name, 90);
@@minLength(ResourceGroup.name, 1);
@@doc(ResourceGroup.name,
  "The name of the resource group to get. The name is case insensitive."
);
@@doc(ResourceGroup.properties, "The resource group properties.");
@@doc(ResourceGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update a resource group."
);
@@doc(ResourceGroups.update::parameters.properties,
  "Parameters supplied to update a resource group."
);
@@doc(ResourceGroups.moveResources::parameters.body,
  "Parameters for moving resources."
);
@@doc(ResourceGroups.validateMoveResources::parameters.body,
  "Parameters for moving resources."
);
@@doc(ResourceGroups.exportTemplate::parameters.body,
  "Parameters for exporting the template."
);
