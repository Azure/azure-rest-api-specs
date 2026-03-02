import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Management;
using Azure.ResourceManager;
using Http;
using Rest;

namespace ClientCustomizations;

@@clientName(Microsoft.Management, "ManagementGroupsMgmtClient", "python");

@@clientLocation(checkNameAvailability, "API", "go");
@@clientLocation(startTenantBackfill, "API", "go");
@@clientLocation(tenantBackfillStatus, "API", "go");
@@usage(CreateManagementGroupChildInfo, Usage.input, "javascript");

/**
 * Retrieves details about given subscription which is associated with the management group.
 *
 */
@get
op getSubscriptionCustomized is Azure.ResourceManager.Foundations.ArmReadOperation<
  Azure.ResourceManager.Extension.ExtensionProviderNamespace<SubscriptionUnderManagementGroup> & {
    /**
     * The management group ID.
     */
    @path
    @segment("managementGroups")
    groupId: string;
  } & GetSubscriptionId &
    Azure.ResourceManager.ApiVersionParameter & {
      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
      @header("Cache-Control")
      @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("no-cache")
      `Cache-Control`?: string = "no-cache";
    },
  Azure.ResourceManager.ArmResponse<Microsoft.Management.SubscriptionUnderManagementGroup>,
  Azure.ResourceManager.CommonTypes.ErrorResponse
>;

/**
 * Associates existing subscription with the management group.
 *
 */
@put
op putSubscriptionCustomized is Azure.ResourceManager.Legacy.CreateOperation<
  Azure.ResourceManager.Extension.ExtensionProviderNamespace<SubscriptionUnderManagementGroup> & {
    /**
     * The management group ID.
     */
    @path
    @segment("managementGroups")
    groupId: string;
  } & PutSubscriptionId &
    Azure.ResourceManager.ApiVersionParameter & {
      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
      @header("Cache-Control")
      @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("no-cache")
      `Cache-Control`?: string = "no-cache";
    },
  void,
  Azure.ResourceManager.ArmResourceUpdatedResponse<Microsoft.Management.SubscriptionUnderManagementGroup>,
  Azure.ResourceManager.CommonTypes.ErrorResponse
>;

/**
 * De-associates subscription from the management group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "For overriding with custom operation."
@delete
op deleteSubscriptionCustomized is SubscriptionUnderManagementGroupOperations.ArmDeleteOperation<
  Azure.ResourceManager.Extension.ExtensionProviderNamespace<SubscriptionUnderManagementGroup> & {
    /**
     * The management group ID.
     */
    @path
    @segment("managementGroups")
    groupId: string;
  } & DeleteSubscriptionId &
    Azure.ResourceManager.ApiVersionParameter & {
      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
      @header("Cache-Control")
      @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("no-cache")
      `Cache-Control`?: string = "no-cache";
    },
  Azure.ResourceManager.ArmDeletedResponse,
  Azure.ResourceManager.CommonTypes.ErrorResponse
>;

/**
 * override for ManagementGroupsOperationGroup.list
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op managementGroupsOperationGroupList(
  ...ApiVersionParameter,
  scope: SubscriptionActionScope,
  ...Azure.ResourceManager.Legacy.Provider,

  /**
   * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @header("Cache-Control")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("no-cache")
  `Cache-Control`?: string = "no-cache",

  /**
   * Page continuation token is only used if a previous operation returned a partial result.
   * If a previous response contains a nextLink element, the value of the nextLink element will include a token parameter that specifies a starting point to use for subsequent calls.
   *
   */
  @query("$skiptoken")
  $skiptoken?: string,

  body: void,
): ManagementGroupListResult | Azure.ResourceManager.CommonTypes.ErrorResponse;

/**
 * override for EntitiesOperationGroup.list
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op entitiesOperationGroupList(
  ...ApiVersionParameter,
  scope: SubscriptionActionScope,
  ...Azure.ResourceManager.Legacy.Provider,

  /**
   * Page continuation token is only used if a previous operation returned a partial result.
   * If a previous response contains a nextLink element, the value of the nextLink element will include a token parameter that specifies a starting point to use for subsequent calls.
   *
   */
  @query("$skiptoken")
  $skiptoken?: string,

  /**
   * Number of entities to skip over when retrieving results. Passing this in will override $skipToken.
   */
  @query("$skip")
  $skip?: int32,

  /**
   * Number of elements to return when retrieving results. Passing this in will override $skipToken.
   */
  @query("$top")
  $top?: int32,

  /**
   * This parameter specifies the fields to include in the response. Can include any combination of Name,DisplayName,Type,ParentDisplayNameChain,ParentChain, e.g. '$select=Name,DisplayName,Type,ParentDisplayNameChain,ParentNameChain'. When specified the $select parameter can override select in $skipToken.
   */
  @query("$select")
  $select?: string,

  /**
   * The $search parameter is used in conjunction with the $filter parameter to return three different outputs depending on the parameter passed in.
   * With $search=AllowedParents the API will return the entity info of all groups that the requested entity will be able to reparent to as determined by the user's permissions.
   * With $search=AllowedChildren the API will return the entity info of all entities that can be added as children of the requested entity.
   * With $search=ParentAndFirstLevelChildren the API will return the parent and  first level of children that the user has either direct access to or indirect access via one of their descendants.
   * With $search=ParentOnly the API will return only the group if the user has access to at least one of the descendants of the group.
   * With $search=ChildrenOnly the API will return only the first level of children of the group entity info specified in $filter.  The user must have direct access to the children entities or one of it's descendants for it to show up in the results.
   */
  @query("$search")
  $search?: EntitySearchType,

  /**
   * The filter parameter allows you to filter on the the name or display name fields. You can check for equality on the name field (e.g. name eq '{entityName}')  and you can check for substrings on either the name or display name fields(e.g. contains(name, '{substringToSearch}'), contains(displayName, '{substringToSearch')). Note that the '{entityName}' and '{substringToSearch}' fields are checked case insensitively.
   */
  @query("$filter")
  $filter?: string,

  /**
   * The view parameter allows clients to filter the type of data that is returned by the getEntities call.
   */
  @query("$view")
  $view?: EntityViewParameterType,

  /**
   * A filter which allows the get entities call to focus on a particular group (i.e. "$filter=name eq 'groupName'")
   */
  @query("groupName")
  groupName?: string,

  /**
   * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @header("Cache-Control")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("no-cache")
  `Cache-Control`?: string = "no-cache",

  body: void,
): EntityListResult | Azure.ResourceManager.CommonTypes.ErrorResponse;

/**
 * override for ManagementGroups.get
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op managementGroupsGet(
  ...ApiVersionParameter,
  extensionProvider: "Microsoft.Management",
  groupId: string,

  /**
   * The $expand=children query string parameter allows clients to request inclusion of children in the response payload.  $expand=path includes the path from the root group to the current group.  $expand=ancestors includes the ancestor Ids of the current group.
   */
  @query("$expand")
  $expand?: ManagementGroupExpandType,

  /**
   * The $recurse=true query string parameter allows clients to request inclusion of entire hierarchy in the response payload. Note that  $expand=children must be passed up if $recurse is set to true.
   */
  @query("$recurse")
  $recurse?: boolean,

  /**
   * A filter which allows the exclusion of subscriptions from results (i.e. '$filter=children.childType ne Subscription')
   */
  @query("$filter")
  $filter?: string,

  /**
   * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @header("Cache-Control")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("no-cache")
  `Cache-Control`?: string = "no-cache",
): Azure.ResourceManager.ArmResponse<Microsoft.Management.ManagementGroup> | Azure.ResourceManager.CommonTypes.ErrorResponse;

/**
 * override for ManagementGroups.createOrUpdate
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op managementGroupsCreateOrUpdate(
  ...ApiVersionParameter,
  extensionProvider: "Microsoft.Management",
  groupId: string,

  /**
   * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @header("Cache-Control")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("no-cache")
  `Cache-Control`?: string = "no-cache",

  resource: CreateManagementGroupRequest,
): ArmResourceUpdatedResponse<ManagementGroup> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ManagementGroup>> & {
  @bodyRoot
  _: AzureAsyncOperationResults;
});

/**
 * override for ManagementGroups.update
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op managementGroupsUpdate(
  ...ApiVersionParameter,
  extensionProvider: "Microsoft.Management",
  groupId: string,

  /**
   * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @header("Cache-Control")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("no-cache")
  `Cache-Control`?: string = "no-cache",

  properties: PatchManagementGroupRequest,
): Azure.ResourceManager.ArmResponse<Microsoft.Management.ManagementGroup> | Azure.ResourceManager.CommonTypes.ErrorResponse;

/**
 * override for ManagementGroups.delete
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op managementGroupsDelete(
  ...ApiVersionParameter,
  extensionProvider: "Microsoft.Management",
  groupId: string,

  /**
   * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  @header("Cache-Control")
  @Azure.ClientGenerator.Core.Legacy.clientDefaultValue("no-cache")
  `Cache-Control`?: string = "no-cache",
): (ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders &
  Azure.Core.Foundations.RetryAfterHeader> & {
  @bodyRoot
  _: AzureAsyncOperationResults;
}) | ArmDeletedNoContentResponse;

@@override(SubscriptionUnderManagementGroups.getSubscription,
  getSubscriptionCustomized,
  "javascript"
);
@@override(SubscriptionUnderManagementGroups.create,
  putSubscriptionCustomized,
  "javascript"
);
@@override(SubscriptionUnderManagementGroups.delete,
  deleteSubscriptionCustomized,
  "javascript"
);
@@override(ManagementGroupsOperationGroup.list,
  managementGroupsOperationGroupList,
  "javascript"
);
@@override(EntitiesOperationGroup.list,
  entitiesOperationGroupList,
  "javascript"
);
@@override(ManagementGroups.get, managementGroupsGet, "javascript");
@@override(ManagementGroups.createOrUpdate,
  managementGroupsCreateOrUpdate,
  "javascript"
);
@@override(ManagementGroups.update, managementGroupsUpdate, "javascript");
@@override(ManagementGroups.delete, managementGroupsDelete, "javascript");
