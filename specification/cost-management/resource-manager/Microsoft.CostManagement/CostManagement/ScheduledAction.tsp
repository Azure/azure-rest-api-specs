import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CostManagement;
/**
 * Scheduled action definition.
 */
@tenantResource
model ScheduledAction
  is Azure.ResourceManager.ProxyResource<ScheduledActionProperties> {
  ...ResourceNameParameter<
    Resource = ScheduledAction,
    KeyName = "name",
    SegmentName = "scheduledActions",
    NamePattern = ""
  >;

  /**
   * Resource Etag. For update calls, eTag is optional and can be specified to achieve optimistic concurrency. Fetch the resource's eTag by doing a 'GET' call first and then including the latest eTag as part of the request body or 'If-Match' header while performing the update. For create calls, eTag is not required.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: Azure.Core.eTag;

  /**
   * Kind of the scheduled action.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: ScheduledActionKind;
}

@armResourceOperations
interface ScheduledActionOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.CostManagement",
      },
      {},
      {
        /** Scheduled action name. */
        @path
        @segment("scheduledActions")
        @key
        name: string,
      }
    > {}

@armResourceOperations
interface ScheduledActions {
  /**
   * Get the private scheduled action by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/rest/api/cost-management/")
  get is ScheduledActionOps.Read<
    ScheduledAction,
    ErrorType = ErrorResponseWithNestedDetails
  >;

  /**
   * Create or update a private scheduled action.
   */
  createOrUpdate is ScheduledActionOps.CreateOrUpdateSync<
    ScheduledAction,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity. Optional when updating an entity and can be specified to achieve optimistic concurrency.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    ErrorType = ErrorResponseWithNestedDetails
  >;

  /**
   * Delete a private scheduled action.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/rest/api/cost-management/")
  delete is ScheduledActionOps.DeleteSync<
    ScheduledAction,
    ErrorType = ErrorResponseWithNestedDetails
  >;

  /**
   * List all private scheduled actions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/rest/api/cost-management/")
  list is ScheduledActionOps.List<
    ScheduledAction,
    Parameters = {
      /**
       * May be used to filter scheduled actions by properties/viewId. Supported operator is 'eq'.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ScheduledActionListResult,
    ErrorType = ErrorResponseWithNestedDetails
  >;

  /**
   * Processes a private scheduled action.
   */
  @action("execute")
  run is ScheduledActionOps.ActionSync<
    ScheduledAction,
    void,
    OkResponse,
    ErrorType = ErrorResponseWithNestedDetails
  >;
}

@armResourceOperations
interface ScheduledActionOperationGroupOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,

        /** undefined */
        @path
        @segment("")
        @key
        scope: string,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.CostManagement",
      },
      {},
      {
        /** Scheduled action name. */
        @path
        @segment("scheduledActions")
        @key
        name: string,
      }
    > {}

@armResourceOperations
interface ScheduledActionOperationGroup {
  /**
   * Get the shared scheduled action from the given scope by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/rest/api/cost-management/")
  getByScope is ScheduledActionOperationGroupOps.Read<
    ScheduledAction,
    ErrorType = ErrorResponseWithNestedDetails
  >;

  /**
   * Create or update a shared scheduled action within the given scope.
   */
  createOrUpdateByScope is ScheduledActionOperationGroupOps.CreateOrUpdateSync<
    ScheduledAction,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity. Optional when updating an entity and can be specified to achieve optimistic concurrency.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    ErrorType = ErrorResponseWithNestedDetails
  >;

  /**
   * Delete a scheduled action within the given scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/rest/api/cost-management/")
  deleteByScope is ScheduledActionOperationGroupOps.DeleteSync<
    ScheduledAction,
    ErrorType = ErrorResponseWithNestedDetails
  >;

  /**
   * List all shared scheduled actions within the given scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/rest/api/cost-management/")
  listByScope is ScheduledActionOperationGroupOps.List<
    ScheduledAction,
    Parameters = {
      /**
       * May be used to filter scheduled actions by properties/viewId. Supported operator is 'eq'.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ScheduledActionListResult,
    ErrorType = ErrorResponseWithNestedDetails
  >;

  /**
   * Runs a shared scheduled action within the given scope.
   */
  @action("execute")
  runByScope is ScheduledActionOperationGroupOps.ActionSync<
    ScheduledAction,
    void,
    OkResponse,
    ErrorType = ErrorResponseWithNestedDetails
  >;
}

@@doc(ScheduledAction.name, "Scheduled action name.");
@@doc(ScheduledAction.properties, "The properties of the scheduled action.");
@@doc(ScheduledActions.createOrUpdate::parameters.resource,
  "Scheduled action to be created or updated."
);
@@doc(ScheduledActionOperationGroup.createOrUpdateByScope::parameters.resource,
  "Scheduled action to be created or updated."
);
