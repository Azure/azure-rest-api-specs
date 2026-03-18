import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AccessReviewScheduleDefinition.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Authorization;
/**
 * Access Review Instance.
 */
@subscriptionResource
@parentResource(AccessReviewScheduleDefinition)
model AccessReviewInstance
  is Azure.ResourceManager.ProxyResource<AccessReviewInstanceProperties> {
  ...ResourceNameParameter<
    Resource = AccessReviewInstance,
    KeyName = "id",
    SegmentName = "instances",
    NamePattern = ""
  >;
}

alias AccessReviewInstanceOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";

    /** The id of the access review schedule definition. */
    @path
    @segment("accessReviewScheduleDefinitions")
    @key
    scheduleDefinitionId: string;
  },
  {},
  {
    /** The id of the access review instance. */
    @path
    @segment("instances")
    @key
    id: string;
  }
>;

@armResourceOperations
interface AccessReviewInstances {
  /**
   * Get access review instances
   */
  getById is AccessReviewInstanceOps.Read<AccessReviewInstance>;

  /**
   * Update access review instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is AccessReviewInstanceOps.CreateOrUpdateSync<
    AccessReviewInstance,
    Request = AccessReviewInstanceProperties,
    Response = ArmResourceUpdatedResponse<AccessReviewInstance>
  >;

  /**
   * Get access review instances
   */
  list is AccessReviewInstanceOps.List<
    AccessReviewInstance,
    Parameters = {
      /**
       * The filter to apply on the operation. Other than standard filters, one custom filter option is supported : 'assignedToMeToReview()'. When one specified $filter=assignedToMeToReview(), only items that are assigned to the calling user to review are returned
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * An action to stop an access review instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccessReviewInstance_Stop")
  stop is AccessReviewInstanceOps.ActionSync<
    AccessReviewInstance,
    void,
    NoContentResponse
  >;

  /**
   * An action to reset all decisions for an access review instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccessReviewInstance_ResetDecisions")
  resetDecisions is AccessReviewInstanceOps.ActionSync<
    AccessReviewInstance,
    void,
    NoContentResponse
  >;

  /**
   * An action to apply all decisions for an access review instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccessReviewInstance_ApplyDecisions")
  applyDecisions is AccessReviewInstanceOps.ActionSync<
    AccessReviewInstance,
    void,
    NoContentResponse
  >;

  /**
   * An action to send reminders for an access review instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccessReviewInstance_SendReminders")
  sendReminders is AccessReviewInstanceOps.ActionSync<
    AccessReviewInstance,
    void,
    NoContentResponse
  >;

  /**
   * Get access review instance decisions
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccessReviewInstanceDecisions_List")
  @list
  @get
  @action("decisions")
  accessReviewInstanceDecisionsList is AccessReviewInstanceOps.ActionSync<
    AccessReviewInstance,
    void,
    ArmResponse<ResourceListResult<AccessReviewDecision>>,
    Parameters = {
      /**
       * The filter to apply on the operation. Other than standard filters, one custom filter option is supported : 'assignedToMeToReview()'. When one specified $filter=assignedToMeToReview(), only items that are assigned to the calling user to review are returned
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Get access review instance contacted reviewers
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccessReviewInstanceContactedReviewers_List")
  @list
  @get
  @action("contactedReviewers")
  accessReviewInstanceContactedReviewersList is AccessReviewInstanceOps.ActionSync<
    AccessReviewInstance,
    void,
    ArmResponse<ResourceListResult<AccessReviewContactedReviewer>>
  >;
}
alias ScopeAccessReviewInstanceOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** undefined */
    @path
    @segment("")
    @key
    scope: string;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";

    /** The id of the access review schedule definition. */
    @path
    @segment("accessReviewScheduleDefinitions")
    @key
    scheduleDefinitionId: string;
  },
  {},
  {
    /** The id of the access review instance. */
    @path
    @segment("instances")
    @key
    id: string;
  }
>;

@armResourceOperations
interface ScopeAccessReviewInstances {
  /**
   * Get access review instances
   */
  getById is ScopeAccessReviewInstanceOps.Read<
    Extension.ScopeParameter,
    AccessReviewInstance
  >;

  /**
   * Update access review instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ScopeAccessReviewInstanceOps.CreateOrUpdateSync<
    Extension.ScopeParameter,
    AccessReviewInstance,
    Request = AccessReviewInstanceProperties,
    Response = ArmResourceUpdatedResponse<AccessReviewInstance>
  >;

  /**
   * Get access review instances
   */
  list is ScopeAccessReviewInstanceOps.List<
    Extension.ScopeParameter,
    AccessReviewInstance,
    Parameters = {
      /**
       * The filter to apply on the operation. Other than standard filters, one custom filter option is supported : 'assignedToMeToReview()'. When one specified $filter=assignedToMeToReview(), only items that are assigned to the calling user to review are returned
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * An action to stop an access review instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScopeAccessReviewInstance_Stop")
  stop is ScopeAccessReviewInstanceOps.ActionSync<
    Extension.ScopeParameter,
    AccessReviewInstance,
    void,
    NoContentResponse
  >;

  /**
   * An action to approve/deny all decisions for a review with certain filters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScopeAccessReviewInstance_RecordAllDecisions")
  recordAllDecisions is ScopeAccessReviewInstanceOps.ActionSync<
    Extension.ScopeParameter,
    AccessReviewInstance,
    RecordAllDecisionsProperties,
    NoContentResponse
  >;

  /**
   * An action to reset all decisions for an access review instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScopeAccessReviewInstance_ResetDecisions")
  resetDecisions is ScopeAccessReviewInstanceOps.ActionSync<
    Extension.ScopeParameter,
    AccessReviewInstance,
    void,
    NoContentResponse
  >;

  /**
   * An action to apply all decisions for an access review instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScopeAccessReviewInstance_ApplyDecisions")
  applyDecisions is ScopeAccessReviewInstanceOps.ActionSync<
    Extension.ScopeParameter,
    AccessReviewInstance,
    void,
    NoContentResponse
  >;

  /**
   * An action to send reminders for an access review instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScopeAccessReviewInstance_SendReminders")
  sendReminders is ScopeAccessReviewInstanceOps.ActionSync<
    Extension.ScopeParameter,
    AccessReviewInstance,
    void,
    NoContentResponse
  >;

  /**
   * Get access review instance decisions
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScopeAccessReviewInstanceDecisions_List")
  @list
  @get
  @action("decisions")
  scopeAccessReviewInstanceDecisionsList is ScopeAccessReviewInstanceOps.ActionSync<
    Extension.ScopeParameter,
    AccessReviewInstance,
    void,
    ArmResponse<ResourceListResult<AccessReviewDecision>>,
    Parameters = {
      /**
       * The filter to apply on the operation. Other than standard filters, one custom filter option is supported : 'assignedToMeToReview()'. When one specified $filter=assignedToMeToReview(), only items that are assigned to the calling user to review are returned
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Get access review instance contacted reviewers
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScopeAccessReviewInstanceContactedReviewers_List")
  @list
  @get
  @action("contactedReviewers")
  scopeAccessReviewInstanceContactedReviewersList is ScopeAccessReviewInstanceOps.ActionSync<
    Extension.ScopeParameter,
    AccessReviewInstance,
    void,
    ArmResponse<ResourceListResult<AccessReviewContactedReviewer>>
  >;
}
alias AccessReviewInstancesAssignedForMyApprovalOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";

    /** The id of the access review schedule definition. */
    @path
    @segment("accessReviewScheduleDefinitions")
    @key
    scheduleDefinitionId: string;
  },
  {},
  {
    /** The id of the access review instance. */
    @path
    @segment("instances")
    @key
    id: string;
  }
>;

@armResourceOperations
interface AccessReviewInstancesAssignedForMyApproval {
  /**
   * Get single access review instance assigned for my approval.
   */
  getById is AccessReviewInstancesAssignedForMyApprovalOps.Read<AccessReviewInstance>;

  /**
   * An action to accept recommendations for decision in an access review instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccessReviewInstance_AcceptRecommendations")
  acceptRecommendations is AccessReviewInstancesAssignedForMyApprovalOps.ActionSync<
    AccessReviewInstance,
    void,
    NoContentResponse
  >;

  /**
   * Get access review instance contacted reviewers
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TenantLevelAccessReviewInstanceContactedReviewers_List")
  @list
  @get
  @action("contactedReviewers")
  list is AccessReviewInstancesAssignedForMyApprovalOps.ActionSync<
    AccessReviewInstance,
    void,
    ArmResponse<ResourceListResult<AccessReviewContactedReviewer>>
  >;
}

@@doc(AccessReviewInstance.name, "The id of the access review instance.");
@@doc(AccessReviewInstance.properties, "Access Review properties.");
@@doc(AccessReviewInstances.create::parameters.resource,
  "Access review instance properties."
);
@@doc(ScopeAccessReviewInstances.create::parameters.resource,
  "Access review instance properties."
);
@@doc(ScopeAccessReviewInstances.recordAllDecisions::parameters.body,
  "Record all decisions payload."
);
