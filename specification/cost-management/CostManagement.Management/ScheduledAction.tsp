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
  get is ScheduledActionOps.Read<ScheduledAction>;

  /**
   * Create or update a private scheduled action.
   */
  createOrUpdate is ScheduledActionOps.CreateOrUpdateSync<
    ScheduledAction,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity. Optional when updating an entity and can be specified to achieve optimistic concurrency.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Delete a private scheduled action.
   */
  delete is ScheduledActionOps.DeleteSync<ScheduledAction>;

  /**
   * Processes a private scheduled action.
   */
  @action("execute")
  run is ScheduledActionOps.ActionSync<ScheduledAction, void, OkResponse>;
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScheduledActions_GetByScope")
  getByScope is ScheduledActionOperationGroupOps.Read<
    Extension.ScopeParameter,
    ScheduledAction
  >;

  /**
   * Create or update a shared scheduled action within the given scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScheduledActions_CreateOrUpdateByScope")
  createOrUpdateByScope is ScheduledActionOperationGroupOps.CreateOrUpdateSync<
    Extension.ScopeParameter,
    ScheduledAction,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity. Optional when updating an entity and can be specified to achieve optimistic concurrency.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Delete a scheduled action within the given scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScheduledActions_DeleteByScope")
  deleteByScope is ScheduledActionOperationGroupOps.DeleteSync<
    Extension.ScopeParameter,
    ScheduledAction
  >;

  /**
   * List all private scheduled actions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScheduledActions_List")
  list is ScheduledActionOperationGroupOps.List<
    Extension.ScopeParameter,
    ScheduledAction,
    Parameters = {
      /**
       * May be used to filter scheduled actions by properties/viewId. Supported operator is 'eq'.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Runs a shared scheduled action within the given scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScheduledActions_RunByScope")
  @action("execute")
  runByScope is ScheduledActionOperationGroupOps.ActionSync<
    Extension.ScopeParameter,
    ScheduledAction,
    void,
    OkResponse
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
