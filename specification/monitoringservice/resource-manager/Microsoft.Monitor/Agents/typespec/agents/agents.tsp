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
     * Returns the specified observability agent.
     */
    get is ArmResourceRead<ObservabilityAgentResource>;

    /**
     * Creates or updates an observability agent.
     */
    createOrUpdate is ArmResourceCreateOrReplaceSync<ObservabilityAgentResource>;

    /**
     * Updates part of an observability agent.
     */
    update is ArmCustomPatchSync<
      ObservabilityAgentResource,
      Azure.ResourceManager.Foundations.ResourceUpdateModel<
        ObservabilityAgentResource,
        { properties?: ObservabilityAgentProperties }
      >
    >;

    /**
     * Deletes an observability agent.
     */
    delete is ArmResourceDeleteWithoutOkAsync<ObservabilityAgentResource>;

    /**
     * Lists observability agents in the specified resource group.
     */
    listByResourceGroup is ArmResourceListByParent<ObservabilityAgentResource>;

    /**
     * Lists observability agents in the specified subscription.
     */
    listBySubscription is ArmListBySubscription<ObservabilityAgentResource>;
  }

  @@doc(ObservabilityAgentResource.name,
    "The name of the observability agent resource. The name is case insensitive"
  );
  @@doc(ObservabilityAgentResource.properties, "Resource properties");
  @@doc(ObservabilityAgents.createOrUpdate::parameters.resource,
    "Properties that need to be specified to create or update an observability agent"
  );
}
