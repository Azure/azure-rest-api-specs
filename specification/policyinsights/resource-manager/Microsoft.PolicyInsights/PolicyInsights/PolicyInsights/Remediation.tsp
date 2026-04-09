import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
namespace PolicyInsightsApi;
/**
 * The remediation definition.
 */
model Remediation
  is Azure.ResourceManager.ProxyResource<RemediationProperties> {
  ...ResourceNameParameter<
    Resource = Remediation,
    KeyName = "remediationName",
    SegmentName = "remediations",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface Remediations {
  /**
   * Gets an existing remediation at management group scope.
   */
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupId}/providers/Microsoft.PolicyInsights/remediations/{remediationName}")
  @get
  getAtManagementGroup(
    ...ApiVersionParameter,

    /**
     * The namespace for Microsoft Management RP; only "Microsoft.Management" is allowed.
     */
    @path
    managementGroupsNamespace: "Microsoft.Management",

    /**
     * Management group ID.
     */
    @path
    managementGroupId: string,

    /**
     * The name of the remediation.
     */
    @path
    remediationName: string,
  ): ArmResponse<Remediation> | ErrorResponse;

  /**
   * Creates or updates a remediation at management group scope.
   */
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupId}/providers/Microsoft.PolicyInsights/remediations/{remediationName}")
  @put
  createOrUpdateAtManagementGroup(
    ...ApiVersionParameter,

    /**
     * The namespace for Microsoft Management RP; only "Microsoft.Management" is allowed.
     */
    @path
    managementGroupsNamespace: "Microsoft.Management",

    /**
     * Management group ID.
     */
    @path
    managementGroupId: string,

    /**
     * The name of the remediation.
     */
    @path
    remediationName: string,

    /**
     * The remediation parameters.
     */
    @bodyRoot
    resource: Remediation,
  ): ArmResponse<Remediation> | (CreatedResponse &
    Body<Remediation>) | ErrorResponse;

  /**
   * Deletes an existing remediation at management group scope.
   */
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupId}/providers/Microsoft.PolicyInsights/remediations/{remediationName}")
  @delete
  deleteAtManagementGroup(
    ...ApiVersionParameter,

    /**
     * The namespace for Microsoft Management RP; only "Microsoft.Management" is allowed.
     */
    @path
    managementGroupsNamespace: "Microsoft.Management",

    /**
     * Management group ID.
     */
    @path
    managementGroupId: string,

    /**
     * The name of the remediation.
     */
    @path
    remediationName: string,
  ): ArmResponse<Remediation> | ArmDeletedNoContentResponse | ErrorResponse;

  /**
   * Gets all remediations for the management group.
   */
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupId}/providers/Microsoft.PolicyInsights/remediations")
  @list
  @get
  listForManagementGroup(
    ...ApiVersionParameter,

    /**
     * The namespace for Microsoft Management RP; only "Microsoft.Management" is allowed.
     */
    @path
    managementGroupsNamespace: "Microsoft.Management",

    /**
     * Management group ID.
     */
    @path
    managementGroupId: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @query("$filter")
    Filter?: string,
  ): ArmResponse<RemediationListResult> | ErrorResponse;
}
alias RemediationSubscriptionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.PolicyInsights";
  },
  {},
  {
    /** The name of the remediation. */
    @path
    @segment("remediations")
    @key
    remediationName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface RemediationSubscriptionOperations {
  /**
   * Gets an existing remediation at subscription scope.
   */
  getAtSubscription is RemediationSubscriptionOps.Read<
    Remediation,
    ErrorType = ErrorResponse
  >;

  /**
   * Creates or updates a remediation at subscription scope.
   */
  createOrUpdateAtSubscription is RemediationSubscriptionOps.CreateOrUpdateSync<
    Remediation,
    ErrorType = ErrorResponse
  >;

  /**
   * Deletes an existing remediation at subscription scope.
   */
  deleteAtSubscription is RemediationSubscriptionOps.DeleteSync<
    Remediation,
    Response = ArmResponse<Remediation> | ArmDeletedNoContentResponse,
    ErrorType = ErrorResponse
  >;

  /**
   * Gets all remediations for the subscription.
   */
  listForSubscription is RemediationSubscriptionOps.List<
    Remediation,
    Response = ArmResponse<RemediationListResult>,
    Parameters = {
      /**
       * Maximum number of records to return.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("$top")
      @minValue(0)
      Top?: int32;

      /**
       * OData filter expression.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("$filter")
      Filter?: string;
    },
    ErrorType = ErrorResponse
  >;

  /**
   * Gets all deployments for a remediation at subscription scope.
   */
  @list
  @action("listDeployments")
  listDeploymentsAtSubscription is RemediationSubscriptionOps.ActionSync<
    Remediation,
    void,
    ArmResponse<RemediationDeploymentsListResult>,
    Parameters = {
      /**
       * Maximum number of records to return.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("$top")
      @minValue(0)
      Top?: int32;
    },
    ErrorType = ErrorResponse
  >;

  /**
   * Cancels a remediation at subscription scope.
   */
  @action("cancel")
  cancelAtSubscription is RemediationSubscriptionOps.ActionSync<
    Remediation,
    void,
    ArmResponse<Remediation>,
    ErrorType = ErrorResponse
  >;
}
alias RemediationResourceGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    /** The name of the remediation. */
    @path
    @segment("remediations")
    @key
    remediationName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface RemediationResourceGroupOperations {
  /**
   * Gets an existing remediation at resource group scope.
   */
  getAtResourceGroup is RemediationResourceGroupOps.Read<
    Remediation,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Creates or updates a remediation at resource group scope.
   */
  createOrUpdateAtResourceGroup is RemediationResourceGroupOps.CreateOrUpdateSync<
    Remediation,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Deletes an existing remediation at resource group scope.
   */
  deleteAtResourceGroup is RemediationResourceGroupOps.DeleteSync<
    Remediation,
    Response = ArmResponse<Remediation> | ArmDeletedNoContentResponse,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets all remediations for the subscription.
   */
  listForResourceGroup is RemediationResourceGroupOps.List<
    Remediation,
    Response = ArmResponse<RemediationListResult>,
    Parameters = {
      /**
       * Maximum number of records to return.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("$top")
      @minValue(0)
      Top?: int32;

      /**
       * OData filter expression.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("$filter")
      Filter?: string;
    },
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets all deployments for a remediation at resource group scope.
   */
  @list
  @action("listDeployments")
  listDeploymentsAtResourceGroup is RemediationResourceGroupOps.ActionSync<
    Remediation,
    void,
    ArmResponse<RemediationDeploymentsListResult>,
    Parameters = {
      /**
       * Maximum number of records to return.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("$top")
      @minValue(0)
      Top?: int32;
    },
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Cancels a remediation at resource group scope.
   */
  @action("cancel")
  cancelAtResourceGroup is RemediationResourceGroupOps.ActionSync<
    Remediation,
    void,
    ArmResponse<Remediation>,
    OverrideErrorType = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface RemediationResourceOperations {
  /**
   * Gets an existing remediation at resource scope.
   */
  @route("/{+resourceId}/providers/Microsoft.PolicyInsights/remediations/{remediationName}")
  @get
  getAtResource(
    ...ApiVersionParameter,

    /**
     * Resource ID.
     */
    @path
    resourceId: string,

    /**
     * The name of the remediation.
     */
    @path
    remediationName: string,
  ): ArmResponse<Remediation> | ErrorResponse;

  /**
   * Creates or updates a remediation at resource scope.
   */
  @route("/{+resourceId}/providers/Microsoft.PolicyInsights/remediations/{remediationName}")
  @put
  createOrUpdateAtResource(
    ...ApiVersionParameter,

    /**
     * Resource ID.
     */
    @path
    resourceId: string,

    /**
     * The name of the remediation.
     */
    @path
    remediationName: string,

    /**
     * The remediation parameters.
     */
    @bodyRoot
    resource: Remediation,
  ): ArmResponse<Remediation> | (CreatedResponse &
    Body<Remediation>) | ErrorResponse;

  /**
   * Deletes an existing remediation at individual resource scope.
   */
  @route("/{+resourceId}/providers/Microsoft.PolicyInsights/remediations/{remediationName}")
  @delete
  deleteAtResource(
    ...ApiVersionParameter,

    /**
     * Resource ID.
     */
    @path
    resourceId: string,

    /**
     * The name of the remediation.
     */
    @path
    remediationName: string,
  ): ArmResponse<Remediation> | ArmDeletedNoContentResponse | ErrorResponse;

  /**
   * Gets all remediations for a resource.
   */
  @route("/{+resourceId}/providers/Microsoft.PolicyInsights/remediations")
  @list
  @get
  listForResource(
    ...ApiVersionParameter,

    /**
     * Resource ID.
     */
    @path
    resourceId: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @query("$filter")
    Filter?: string,
  ): ArmResponse<RemediationListResult> | ErrorResponse;

  /**
   * Gets all deployments for a remediation at resource scope.
   */
  @route("/{+resourceId}/providers/Microsoft.PolicyInsights/remediations/{remediationName}/listDeployments")
  @list
  @post
  listDeploymentsAtResource(
    ...ApiVersionParameter,

    /**
     * Resource ID.
     */
    @path
    resourceId: string,

    /**
     * The name of the remediation.
     */
    @path
    remediationName: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @query("$top")
    @minValue(0)
    Top?: int32,
  ): ArmResponse<RemediationDeploymentsListResult> | ErrorResponse;

  /**
   * Cancel a remediation at resource scope.
   */
  @route("/{+resourceId}/providers/Microsoft.PolicyInsights/remediations/{remediationName}/cancel")
  @post
  cancelAtResource(
    ...ApiVersionParameter,

    /**
     * Resource ID.
     */
    @path
    resourceId: string,

    /**
     * The name of the remediation.
     */
    @path
    remediationName: string,
  ): ArmResponse<Remediation> | ErrorResponse;
}

@@doc(Remediation.name, "The name of the remediation.");
@@doc(Remediation.properties, "Properties for the remediation.");
@@doc(Remediations.createOrUpdateAtManagementGroup::parameters.resource,
  "The remediation parameters."
);
@@doc(RemediationSubscriptionOperations.createOrUpdateAtSubscription::parameters.resource,
  "The remediation parameters."
);
@@doc(RemediationResourceGroupOperations.createOrUpdateAtResourceGroup::parameters.resource,
  "The remediation parameters."
);
@@doc(RemediationResourceOperations.createOrUpdateAtResource::parameters.resource,
  "The remediation parameters."
);
