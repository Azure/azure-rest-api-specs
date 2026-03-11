import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Authorization;
/**
 * The policy assignment.
 */
model PolicyAssignment
  is Azure.ResourceManager.ExtensionResource<PolicyAssignmentProperties> {
  ...ResourceNameParameter<
    Resource = PolicyAssignment,
    KeyName = "policyAssignmentName",
    SegmentName = "policyAssignments",
    NamePattern = "^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$"
  >;

  /**
   * The location of the policy assignment. Only required when utilizing managed identity.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  location?: string;

  /**
   * The managed identity associated with the policy assignment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Identity;
}

alias PolicyAssignmentListParameters = {
  /**
   * The filter to apply on the operation. Valid values for $filter are: 'atScope()', 'atExactScope()' or 'policyDefinitionId eq '{value}''. If $filter is not provided, no filtering is performed. If $filter=atScope() is provided, the returned list only includes all policy assignments that apply to the scope, which is everything in the unfiltered list except those applied to sub scopes contained within the given scope. If $filter=atExactScope() is provided, the returned list only includes all policy assignments that at the given scope. If $filter=policyDefinitionId eq '{value}' is provided, the returned list includes all policy assignments of the policy definition whose id is {value}.
   */
  @query("$filter")
  $filter?: string;

  /**
   * Comma-separated list of additional properties to be included in the response. Supported values are 'LatestDefinitionVersion, EffectiveDefinitionVersion'.
   */
  @query("$expand")
  $expand?: string;

  /**
   * Maximum number of records to return. When the $top filter is not provided, it will return 500 records.
   */
  @maxValue(1000)
  @minValue(1)
  @query("$top")
  $top?: int32;
};

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
interface PolicyAssignmentGenericOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /**
         * The namespace of the resource provider. For example, the namespace of a virtual machine is Microsoft.Compute (from Microsoft.Compute/virtualMachines)
         */
        @path
        @segment("providers")
        resourceProviderNamespace: string,

        /**
         * The parent resource path. Use empty string if there is none.
         */
        @path(#{ allowReserved: true })
        parentResourcePath: string,

        /**
         * The resource type name. For example the type name of a web app is 'sites' (from Microsoft.Web/sites).
         */
        @path(#{ allowReserved: true })
        resourceType: string,

        /**
         * The name of the resource.
         */
        @path
        @pattern("^.+$")
        resourceName: string,

        ...ApiVersionParameter,
      },
      {
        ...Extension.ExtensionProviderNamespace<PolicyAssignment>,
      },
      {
        ...Extension.ExtensionProviderNamespace<PolicyAssignment>,
        ...KeysOf<PolicyAssignment>,
      }
    > {}

@armResourceOperations
interface PolicyAssignments {
  /**
   * This operation retrieves a single policy assignment, given its name and the scope it was created at.
   */
  get is Extension.Read<
    Extension.ScopeParameter,
    PolicyAssignment,
    Parameters = {
      /**
       * Comma-separated list of additional properties to be included in the response. Supported values are 'LatestDefinitionVersion, EffectiveDefinitionVersion'.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   *  This operation creates or updates a policy assignment with the given scope and name. Policy assignments apply to all resources contained within their scope. For example, when you assign a policy at resource group scope, that policy applies to all resources in the group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    PolicyAssignment,
    Response = ArmResourceCreatedSyncResponse<PolicyAssignment>
  >;

  /**
   *  This operation updates a policy assignment with the given scope and name. Policy assignments apply to all resources contained within their scope. For example, when you assign a policy at resource group scope, that policy applies to all resources in the group.
   */
  @patch(#{ implicitOptionality: false })
  update is Extension.CustomPatchSync<
    Extension.ScopeParameter,
    PolicyAssignment,
    PatchModel = PolicyAssignmentUpdate
  >;

  /**
   * This operation deletes a policy assignment, given its name and the scope it was created in. The scope of a policy assignment is the part of its ID preceding '/providers/Microsoft.Authorization/policyAssignments/{policyAssignmentName}'.
   */
  delete is Extension.DeleteSync<
    Extension.ScopeParameter,
    PolicyAssignment,
    Response = ArmResponse<PolicyAssignment> | ArmDeletedNoContentResponse
  >;

  /**
   * This operation retrieves the list of all policy assignments associated with the given resource group in the given subscription that match the optional given $filter. Valid values for $filter are: 'atScope()', 'atExactScope()' or 'policyDefinitionId eq '{value}''. If $filter is not provided, the unfiltered list includes all policy assignments associated with the resource group, including those that apply directly or apply from containing scopes, as well as any applied to resources contained within the resource group. If $filter=atScope() is provided, the returned list includes all policy assignments that apply to the resource group, which is everything in the unfiltered list except those applied to resources contained within the resource group. If $filter=atExactScope() is provided, the returned list only includes all policy assignments that at the resource group. If $filter=policyDefinitionId eq '{value}' is provided, the returned list includes all policy assignments of the policy definition whose id is {value} that apply to the resource group.
   */
  listForResourceGroup is Extension.ListByTarget<
    Extension.ResourceGroup,
    PolicyAssignment,
    Parameters = PolicyAssignmentListParameters
  >;

  /**
   * This operation retrieves the list of all policy assignments applicable to the management group that match the given $filter. Valid values for $filter are: 'atScope()', 'atExactScope()' or 'policyDefinitionId eq '{value}''. If $filter=atScope() is provided, the returned list includes all policy assignments that are assigned to the management group or the management group's ancestors. If $filter=atExactScope() is provided, the returned list only includes all policy assignments that at the management group. If $filter=policyDefinitionId eq '{value}' is provided, the returned list includes all policy assignments of the policy definition whose id is {value} that apply to the management group.
   */
  @summary("Retrieves all policy assignments that apply to a management group.")
  listForManagementGroup is Extension.ListByTarget<
    Extension.ManagementGroup<"managementGroupId">,
    PolicyAssignment,
    Parameters = PolicyAssignmentListParameters
  >;

  /**
   * This operation retrieves the list of all policy assignments associated with the given subscription that match the optional given $filter. Valid values for $filter are: 'atScope()', 'atExactScope()' or 'policyDefinitionId eq '{value}''. If $filter is not provided, the unfiltered list includes all policy assignments associated with the subscription, including those that apply directly or from management groups that contain the given subscription, as well as any applied to objects contained within the subscription. If $filter=atScope() is provided, the returned list includes all policy assignments that apply to the subscription, which is everything in the unfiltered list except those applied to objects contained within the subscription. If $filter=atExactScope() is provided, the returned list only includes all policy assignments that at the subscription. If $filter=policyDefinitionId eq '{value}' is provided, the returned list includes all policy assignments of the policy definition whose id is {value}.
   */
  @summary("Retrieves all policy assignments that apply to a subscription.")
  list is Extension.ListByTarget<
    Extension.Subscription,
    PolicyAssignment,
    Parameters = PolicyAssignmentListParameters
  >;

  /**
   * This operation retrieves the list of all policy assignments associated with the specified resource in the given resource group and subscription that match the optional given $filter. Valid values for $filter are: 'atScope()', 'atExactScope()' or 'policyDefinitionId eq '{value}''. If $filter is not provided, the unfiltered list includes all policy assignments associated with the resource, including those that apply directly or from all containing scopes, as well as any applied to resources contained within the resource. If $filter=atScope() is provided, the returned list includes all policy assignments that apply to the resource, which is everything in the unfiltered list except those applied to resources contained within the resource. If $filter=atExactScope() is provided, the returned list only includes all policy assignments that at the resource level. If $filter=policyDefinitionId eq '{value}' is provided, the returned list includes all policy assignments of the policy definition whose id is {value} that apply to the resource. Three parameters plus the resource name are used to identify a specific resource. If the resource is not part of a parent resource (the more common case), the parent resource path should not be provided (or provided as ''). For example a web app could be specified as ({resourceProviderNamespace} == 'Microsoft.Web', {parentResourcePath} == '', {resourceType} == 'sites', {resourceName} == 'MyWebApp'). If the resource is part of a parent resource, then all parameters should be provided. For example a virtual machine DNS name could be specified as ({resourceProviderNamespace} == 'Microsoft.Compute', {parentResourcePath} == 'virtualMachines/MyVirtualMachine', {resourceType} == 'domainNames', {resourceName} == 'MyComputerName'). A convenient alternative to providing the namespace and type name separately is to provide both in the {resourceType} parameter, format: ({resourceProviderNamespace} == '', {parentResourcePath} == '', {resourceType} == 'Microsoft.Web/sites', {resourceName} == 'MyWebApp').
   */
  @summary("Retrieves all policy assignments that apply to a resource.")
  @get
  listForResource is PolicyAssignmentGenericOps.List<
    PolicyAssignment,
    PolicyAssignmentListParameters
  >;
}

@@doc(PolicyAssignment.name, "The name of the policy assignment to get.");
@@doc(PolicyAssignment.properties, "Properties for the policy assignment.");
@@doc(PolicyAssignments.create::parameters.resource,
  "Parameters for the policy assignment."
);
@@doc(PolicyAssignments.update::parameters.properties,
  "Parameters for policy assignment patch request."
);
