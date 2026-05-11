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
 * The policy enrollment.
 */
// Preview-only resource type: added in the preview API version.
@added(Versions.v2026_01_01_preview)
model PolicyEnrollment
  is Azure.ResourceManager.ExtensionResource<PolicyEnrollmentProperties> {
  ...ResourceNameParameter<
    Resource = PolicyEnrollment,
    KeyName = "policyEnrollmentName",
    SegmentName = "policyEnrollments",
    NamePattern = "^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$"
  >;

  /**
   * The ETag for the policy enrollment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  eTag?: Azure.Core.eTag;
}

alias PolicyEnrollmentListParameters = {
  /**
   * The filter to apply on the operation. Valid values for $filter are: 'atScope()' or 'atExactScope()'. If $filter is not provided, no filtering is performed. If $filter is not provided, the unfiltered list includes all policy enrollments associated with the scope, including those that apply directly or from containing scopes. If $filter=atScope() is provided, the returned list includes all policy enrollments that apply to the scope, which is everything in the unfiltered list except those applied to sub-scopes contained within the given scope. If $filter=atExactScope() is provided, the returned list only includes all policy enrollments that apply at the given scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-skip-url-encoding is required on $filter to match legacy swagger"
  @extension("x-ms-skip-url-encoding", true)
  @query("$filter")
  $filter?: string;
};

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
@added(Versions.v2026_01_01_preview)
interface PolicyEnrollmentGenericOps
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
        ...Extension.ExtensionProviderNamespace<PolicyEnrollment>,
      },
      {
        ...Extension.ExtensionProviderNamespace<PolicyEnrollment>,
        ...KeysOf<PolicyEnrollment>,
      }
    > {}

@added(Versions.v2026_01_01_preview)
@armResourceOperations
interface PolicyEnrollments {
  /**
   * This operation retrieves a single policy enrollment, given its name and the scope it was created at.
   */
  @summary("Retrieves a policy enrollment.")
  get is Extension.Read<Extension.ScopeParameter, PolicyEnrollment>;

  /**
   * This operation creates or updates a policy enrollment with the given scope and name. Policy enrollments apply to all resources contained within their scope. For example, when you create a policy enrollment at resource group scope for a policy assignment at the same or above level, the enrollment applies to all applicable resources in the resource group.
   */
  @summary("Creates or updates a policy enrollment.")
  createOrUpdate is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    PolicyEnrollment
  >;

  /**
   * This operation updates a policy enrollment with the given scope and name.
   */
  @summary("Updates a policy enrollment.")
  @patch(#{ implicitOptionality: false })
  update is Extension.CustomPatchSync<
    Extension.ScopeParameter,
    PolicyEnrollment,
    PatchModel = PolicyEnrollmentUpdate
  >;

  /**
   * This operation deletes a policy enrollment, given its name and the scope it was created in. The scope of a policy enrollment is the part of its ID preceding '/providers/Microsoft.Authorization/policyEnrollments/{policyEnrollmentName}'.
   */
  @summary("Deletes a policy enrollment.")
  delete is Extension.DeleteSync<Extension.ScopeParameter, PolicyEnrollment>;

  /**
   * This operation retrieves the list of all policy enrollments associated with the given resource group in the given subscription that match the optional given $filter. Valid values for $filter are: 'atScope()' or 'atExactScope()'. If $filter is not provided, the unfiltered list includes all policy enrollments associated with the resource group, including those that apply directly or apply from containing scopes, as well as any applied to resources contained within the resource group.
   */
  @summary("Retrieves all policy enrollments that apply to a resource group.")
  listForResourceGroup is Extension.ListByTarget<
    Extension.ResourceGroup,
    PolicyEnrollment,
    Parameters = PolicyEnrollmentListParameters
  >;

  /**
   * This operation retrieves the list of all policy enrollments applicable to the management group that match the given $filter. Valid values for $filter are: 'atScope()' or 'atExactScope()'. If $filter=atScope() is provided, the returned list includes all policy enrollments that are assigned to the management group or the management group's ancestors.
   */
  @summary("Retrieves all policy enrollments that apply to a management group.")
  listForManagementGroup is Extension.ListByTarget<
    Extension.ManagementGroup<"managementGroupId">,
    PolicyEnrollment,
    Parameters = PolicyEnrollmentListParameters
  >;

  /**
   * This operation retrieves the list of all policy enrollments associated with the given subscription that match the optional given $filter. Valid values for $filter are: 'atScope()' or 'atExactScope()'. If $filter is not provided, the unfiltered list includes all policy enrollments associated with the subscription, including those that apply directly or from management groups that contain the given subscription, as well as any applied to objects contained within the subscription.
   */
  @summary("Retrieves all policy enrollments that apply to a subscription.")
  list is Extension.ListByTarget<
    Extension.Subscription,
    PolicyEnrollment,
    Parameters = PolicyEnrollmentListParameters
  >;

  /**
   * This operation retrieves the list of all policy enrollments associated with the specified resource in the given resource group and subscription that match the optional given $filter. Valid values for $filter are: 'atScope()' or 'atExactScope()'. If $filter is not provided, the unfiltered list includes all policy enrollments associated with the resource, including those that apply directly or from all containing scopes, as well as any applied to resources contained within the resource. Three parameters plus the resource name are used to identify a specific resource. If the resource is not part of a parent resource (the more common case), the parent resource path should not be provided (or provided as ''). For example a web app could be specified as ({resourceProviderNamespace} == 'Microsoft.Web', {parentResourcePath} == '', {resourceType} == 'sites', {resourceName} == 'MyWebApp'). If the resource is part of a parent resource, then all parameters should be provided. For example a virtual machine DNS name could be specified as ({resourceProviderNamespace} == 'Microsoft.Compute', {parentResourcePath} == 'virtualMachines/MyVirtualMachine', {resourceType} == 'domainNames', {resourceName} == 'MyComputerName'). A convenient alternative to providing the namespace and type name separately is to provide both in the {resourceType} parameter, format: ({resourceProviderNamespace} == '', {parentResourcePath} == '', {resourceType} == 'Microsoft.Web/sites', {resourceName} == 'MyWebApp').
   */
  @summary("Retrieves all policy enrollments that apply to a resource.")
  @get
  listForResource is PolicyEnrollmentGenericOps.List<
    PolicyEnrollment,
    PolicyEnrollmentListParameters
  >;
}

@@doc(PolicyEnrollment.name, "The name of the policy enrollment.");
@@doc(PolicyEnrollment.properties, "The properties of the policy enrollment.");
@@doc(PolicyEnrollments.createOrUpdate::parameters.resource,
  "The policy enrollment resource to create or replace."
);
@@doc(PolicyEnrollments.update::parameters.properties,
  "The properties to update in the policy enrollment."
);
