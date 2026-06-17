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

alias RemediationManagementGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The namespace for Microsoft Management RP; only "Microsoft.Management" is allowed. */
    #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
    @path
    @segment("providers")
    @key
    managementGroupsNamespace: ManagementGroupsNamespaceType;

    /** Management group ID. */
    @path
    @segment("managementGroups")
    @key
    managementGroupId: string;
  },
  {
    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the remediation. */
    @path
    @segment("remediations")
    @key
    remediationName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface Remediations {
  /**
   * Gets an existing remediation at management group scope.
   */
  getAtManagementGroup is RemediationManagementGroupOps.Read<
    Remediation,
    ErrorType = ErrorResponse
  >;

  /**
   * Creates or updates a remediation at management group scope.
   */
  createOrUpdateAtManagementGroup is RemediationManagementGroupOps.CreateOrUpdateSync<
    Remediation,
    Response =
      | ArmResponse<Remediation>
      | (CreatedResponse & Body<Remediation>),
    ErrorType = ErrorResponse
  >;

  /**
   * Deletes an existing remediation at management group scope.
   */
  deleteAtManagementGroup is RemediationManagementGroupOps.DeleteSync<
    Remediation,
    Response = ArmResponse<Remediation> | ArmDeletedNoContentResponse,
    ErrorType = ErrorResponse
  >;

  /**
   * Gets all remediations for the management group.
   */
  listForManagementGroup is RemediationManagementGroupOps.List<
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

alias RemediationAtResourceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;

    /** Resource ID. */
    @path(#{ allowReserved: true })
    @key
    resourceId: string;

    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    /** The name of the remediation. */
    @path
    @segment("remediations")
    @key
    remediationName: string;
  },
  ErrorType = ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface RemediationResourceOperations {
  /**
   * Gets an existing remediation at resource scope.
   */
  getAtResource is RemediationAtResourceOps.Read<
    Remediation,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Creates or updates a remediation at resource scope.
   */
  createOrUpdateAtResource is RemediationAtResourceOps.CreateOrUpdateAsync<
    Remediation,
    Response = ArmResponse<Remediation> | (CreatedResponse & Body<Remediation>)
  >;

  /**
   * Deletes an existing remediation at individual resource scope.
   */
  deleteAtResource is RemediationAtResourceOps.DeleteSync<
    Remediation,
    Response = ArmResponse<Remediation> | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all remediations for a resource.
   */
  listForResource is RemediationAtResourceOps.List<
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
    }
  >;

  /**
   * Gets all deployments for a remediation at resource scope.
   */
  @action("listDeployments")
  @list
  listDeploymentsAtResource is RemediationAtResourceOps.ActionSync<
    Remediation,
    void,
    Response = ArmResponse<RemediationDeploymentsListResult>,
    Parameters = {
      /**
       * Maximum number of records to return.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("$top")
      @minValue(0)
      Top?: int32;
    }
  >;

  /**
   * Cancel a remediation at resource scope.
   */
  @action("cancel")
  cancelAtResource is RemediationAtResourceOps.ActionSync<
    Remediation,
    void,
    Response = ArmResponse<Remediation>,
    OverrideErrorType = ErrorResponse
  >;
}

@@doc(Remediation.name, "The name of the remediation.");
@@doc(Remediation.properties, "Properties for the remediation.");
@@doc(
  Remediations.createOrUpdateAtManagementGroup::parameters.resource,
  "The remediation parameters."
);
@@doc(
  RemediationSubscriptionOperations.createOrUpdateAtSubscription::parameters.resource,
  "The remediation parameters."
);
@@doc(
  RemediationResourceGroupOperations.createOrUpdateAtResourceGroup::parameters.resource,
  "The remediation parameters."
);
@@doc(
  RemediationResourceOperations.createOrUpdateAtResource::parameters.resource,
  "The remediation parameters."
);
