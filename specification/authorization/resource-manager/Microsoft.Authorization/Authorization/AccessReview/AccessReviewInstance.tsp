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

namespace Microsoft.AttributeNamespaces;
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

@armResourceOperations(#{ omitTags: true })
interface AccessReviewInstances {
  /**
   * Get access review instances
   */
  @tag("GetAccessReviewInstance")
  getById is AccessReviewInstanceOps.Read<
    AccessReviewInstance,
    ErrorType = ErrorDefinition
  >;

  /**
   * Update access review instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("PutAccessReviewInstance")
  create is AccessReviewInstanceOps.CreateOrUpdateSync<
    AccessReviewInstance,
    Request = AccessReviewInstanceProperties,
    Response = ArmResourceUpdatedResponse<AccessReviewInstance>,
    ErrorType = ErrorDefinition
  >;

  /**
   * Get access review instances
   */
  @tag("GetAccessReviewInstances")
  list is AccessReviewInstanceOps.List<
    AccessReviewInstance,
    Parameters = {
      /**
       * The filter to apply on the operation. Other than standard filters, one custom filter option is supported : 'assignedToMeToReview()'. When one specified $filter=assignedToMeToReview(), only items that are assigned to the calling user to review are returned
       */
      @query("$filter")
      $filter?: string;
    },
    ErrorType = ErrorDefinition
  >;

  /**
   * An action to stop an access review instance.
   */
  @tag("AccessReviewInstanceStop")
  stop is AccessReviewInstanceOps.ActionSync<
    AccessReviewInstance,
    void,
    NoContentResponse,
    ErrorType = ErrorDefinition
  >;

  /**
   * An action to reset all decisions for an access review instance.
   */
  @tag("AccessReviewInstanceResetDecisions")
  resetDecisions is AccessReviewInstanceOps.ActionSync<
    AccessReviewInstance,
    void,
    NoContentResponse,
    ErrorType = ErrorDefinition
  >;

  /**
   * An action to apply all decisions for an access review instance.
   */
  @tag("AccessReviewInstanceApplyDecisions")
  applyDecisions is AccessReviewInstanceOps.ActionSync<
    AccessReviewInstance,
    void,
    NoContentResponse,
    ErrorType = ErrorDefinition
  >;

  /**
   * An action to send reminders for an access review instance.
   */
  @tag("AccessReviewInstanceSendReminders")
  sendReminders is AccessReviewInstanceOps.ActionSync<
    AccessReviewInstance,
    void,
    NoContentResponse,
    ErrorType = ErrorDefinition
  >;

  /**
   * Get access review instance decisions
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("GetAccessReviewInstanceDecisions")
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
    },
    ErrorType = ErrorDefinition
  >;

  /**
   * Get access review instance contacted reviewers
   */
  @tag("GetAccessReviewInstanceContactedReviewers")
  @list
  @get
  @action("contactedReviewers")
  accessReviewInstanceContactedReviewersList is AccessReviewInstanceOps.ActionSync<
    AccessReviewInstance,
    void,
    ArmResponse<ResourceListResult<AccessReviewContactedReviewer>>,
    ErrorType = ErrorDefinition
  >;
}
alias ScopeAccessReviewInstanceOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The scope of the resource. */
    @path(#{ allowReserved: true })
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

@armResourceOperations(#{ omitTags: true })
interface ScopeAccessReviewInstances {
  /**
   * Get access review instances
   */
  @tag("GetAccessReviewInstance")
  getById is ScopeAccessReviewInstanceOps.Read<
    AccessReviewInstance,
    ErrorType = ErrorDefinition
  >;

  /**
   * Update access review instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("PutAccessReviewInstance")
  create is ScopeAccessReviewInstanceOps.CreateOrUpdateSync<
    AccessReviewInstance,
    Request = AccessReviewInstanceProperties,
    Response = ArmResourceUpdatedResponse<AccessReviewInstance>,
    ErrorType = ErrorDefinition
  >;

  /**
   * Get access review instances
   */
  @tag("GetAccessReviewInstances")
  list is ScopeAccessReviewInstanceOps.List<
    AccessReviewInstance,
    Parameters = {
      /**
       * The filter to apply on the operation. Other than standard filters, one custom filter option is supported : 'assignedToMeToReview()'. When one specified $filter=assignedToMeToReview(), only items that are assigned to the calling user to review are returned
       */
      @query("$filter")
      $filter?: string;
    },
    ErrorType = ErrorDefinition
  >;

  /**
   * An action to stop an access review instance.
   */
  @tag("AccessReviewInstanceStop")
  stop is ScopeAccessReviewInstanceOps.ActionSync<
    AccessReviewInstance,
    void,
    NoContentResponse,
    ErrorType = ErrorDefinition
  >;

  /**
   * An action to approve/deny all decisions for a review with certain filters.
   */
  @tag("AccessReviewInstanceRecordAllDecisions")
  recordAllDecisions is ScopeAccessReviewInstanceOps.ActionSync<
    AccessReviewInstance,
    RecordAllDecisionsProperties,
    NoContentResponse,
    ErrorType = ErrorDefinition
  >;

  /**
   * An action to reset all decisions for an access review instance.
   */
  @tag("AccessReviewInstanceResetDecisions")
  resetDecisions is ScopeAccessReviewInstanceOps.ActionSync<
    AccessReviewInstance,
    void,
    NoContentResponse,
    ErrorType = ErrorDefinition
  >;

  /**
   * An action to apply all decisions for an access review instance.
   */
  @tag("AccessReviewInstanceApplyDecisions")
  applyDecisions is ScopeAccessReviewInstanceOps.ActionSync<
    AccessReviewInstance,
    void,
    NoContentResponse,
    ErrorType = ErrorDefinition
  >;

  /**
   * An action to send reminders for an access review instance.
   */
  @tag("AccessReviewInstanceSendReminders")
  sendReminders is ScopeAccessReviewInstanceOps.ActionSync<
    AccessReviewInstance,
    void,
    NoContentResponse,
    ErrorType = ErrorDefinition
  >;

  /**
   * Get access review instance decisions
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("GetAccessReviewInstanceDecisions")
  @list
  @get
  @action("decisions")
  scopeAccessReviewInstanceDecisionsList is ScopeAccessReviewInstanceOps.ActionSync<
    AccessReviewInstance,
    void,
    ArmResponse<ResourceListResult<AccessReviewDecision>>,
    Parameters = {
      /**
       * The filter to apply on the operation. Other than standard filters, one custom filter option is supported : 'assignedToMeToReview()'. When one specified $filter=assignedToMeToReview(), only items that are assigned to the calling user to review are returned
       */
      @query("$filter")
      $filter?: string;
    },
    ErrorType = ErrorDefinition
  >;

  /**
   * Get access review instance contacted reviewers
   */
  @tag("GetAccessReviewInstanceContactedReviewers")
  @list
  @get
  @action("contactedReviewers")
  scopeAccessReviewInstanceContactedReviewersList is ScopeAccessReviewInstanceOps.ActionSync<
    AccessReviewInstance,
    void,
    ArmResponse<ResourceListResult<AccessReviewContactedReviewer>>,
    ErrorType = ErrorDefinition
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

@armResourceOperations(#{ omitTags: true })
interface AccessReviewInstancesAssignedForMyApproval {
  /**
   * Get single access review instance assigned for my approval.
   */
  @tag("GetAccessReviewInstance")
  getById is AccessReviewInstancesAssignedForMyApprovalOps.Read<
    AccessReviewInstance,
    ErrorType = ErrorDefinition
  >;

  /**
   * An action to accept recommendations for decision in an access review instance.
   */
  @tag("AccessReviewInstanceAcceptRecommmendations")
  acceptRecommendations is AccessReviewInstancesAssignedForMyApprovalOps.ActionSync<
    AccessReviewInstance,
    void,
    NoContentResponse,
    ErrorType = ErrorDefinition
  >;

  /**
   * Get access review instances assigned for my approval.
   */
  @tag("GetAccessReviewInstancesAssignedForMyApproval")
  @list
  @get
  list is AccessReviewInstancesAssignedForMyApprovalOps.List<
    AccessReviewInstance,
    Parameters = {
      /**
       * The filter to apply on the operation. Other than standard filters, one custom filter option is supported : 'assignedToMeToReview()'. When one specified $filter=assignedToMeToReview(), only items that are assigned to the calling user to review are returned
       */
      @query("$filter")
      $filter?: string;
    },
    ErrorType = ErrorDefinition
  >;

  /**
   * Get access review instance contacted reviewers
   */
  @tag("TenantLevelGetAccessReviewInstanceContactedReviewers")
  @list
  @get
  @action("contactedReviewers")
  reviewersList is AccessReviewInstancesAssignedForMyApprovalOps.ActionSync<
    AccessReviewInstance,
    void,
    ArmResponse<ResourceListResult<AccessReviewContactedReviewer>>,
    ErrorType = ErrorDefinition
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
