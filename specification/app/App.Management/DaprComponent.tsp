import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConnectedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Dapr Component.
 */
@parentResource(ConnectedEnvironment)
model DaprComponent
  is Azure.ResourceManager.ProxyResource<DaprComponentProperties> {
  ...ResourceNameParameter<
    Resource = DaprComponent,
    KeyName = "componentName",
    SegmentName = "daprComponents",
    NamePattern = ""
  >;
}

alias DaprComponentOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the connected environment. */
    @path
    @segment("connectedEnvironments")
    @key
    connectedEnvironmentName: string;
  },
  {
    /** Name of the Dapr Component. */
    @path
    @segment("daprComponents")
    @key
    componentName: string;
  }
>;

@armResourceOperations
interface DaprComponents {
  /**
   * Get a dapr component.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectedEnvironmentsDaprComponents_Get")
  get is DaprComponentOps.Read<DaprComponent>;

  /**
   * Creates or updates a Dapr Component in a connected environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectedEnvironmentsDaprComponents_CreateOrUpdate")
  createOrUpdate is DaprComponentOps.CreateOrUpdateAsync<DaprComponent>;

  /**
   * Delete a Dapr Component from a connected environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectedEnvironmentsDaprComponents_Delete")
  delete is DaprComponentOps.DeleteWithoutOkAsync<DaprComponent>;

  /**
   * Get the Dapr Components for a connected environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectedEnvironmentsDaprComponents_List")
  list is DaprComponentOps.List<
    DaprComponent,
    Response = ArmResponse<DaprComponentsCollection>
  >;

  /**
   * List secrets for a dapr component
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectedEnvironmentsDaprComponents_ListSecrets")
  @list
  listSecrets is DaprComponentOps.ActionSync<
    DaprComponent,
    void,
    ArmResponse<DaprSecretsCollection>
  >;
}
alias DaprComponentOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Managed Environment. */
    @path
    @segment("managedEnvironments")
    @key
    environmentName: string;
  },
  {
    /** Name of the Dapr Component. */
    @path
    @segment("daprComponents")
    @key
    componentName: string;
  }
>;

@armResourceOperations
interface DaprComponentOperationGroup {
  /**
   * Get a dapr component.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DaprComponents_Get")
  get is DaprComponentOperationGroupOps.Read<DaprComponent>;

  /**
   * Creates or updates a Dapr Component in a Managed Environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("DaprComponents_CreateOrUpdate")
  createOrUpdate is DaprComponentOperationGroupOps.CreateOrUpdateSync<
    DaprComponent,
    Response = ArmResourceUpdatedResponse<DaprComponent>
  >;

  /**
   * Delete a Dapr Component from a Managed Environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DaprComponents_Delete")
  delete is DaprComponentOperationGroupOps.DeleteSync<DaprComponent>;

  /**
   * Get the Dapr Components for a managed environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DaprComponents_List")
  list is DaprComponentOperationGroupOps.List<
    DaprComponent,
    Response = ArmResponse<DaprComponentsCollection>
  >;

  /**
   * List secrets for a dapr component
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DaprComponents_ListSecrets")
  @list
  listSecrets is DaprComponentOperationGroupOps.ActionSync<
    DaprComponent,
    void,
    ArmResponse<DaprSecretsCollection>
  >;
}

@@doc(DaprComponent.name, "Name of the Dapr Component.");
@@doc(DaprComponent.properties, "Dapr Component resource specific properties");
@@doc(DaprComponents.createOrUpdate::parameters.resource,
  "Configuration details of the Dapr Component."
);
@@doc(DaprComponentOperationGroup.createOrUpdate::parameters.resource,
  "Configuration details of the Dapr Component."
);
