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
@doc("Dapr Component.")
@parentResource(ConnectedEnvironment)
model DaprComponent is ProxyResource<DaprComponentProperties> {
  @doc("Name of the Dapr Component.")
  @path
  @key("componentName")
  @segment("daprComponents")
  name: string;
}

@armResourceOperations
interface DaprComponents {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a dapr component.")
  @operationId("ConnectedEnvironmentsDaprComponents_Get")
  get is ArmResourceRead<DaprComponent>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a Dapr Component in a connected environment.")
  @operationId("ConnectedEnvironmentsDaprComponents_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DaprComponent>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a Dapr Component from a connected environment.")
  @operationId("ConnectedEnvironmentsDaprComponents_Delete")
  delete is ArmResourceDeleteSync<DaprComponent>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the Dapr Components for a connected environment.")
  @operationId("ConnectedEnvironmentsDaprComponents_List")
  list is ArmResourceListByParent<DaprComponent>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List secrets for a dapr component")
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
