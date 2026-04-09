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
 * Access Review History Definition.
 */
@subscriptionResource
model AccessReviewHistoryDefinition
  is Azure.ResourceManager.ProxyResource<AccessReviewHistoryDefinitionProperties> {
  ...ResourceNameParameter<
    Resource = AccessReviewHistoryDefinition,
    KeyName = "historyDefinitionId",
    SegmentName = "accessReviewHistoryDefinitions",
    NamePattern = ""
  >;
}

alias AccessReviewHistoryDefinitionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The id of the access review history definition. */
    @path
    @segment("accessReviewHistoryDefinitions")
    @key
    historyDefinitionId: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface AccessReviewHistoryDefinitions {
  /**
   * Get access review history definition by definition Id
   */
  @tag("GetAccessReviewHistoryDefinition")
  getById is AccessReviewHistoryDefinitionOps.Read<
    AccessReviewHistoryDefinition,
    ErrorType = ErrorDefinition
  >;

  /**
   * Create a scheduled or one-time Access Review History Definition
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("PutAccessReviewHistoryDefinition")
  create is AccessReviewHistoryDefinitionOps.CreateOrUpdateSync<
    AccessReviewHistoryDefinition,
    Request = AccessReviewHistoryDefinitionProperties,
    Response = ArmResourceUpdatedResponse<AccessReviewHistoryDefinition>,
    ErrorType = ErrorDefinition
  >;

  /**
   * Delete an access review history definition
   */
  @tag("DeleteAccessReviewHistoryDefinition")
  deleteById is AccessReviewHistoryDefinitionOps.DeleteSync<
    AccessReviewHistoryDefinition,
    ErrorType = ErrorDefinition
  >;

  /**
   * Lists the accessReviewHistoryDefinitions available from this provider, definition instances are only available for 30 days after creation.
   */
  @tag("GetAccessReviewHistoryDefinitions")
  list is AccessReviewHistoryDefinitionOps.List<
    AccessReviewHistoryDefinition,
    Parameters = {
      /**
       * The filter to apply on the operation. Only standard filters on definition name and created date are supported
       */
      @query("$filter")
      $filter?: string;
    },
    ErrorType = ErrorDefinition
  >;

  /**
   * Generates a uri which can be used to retrieve review history data. This URI has a TTL of 1 day and can be retrieved by fetching the accessReviewHistoryDefinition object.
   */
  @tag("PostAccessReviewHistoryDefinitionInstance")
  generateDownloadUri is AccessReviewHistoryDefinitionOps.ActionSync<
    AccessReviewHistoryDefinition,
    void,
    ArmResponse<AccessReviewHistoryInstance>,
    Parameters = {
      /**
       * The id of the access review history definition instance to generate a URI for.
       */
      @path
      @segment("instances")
      instanceId: string;
    },
    ErrorType = ErrorDefinition
  >;

  /**
   * Get access review history definition instances by definition Id
   */
  @tag("GetAccessReviewHistoryDefinitionInstances")
  @list
  @get
  @action("instances")
  accessReviewHistoryDefinitionInstancesList is AccessReviewHistoryDefinitionOps.ActionSync<
    AccessReviewHistoryDefinition,
    void,
    AccessReviewHistoryDefinitionInstanceListResult,
    ErrorType = ErrorDefinition
  >;
}
alias ScopeAccessReviewHistoryDefinitionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The id of the access review history definition. */
    @path
    @segment("accessReviewHistoryDefinitions")
    @key
    historyDefinitionId: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface ScopeAccessReviewHistoryDefinitions {
  /**
   * Get access review history definition by definition Id
   */
  @tag("GetAccessReviewHistoryDefinition")
  getById is ScopeAccessReviewHistoryDefinitionOps.Read<
    AccessReviewHistoryDefinition,
    ErrorType = ErrorDefinition
  >;

  /**
   * Create a scheduled or one-time Access Review History Definition
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("PutAccessReviewHistoryDefinition")
  create is ScopeAccessReviewHistoryDefinitionOps.CreateOrUpdateSync<
    AccessReviewHistoryDefinition,
    Request = AccessReviewHistoryDefinitionProperties,
    Response = ArmResourceUpdatedResponse<AccessReviewHistoryDefinition>,
    ErrorType = ErrorDefinition
  >;

  /**
   * Delete an access review history definition
   */
  @tag("DeleteAccessReviewHistoryDefinition")
  deleteById is ScopeAccessReviewHistoryDefinitionOps.DeleteSync<
    AccessReviewHistoryDefinition,
    ErrorType = ErrorDefinition
  >;

  /**
   * Lists the accessReviewHistoryDefinitions available from this provider, definition instances are only available for 30 days after creation.
   */
  @tag("GetAccessReviewHistoryDefinitions")
  list is ScopeAccessReviewHistoryDefinitionOps.List<
    AccessReviewHistoryDefinition,
    Parameters = {
      /**
       * The filter to apply on the operation. Only standard filters on definition name and created date are supported
       */
      @query("$filter")
      $filter?: string;
    },
    ErrorType = ErrorDefinition
  >;

  /**
   * Generates a uri which can be used to retrieve review history data. This URI has a TTL of 1 day and can be retrieved by fetching the accessReviewHistoryDefinition object.
   */
  @tag("PostAccessReviewHistoryDefinitionInstance")
  generateDownloadUri is ScopeAccessReviewHistoryDefinitionOps.ActionSync<
    AccessReviewHistoryDefinition,
    void,
    ArmResponse<AccessReviewHistoryInstance>,
    Parameters = {
      /**
       * The id of the access review history definition instance to generate a URI for.
       */
      @path
      @segment("instances")
      instanceId: string;
    },
    ErrorType = ErrorDefinition
  >;

  /**
   * Get access review history definition instances by definition Id
   */
  @tag("ScopeGetAccessReviewHistoryDefinitionInstances")
  @list
  @get
  @action("instances")
  scopeAccessReviewHistoryDefinitionInstancesList is ScopeAccessReviewHistoryDefinitionOps.ActionSync<
    AccessReviewHistoryDefinition,
    void,
    AccessReviewHistoryDefinitionInstanceListResult,
    ErrorType = ErrorDefinition
  >;
}

@@doc(AccessReviewHistoryDefinition.name,
  "The id of the access review history definition."
);
@@doc(AccessReviewHistoryDefinition.properties,
  "Access Review History Definition properties."
);
@@doc(AccessReviewHistoryDefinitions.create::parameters.resource,
  "Access review history definition properties."
);
@@doc(ScopeAccessReviewHistoryDefinitions.create::parameters.resource,
  "Access review history definition properties."
);
