import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConnectedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Dapr Component.
 */
@parentResource(ConnectedEnvironment)
model DaprComponent is ProxyResource<DaprComponentProperties> {
  /**
   * Name of the Dapr Component.
   */
  @path
  @key("componentName")
  @segment("daprComponents")
  name: string;
}

@armResourceOperations
interface DaprComponents {
  /**
   * Get a dapr component.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedEnvironmentsDaprComponents_Get")
  get is ArmResourceRead<DaprComponent>;

  /**
   * Creates or updates a Dapr Component in a connected environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedEnvironmentsDaprComponents_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DaprComponent>;

  /**
   * Delete a Dapr Component from a connected environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedEnvironmentsDaprComponents_Delete")
  delete is ArmResourceDeleteSync<DaprComponent>;

  /**
   * Get the Dapr Components for a connected environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedEnvironmentsDaprComponents_List")
  list is ArmResourceListByParent<DaprComponent>;

  /**
   * List secrets for a dapr component
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedEnvironmentsDaprComponents_ListSecrets")
  listSecrets is ArmResourceActionSync<
    DaprComponent,
    void,
    DaprSecretsCollection
  >;
}

@@projectedName(DaprComponents.createOrUpdate::parameters.resource,
  "json",
  "daprComponentEnvelope"
);
@@extension(DaprComponents.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "daprComponentEnvelope"
);
@@doc(DaprComponents.createOrUpdate::parameters.resource,
  "Configuration details of the Dapr Component."
);
