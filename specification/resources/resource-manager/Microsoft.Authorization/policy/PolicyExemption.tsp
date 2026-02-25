import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Authorization;
/**
 * The policy exemption.
 */
// Preview-only resource type: added in the preview API version.
@added(Versions.v2025_12_01_preview)
model PolicyExemption
  is Azure.ResourceManager.ExtensionResource<PolicyExemptionProperties> {
  ...ResourceNameParameter<
    Resource = PolicyExemption,
    KeyName = "policyExemptionName",
    SegmentName = "policyExemptions",
    NamePattern = "^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$"
  >;
}

alias PolicyExemptionListParameters = {
  /**
   * The filter to apply on the operation. Valid values for $filter are: 'atScope()', 'atExactScope()', 'excludeExpired()' or 'policyAssignmentId eq '{value}''. If $filter is not provided, no filtering is performed. If $filter is not provided, the unfiltered list includes all policy exemptions associated with the scope, including those that apply directly or apply from containing scopes. If $filter=atScope() is provided, the returned list only includes all policy exemptions that apply to the scope, which is everything in the unfiltered list except those applied to sub scopes contained within the given scope. If $filter=atExactScope() is provided, the returned list only includes all policy exemptions that at the given scope. If $filter=excludeExpired() is provided, the returned list only includes all policy exemptions that either haven't expired or didn't set expiration date. If $filter=policyAssignmentId eq '{value}' is provided. the returned list only includes all policy exemptions that are associated with the give policyAssignmentId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-skip-url-encoding is required on $filter to match legacy swagger"
  @extension("x-ms-skip-url-encoding", true)
  @query("$filter")
  $filter?: string;
};

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
@added(Versions.v2025_12_01_preview)
interface PolicyExemptionGenericOps
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
        ...Extension.ExtensionProviderNamespace<PolicyExemption>,
      },
      {
        ...Extension.ExtensionProviderNamespace<PolicyExemption>,
        ...KeysOf<PolicyExemption>,
      }
    > {}

@added(Versions.v2025_12_01_preview)
@armResourceOperations
interface PolicyExemptions {
  /**
   * This operation retrieves a single policy exemption, given its name and the scope it was created at.
   */
  @summary("Retrieves a policy exemption.")
  get is Extension.Read<Extension.ScopeParameter, PolicyExemption>;

  /**
   *  This operation creates or updates a policy exemption with the given scope and name. Policy exemptions apply to all resources contained within their scope. For example, when you create a policy exemption at resource group scope for a policy assignment at the same or above level, the exemption exempts to all applicable resources in the resource group.
   */
  @summary("Creates or updates a policy exemption.")
  createOrUpdate is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    PolicyExemption
  >;

  /**
   *  This operation updates a policy exemption with the given scope and name.
   */
  @summary("Updates a policy exemption.")
  @patch(#{ implicitOptionality: false })
  update is Extension.CustomPatchSync<
    Extension.ScopeParameter,
    PolicyExemption,
    PatchModel = PolicyExemptionUpdate
  >;

  /**
   * This operation deletes a policy exemption, given its name and the scope it was created in. The scope of a policy exemption is the part of its ID preceding '/providers/Microsoft.Authorization/policyExemptions/{policyExemptionName}'.
   */
  @summary("Deletes a policy exemption.")
  delete is Extension.DeleteSync<Extension.ScopeParameter, PolicyExemption>;

  /**
   * This operation retrieves the list of all policy exemptions associated with the given resource group in the given subscription that match the optional given $filter. Valid values for $filter are: 'atScope()', 'atExactScope()', 'excludeExpired()' or 'policyAssignmentId eq '{value}''. If $filter is not provided, the unfiltered list includes all policy exemptions associated with the resource group, including those that apply directly or apply from containing scopes, as well as any applied to resources contained within the resource group.
   */
  @summary("Retrieves all policy exemptions that apply to a resource group.")
  listForResourceGroup is Extension.ListByTarget<
    Extension.ResourceGroup,
    PolicyExemption,
    Parameters = PolicyExemptionListParameters
  >;

  /**
   * This operation retrieves the list of all policy exemptions applicable to the management group that match the given $filter. Valid values for $filter are: 'atScope()', 'atExactScope()', 'excludeExpired()' or 'policyAssignmentId eq '{value}''. If $filter=atScope() is provided, the returned list includes all policy exemptions that are assigned to the management group or the management group's ancestors.
   */
  @summary("Retrieves all policy exemptions that apply to a management group.")
  listForManagementGroup is Extension.ListByTarget<
    Extension.ManagementGroup<"managementGroupId">,
    PolicyExemption,
    Parameters = PolicyExemptionListParameters
  >;

  /**
   * This operation retrieves the list of all policy exemptions associated with the given subscription that match the optional given $filter. Valid values for $filter are: 'atScope()', 'atExactScope()', 'excludeExpired()' or 'policyAssignmentId eq '{value}''. If $filter is not provided, the unfiltered list includes all policy exemptions associated with the subscription, including those that apply directly or from management groups that contain the given subscription, as well as any applied to objects contained within the subscription.
   */
  @summary("Retrieves all policy exemptions that apply to a subscription.")
  list is Extension.ListByTarget<
    Extension.Subscription,
    PolicyExemption,
    Parameters = PolicyExemptionListParameters
  >;

  /**
   * This operation retrieves the list of all policy exemptions associated with the specified resource in the given resource group and subscription that match the optional given $filter. Valid values for $filter are: 'atScope()', 'atExactScope()', 'excludeExpired()' or 'policyAssignmentId eq '{value}''. If $filter is not provided, the unfiltered list includes all policy exemptions associated with the resource, including those that apply directly or from all containing scopes, as well as any applied to resources contained within the resource. Three parameters plus the resource name are used to identify a specific resource. If the resource is not part of a parent resource (the more common case), the parent resource path should not be provided (or provided as ''). For example a web app could be specified as ({resourceProviderNamespace} == 'Microsoft.Web', {parentResourcePath} == '', {resourceType} == 'sites', {resourceName} == 'MyWebApp'). If the resource is part of a parent resource, then all parameters should be provided. For example a virtual machine DNS name could be specified as ({resourceProviderNamespace} == 'Microsoft.Compute', {parentResourcePath} == 'virtualMachines/MyVirtualMachine', {resourceType} == 'domainNames', {resourceName} == 'MyComputerName'). A convenient alternative to providing the namespace and type name separately is to provide both in the {resourceType} parameter, format: ({resourceProviderNamespace} == '', {parentResourcePath} == '', {resourceType} == 'Microsoft.Web/sites', {resourceName} == 'MyWebApp').
   */
  @summary("Retrieves all policy exemptions that apply to a resource.")
  @get
  listForResource is PolicyExemptionGenericOps.List<
    PolicyExemption,
    PolicyExemptionListParameters
  >;
}

@@doc(PolicyExemption.name, "The name of the policy exemption to get.");
@@doc(PolicyExemption.properties, "Properties for the policy exemption.");
@@doc(PolicyExemptions.createOrUpdate::parameters.resource,
  "Parameters for the policy exemption."
);
@@doc(PolicyExemptions.update::parameters.properties,
  "Parameters for policy exemption patch request."
);
