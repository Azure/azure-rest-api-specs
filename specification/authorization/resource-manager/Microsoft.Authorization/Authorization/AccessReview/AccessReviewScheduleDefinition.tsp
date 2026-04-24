import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AttributeNamespaces;
/**
 * Access Review Schedule Definition.
 */
@subscriptionResource
model AccessReviewScheduleDefinition
  is Azure.ResourceManager.ProxyResource<AccessReviewScheduleDefinitionProperties> {
  ...ResourceNameParameter<
    Resource = AccessReviewScheduleDefinition,
    KeyName = "scheduleDefinitionId",
    SegmentName = "accessReviewScheduleDefinitions",
    NamePattern = ""
  >;
}

alias AccessReviewScheduleDefinitionAssignedOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";
  },
  {},
  {
    /** The id of the access review schedule definition. */
    @path
    @segment("accessReviewScheduleDefinitions")
    @key
    scheduleDefinitionId: string;
  }
>;

alias AccessReviewScheduleDefinitionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";
  },
  {},
  {
    /** The id of the access review schedule definition. */
    @path
    @segment("accessReviewScheduleDefinitions")
    @key
    scheduleDefinitionId: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface AccessReviewScheduleDefinitions {
  /**
   * Get single access review definition
   */
  @tag("GetAccessReviewScheduleDefinition")
  getById is AccessReviewScheduleDefinitionOps.Read<
    AccessReviewScheduleDefinition,
    ErrorType = ErrorDefinition
  >;

  /**
   * Create or Update access review schedule definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("PutAccessReviewScheduleDefinition")
  createOrUpdateById is AccessReviewScheduleDefinitionOps.CreateOrUpdateSync<
    AccessReviewScheduleDefinition,
    Request = AccessReviewScheduleDefinitionProperties,
    Response = ArmResourceUpdatedResponse<AccessReviewScheduleDefinition>,
    ErrorType = ErrorDefinition
  >;

  /**
   * Delete access review schedule definition
   */
  @tag("DeleteAccessReviewScheduleDefinition")
  deleteById is AccessReviewScheduleDefinitionOps.DeleteSync<
    AccessReviewScheduleDefinition,
    ErrorType = ErrorDefinition
  >;

  /**
   * Get access review schedule definitions
   */
  @tag("GetAccessReviewScheduleDefinitions")
  list is AccessReviewScheduleDefinitionOps.List<
    AccessReviewScheduleDefinition,
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
   * Stop access review definition
   */
  @tag("AccessReviewScheduleDefinitionStop")
  stop is AccessReviewScheduleDefinitionOps.ActionSync<
    AccessReviewScheduleDefinition,
    void,
    NoContentResponse,
    ErrorType = ErrorDefinition
  >;
}
alias ScopeAccessReviewScheduleDefinitionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
  },
  {},
  {
    /** The id of the access review schedule definition. */
    @path
    @segment("accessReviewScheduleDefinitions")
    @key
    scheduleDefinitionId: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface ScopeAccessReviewScheduleDefinitions {
  /**
   * Get single access review definition
   */
  @tag("GetAccessReviewScheduleDefinition")
  getById is ScopeAccessReviewScheduleDefinitionOps.Read<
    AccessReviewScheduleDefinition,
    ErrorType = ErrorDefinition
  >;

  /**
   * Create or Update access review schedule definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("PutAccessReviewScheduleDefinition")
  createOrUpdateById is ScopeAccessReviewScheduleDefinitionOps.CreateOrUpdateSync<
    AccessReviewScheduleDefinition,
    Request = AccessReviewScheduleDefinitionProperties,
    Response = ArmResourceUpdatedResponse<AccessReviewScheduleDefinition>,
    ErrorType = ErrorDefinition
  >;

  /**
   * Delete access review schedule definition
   */
  @tag("DeleteAccessReviewScheduleDefinition")
  deleteById is ScopeAccessReviewScheduleDefinitionOps.DeleteSync<
    AccessReviewScheduleDefinition,
    ErrorType = ErrorDefinition
  >;

  /**
   * Get access review schedule definitions
   */
  @tag("GetAccessReviewScheduleDefinitions")
  list is ScopeAccessReviewScheduleDefinitionOps.List<
    AccessReviewScheduleDefinition,
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
   * Stop access review definition
   */
  @tag("AccessReviewScheduleDefinitionStop")
  stop is ScopeAccessReviewScheduleDefinitionOps.ActionSync<
    AccessReviewScheduleDefinition,
    void,
    NoContentResponse,
    ErrorType = ErrorDefinition
  >;

  /**
   * Get access review instances assigned for my approval.
   */
  @tag("GetAccessReviewScheduleDefinitionsAssignedForMyApproval")
  listForMyApproval is AccessReviewScheduleDefinitionAssignedOps.List<
    AccessReviewScheduleDefinition,
    Parameters = {
      /**
       * The filter to apply on the operation. One custom filter option is supported : 'assignedToMeToReview()'. When specified $filter=assignedToMeToReview(), only items that are assigned to the calling user to review are returned
       */
      @query("$filter")
      $filter?: string;
    },
    ErrorType = ErrorDefinition
  >;
}

@@doc(AccessReviewScheduleDefinition.name,
  "The id of the access review schedule definition."
);
@@doc(AccessReviewScheduleDefinition.properties, "Access Review properties.");
@@doc(AccessReviewScheduleDefinitions.createOrUpdateById::parameters.resource,
  "Access review schedule definition properties."
);
@@doc(ScopeAccessReviewScheduleDefinitions.createOrUpdateById::parameters.resource,
  "Access review schedule definition properties."
);
