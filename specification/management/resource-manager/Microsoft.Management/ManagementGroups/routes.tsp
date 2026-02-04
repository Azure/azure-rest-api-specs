// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Management;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ManagementGroupsOperationGroup {
  /**
   * List management groups for the authenticated user.
   *
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @autoRoute
  @get
  @list
  @action("managementGroups")
  list is ArmProviderActionSync<
    Response = ManagementGroupListResult,
    Parameters = {
      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header("Cache-Control")
      `Cache-Control`?: string = "no-cache";

      /**
       * Page continuation token is only used if a previous operation returned a partial result.
       * If a previous response contains a nextLink element, the value of the nextLink element will include a token parameter that specifies a starting point to use for subsequent calls.
       *
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
}

/**
 * Checks if the specified management group name is valid and unique
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@autoRoute
op checkNameAvailability is ArmProviderActionSync<
  Request = CheckNameAvailabilityRequest,
  Response = CheckNameAvailabilityResult
>;
/**
 * Starts backfilling subscriptions for the Tenant.
 */
@autoRoute
op startTenantBackfill is ArmProviderActionSync<Response = TenantBackfillStatusResult>;
/**
 * Gets tenant backfill status
 */
@autoRoute
op tenantBackfillStatus is ArmProviderActionSync<Response = TenantBackfillStatusResult>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface EntitiesOperationGroup {
  /**
   * List all entities (Management Groups, Subscriptions, etc.) for the authenticated user.
   *
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @autoRoute
  @list
  @action("getEntities")
  list is ArmProviderActionSync<
    Response = EntityListResult,
    Parameters = {
      /**
       * Page continuation token is only used if a previous operation returned a partial result.
       * If a previous response contains a nextLink element, the value of the nextLink element will include a token parameter that specifies a starting point to use for subsequent calls.
       *
       */
      @query("$skiptoken")
      $skiptoken?: string;

      /**
       * Number of entities to skip over when retrieving results. Passing this in will override $skipToken.
       */
      @query("$skip")
      $skip?: int32;

      /**
       * Number of elements to return when retrieving results. Passing this in will override $skipToken.
       */
      @query("$top")
      $top?: int32;

      /**
       * This parameter specifies the fields to include in the response. Can include any combination of Name,DisplayName,Type,ParentDisplayNameChain,ParentChain, e.g. '$select=Name,DisplayName,Type,ParentDisplayNameChain,ParentNameChain'. When specified the $select parameter can override select in $skipToken.
       */
      @query("$select")
      $select?: string;

      /**
       * The $search parameter is used in conjunction with the $filter parameter to return three different outputs depending on the parameter passed in.
       * With $search=AllowedParents the API will return the entity info of all groups that the requested entity will be able to reparent to as determined by the user's permissions.
       * With $search=AllowedChildren the API will return the entity info of all entities that can be added as children of the requested entity.
       * With $search=ParentAndFirstLevelChildren the API will return the parent and  first level of children that the user has either direct access to or indirect access via one of their descendants.
       * With $search=ParentOnly the API will return only the group if the user has access to at least one of the descendants of the group.
       * With $search=ChildrenOnly the API will return only the first level of children of the group entity info specified in $filter.  The user must have direct access to the children entities or one of it's descendants for it to show up in the results.
       */
      @query("$search")
      $search?: EntitySearchType;

      /**
       * The filter parameter allows you to filter on the the name or display name fields. You can check for equality on the name field (e.g. name eq '{entityName}')  and you can check for substrings on either the name or display name fields(e.g. contains(name, '{substringToSearch}'), contains(displayName, '{substringToSearch')). Note that the '{entityName}' and '{substringToSearch}' fields are checked case insensitively.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The view parameter allows clients to filter the type of data that is returned by the getEntities call.
       */
      @query("$view")
      $view?: EntityViewParameterType;

      /**
       * A filter which allows the get entities call to focus on a particular group (i.e. "$filter=name eq 'groupName'")
       */
      @query("groupName")
      groupName?: string;

      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header("Cache-Control")
      `Cache-Control`?: string = "no-cache";
    }
  >;
}
