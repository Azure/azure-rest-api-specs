// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Resources;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ProvidersOperationGroup {
  /** Gets all resource providers for the tenant. */
  @route("/providers")
  @list
  @get
  listAtTenantScope(
    ...ApiVersionParameter,

    /** The properties to include in the results. */
    @query("$expand")
    $expand?: string,
  ): ArmResponse<ProviderListResult> | CloudError;

  /**
   * Unregisters a subscription from a resource provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Providers_Unregister")
  @route("/subscriptions/{subscriptionId}/providers/{resourceProviderNamespace}/unregister")
  @post
  unregister(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** The namespace of the resource provider to unregister. */
    @path
    resourceProviderNamespace: string,
  ): ArmResponse<Provider> | CloudError;
  /**
   * Registers a management group with a resource provider. Use this operation to register a resource provider with resource types that can be deployed at the management group scope. It does not recursively register subscriptions within the management group. Instead, you must register subscriptions individually.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Providers_RegisterAtManagementGroupScope")
  @route("/providers/Microsoft.Management/managementGroups/{groupId}/providers/{resourceProviderNamespace}/register")
  @post
  registerAtManagementGroupScope(
    ...ApiVersionParameter,

    /** The management group ID. */
    /** The namespace of the resource provider to register. */
    @path
    resourceProviderNamespace: string,

    @path
    @minLength(1)
    @maxLength(90)
    groupId: string,
  ): OkResponse | CloudError;
  /**
   * Get the provider permissions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Providers_ProviderPermissions")
  @route("/subscriptions/{subscriptionId}/providers/{resourceProviderNamespace}/providerPermissions")
  @get
  providerPermissions(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** The namespace of the resource provider. */
    @path
    resourceProviderNamespace: string,
  ): ArmResponse<ProviderPermissionListResult> | CloudError;
  /**
   * Registers a subscription with a resource provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Providers_Register")
  @route("/subscriptions/{subscriptionId}/providers/{resourceProviderNamespace}/register")
  @post
  register(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** The namespace of the resource provider to register. */
    @path
    resourceProviderNamespace: string,

    /** The third party consent for S2S. */
    @body
    properties?: ProviderRegistrationRequest,
  ): ArmResponse<Provider> | CloudError;
  /**
   * Gets all resource providers for a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Providers_List")
  @route("/subscriptions/{subscriptionId}/providers")
  @list
  @get
  list(
    ...ApiVersionParameter,

    /**
     * The properties to include in the results. For example, use &$expand=metadata in the query string to retrieve resource provider metadata. To include property aliases in response, use $expand=resourceTypes/aliases.
     */
    @query("$expand")
    $expand?: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<ProviderListResult> | CloudError;

  /**
   * Gets the specified resource provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Providers_Get")
  @route("/subscriptions/{subscriptionId}/providers/{resourceProviderNamespace}")
  @get
  get(
    ...ApiVersionParameter,

    /**
     * The $expand query parameter. For example, to include property aliases in response, use $expand=resourceTypes/aliases.
     */
    @query("$expand")
    $expand?: string,

    /**
     * The namespace of the resource provider.
     */
    @path
    resourceProviderNamespace: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<Provider> | CloudError;

  /**
   * Gets the specified resource provider at the tenant level.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Providers_GetAtTenantScope")
  @route("/providers/{resourceProviderNamespace}")
  @get
  getAtTenantScope(
    ...ApiVersionParameter,

    /**
     * The $expand query parameter. For example, to include property aliases in response, use $expand=resourceTypes/aliases.
     */
    @query("$expand")
    $expand?: string,

    /**
     * The namespace of the resource provider.
     */
    @path
    resourceProviderNamespace: string,
  ): ArmResponse<Provider> | CloudError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ProviderResourceTypesOperationGroup {
  /**
   * List the resource types for a specified resource provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProviderResourceTypes_List")
  @route("/subscriptions/{subscriptionId}/providers/{resourceProviderNamespace}/resourceTypes")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** The $expand query parameter. */
    @query("$expand")
    $expand?: string,

    /** The namespace of the resource provider. */
    @path
    resourceProviderNamespace: string,
  ): ArmResponse<ProviderResourceTypeListResult> | CloudError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ResourcesOperationGroup {
  /**
   * Get all the resources in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Resources_List")
  @route("/subscriptions/{subscriptionId}/resources")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** The filter to apply on the operation.<br><br>Filter comparison operators include `eq` (equals) and `ne` (not equals) and may be used with the following properties: `location`, `resourceType`, `name`, `resourceGroup`, `identity`, `identity/principalId`, `plan`, `plan/publisher`, `plan/product`, `plan/name`, `plan/version`, and `plan/promotionCode`.<br><br>For example, to filter by a resource type, use `$filter=resourceType eq 'Microsoft.Network/virtualNetworks'`<br><br><br>`substringof(value, property)` can  be used to filter for substrings of the following currently-supported properties: `name` and `resourceGroup`<br><br>For example, to get all resources with 'demo' anywhere in the resource name, use `$filter=substringof('demo', name)`<br><br>Multiple substring operations can also be combined using `and`/`or` operators.<br><br>Note that any truncated number of results queried via `$top` may also not be compatible when using a filter.<br><br><br>Resources can be filtered by tag names and values. For example, to filter for a tag name and value, use `$filter=tagName eq 'tag1' and tagValue eq 'Value1'`. Note that when resources are filtered by tag name and value, <b>the original tags for each resource will not be returned in the results.</b> Any list of additional properties queried via `$expand` may also not be compatible when filtering by tag names/values. <br><br>For tag names only, resources can be filtered by prefix using the following syntax: `$filter=startswith(tagName, 'depart')`. This query will return all resources with a tag name prefixed by the phrase `depart` (i.e.`department`, `departureDate`, `departureTime`, etc.)<br><br><br>Note that some properties can be combined when filtering resources, which include the following: `substringof() and/or resourceType`, `plan and plan/publisher and plan/name`, and `identity and identity/principalId`. */
    @query("$filter")
    $filter?: string,

    /** Comma-separated list of additional properties to be included in the response. Valid values include `createdTime`, `changedTime` and `provisioningState`. For example, `$expand=createdTime,changedTime`. */
    @query("$expand")
    $expand?: string,

    /** The number of recommendations per page if a paged version of this API is being used. */
    @query("$top")
    $top?: int32,
  ): ArmResponse<ResourceListResult> | CloudError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface TagsOperationGroup {
  /**
   * This operation allows deleting a value from the list of predefined values for an existing predefined tag name. The value being deleted must not be in use as a tag value for the given tag name for any resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Deletes a predefined tag value for a predefined tag name.")
  @operationId("Tags_DeleteValue")
  @route("/subscriptions/{subscriptionId}/tagNames/{tagName}/tagValues/{tagValue}")
  @delete
  deleteValue(
    ...ApiVersionParameter,

    /**
     * The name of the tag.
     */
    @path
    tagName: string,

    /**
     * The value of the tag to delete.
     */
    @path
    tagValue: string,

    ...SubscriptionIdParameter,
  ): OkResponse | CloudError;

  /**
   * This operation allows adding a value to the list of predefined values for an existing predefined tag name. A tag value can have a maximum of 256 characters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Creates a predefined value for a predefined tag name.")
  @operationId("Tags_CreateOrUpdateValue")
  @route("/subscriptions/{subscriptionId}/tagNames/{tagName}/tagValues/{tagValue}")
  @put
  createOrUpdateValue(
    ...ApiVersionParameter,

    /**
     * The name of the tag.
     */
    @path
    tagName: string,

    /**
     * The value of the tag to create.
     */
    @path
    tagValue: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<TagValue> | CloudError;

  /**
   * This operation allows adding a name to the list of predefined tag names for the given subscription. A tag name can have a maximum of 512 characters and is case-insensitive. Tag names cannot have the following prefixes which are reserved for Azure use: 'microsoft', 'azure', 'windows'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Creates a predefined tag name.")
  @operationId("Tags_CreateOrUpdate")
  @route("/subscriptions/{subscriptionId}/tagNames/{tagName}")
  @put
  createOrUpdate(
    ...ApiVersionParameter,

    /**
     * The name of the tag to create.
     */
    @path
    tagName: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<TagDetails> | CloudError;

  /**
   * This operation allows deleting a name from the list of predefined tag names for the given subscription. The name being deleted must not be in use as a tag name for any resource. All predefined values for the given name must have already been deleted.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Deletes a predefined tag name.")
  @operationId("Tags_Delete")
  @route("/subscriptions/{subscriptionId}/tagNames/{tagName}")
  @delete
  delete(
    ...ApiVersionParameter,

    /**
     * The name of the tag.
     */
    @path
    tagName: string,

    ...SubscriptionIdParameter,
  ): OkResponse | CloudError;

  /**
   * This operation performs a union of predefined tags, resource tags, resource group tags and subscription tags, and returns a summary of usage for each tag name and value under the given subscription. In case of a large number of tags, this operation may return a previously cached result.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets a summary of tag usage under the subscription.")
  @operationId("Tags_List")
  @route("/subscriptions/{subscriptionId}/tagNames")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
  ): ArmResponse<TagsListResult> | CloudError;
}
