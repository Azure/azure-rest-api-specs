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

alias DaprComponentCustomErrorOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
  },
  ErrorType = DefaultErrorResponse
>;

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@tag("DaprComponents")
interface ConnectedEnvironmentsDaprComponents {
  /**
   * Get a dapr component.
   */
  @summary("Get a dapr component.")
  get is DaprComponentCustomErrorOps.Read<DaprComponent>;

  /**
   * Creates or updates a Dapr Component in a connected environment.
   */
  @summary("Creates or updates a Dapr Component.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DaprComponent>;

  /**
   * Delete a Dapr Component from a connected environment.
   */
  @summary("Delete a Dapr Component.")
  delete is DaprComponentOps.DeleteWithoutOkAsync<DaprComponent>;

  /**
   * Get the Dapr Components for a connected environment.
   */
  @summary("Get the Dapr Components for a connected environment.")
  list is DaprComponentCustomErrorOps.List<
    DaprComponent,
    Response = ArmResponse<DaprComponentsCollection>
  >;

  /**
   * List secrets for a dapr component
   */
  @list
  @summary("List secrets for a dapr component")
  listSecrets is DaprComponentCustomErrorOps.ActionSync<
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
  },
  ErrorType = DefaultErrorResponse
>;

@armResourceOperations
@tag("DaprComponents")
interface DaprComponents {
  /**
   * Get a dapr component.
   */
  @summary("Get a dapr component.")
  get is DaprComponentOperationGroupOps.Read<DaprComponent>;

  /**
   * Creates or updates a Dapr Component in a Managed Environment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates or updates a Dapr Component.")
  createOrUpdate is DaprComponentOperationGroupOps.CreateOrUpdateSync<
    DaprComponent,
    Response = ArmResourceUpdatedResponse<DaprComponent>
  >;

  /**
   * Delete a Dapr Component from a Managed Environment.
   */
  @summary("Delete a Dapr Component.")
  delete is DaprComponentOperationGroupOps.DeleteSync<DaprComponent>;

  /**
   * Get the Dapr Components for a managed environment.
   */
  @summary("Get the Dapr Components for a managed environment.")
  list is DaprComponentOperationGroupOps.List<
    DaprComponent,
    Response = ArmResponse<DaprComponentsCollection>
  >;

  /**
   * List secrets for a dapr component
   */
  @list
  @summary("List secrets for a dapr component")
  listSecrets is DaprComponentOperationGroupOps.ActionSync<
    DaprComponent,
    void,
    ArmResponse<DaprSecretsCollection>
  >;
}

@@doc(DaprComponent.name, "Name of the Dapr Component.");
@@doc(DaprComponent.properties, "Dapr Component resource specific properties");
@@doc(ConnectedEnvironmentsDaprComponents.createOrUpdate::parameters.resource,
  "Configuration details of the Dapr Component."
);
@@doc(DaprComponents.createOrUpdate::parameters.resource,
  "Configuration details of the Dapr Component."
);
