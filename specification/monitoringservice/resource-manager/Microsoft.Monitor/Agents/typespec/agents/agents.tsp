import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "../models.tsp";
import "../service.tsp";

using Azure.ResourceManager;

namespace Microsoft.Monitor {
  @armResourceOperations
  interface ObservabilityAgents {
    /**
     * Returns the specified observability agent. For a May resource, projects enabled as autonomousOperationsEnabled and enabled child monitored resources as embedded entries without changing stored data. Legacy operations are not converted into investigation policies.
     */
    get is ArmResourceRead<ObservabilityAgentResource>;

    /**
     * Creates or replaces an observability agent. A PUT can migrate a May resource to the August model using the supplied complete configuration; omitted legacy operations are not carried forward. The migration is one-way, and later May PUT or PATCH requests return 409 ObservabilityAgentResourceModelConflict.
     */
    createOrUpdate is ArmResourceCreateOrReplaceSync<ObservabilityAgentResource>;

    /**
     * Updates part of an August observability agent. PATCH does not migrate a May resource and returns 409 ObservabilityAgentResourceModelConflict for that resource; use an August PUT to migrate it.
     */
    update is ArmCustomPatchSync<
      ObservabilityAgentResource,
      PatchModel = ObservabilityAgentPatch
    >;

    /**
     * Deletes an observability agent.
     */
    delete is ArmResourceDeleteSync<ObservabilityAgentResource>;

    /**
     * Lists observability agents in the specified resource group.
     */
    listByResourceGroup is ArmResourceListByParent<ObservabilityAgentResource>;

    /**
     * Lists observability agents in the specified subscription.
     */
    listBySubscription is ArmListBySubscription<ObservabilityAgentResource>;
  }

  @@doc(
    ObservabilityAgentResource.name,
    "The name of the observability agent resource. The name is case insensitive"
  );
  @@doc(ObservabilityAgentResource.properties, "Resource properties");
  @@doc(
    ObservabilityAgents.createOrUpdate::parameters.resource,
    "Properties that need to be specified to create or update an observability agent"
  );
}
