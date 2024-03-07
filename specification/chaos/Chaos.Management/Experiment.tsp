import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;
/**
 * Model that represents a Experiment resource.
 */
model Experiment is TrackedResource<ExperimentProperties> {
  /**
   * String that represents a Experiment resource name.
   */
  @minLength(1)
  @pattern("^[^<>%&:?#/\\\\]+$")
  @path
  @key("experimentName")
  @segment("experiments")
  @visibility("read")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Experiments {
  /**
   * Get a Experiment resource.
   */
  get is ArmResourceRead<Experiment>;

  /**
   * Create or update a Experiment resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Experiment>;

  /**
   * The operation to update an experiment.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<Experiment, ExperimentUpdate>;

  /**
   * Delete a Experiment resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Experiment>;

  /**
   * Get a list of Experiment resources in a resource group.
   */
  list is ArmResourceListByParent<
    Experiment,
    {
      ...BaseParameters<Experiment>;

      /**
       * Optional value that indicates whether to filter results based on if the Experiment is currently running. If null, then the results will not be filtered.
       */
      @query("running")
      running?: boolean;

      /**
       * String that sets the continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    }
  >;

  /**
   * Get a list of Experiment resources in a subscription.
   */
  listAll is ArmListBySubscription<Experiment>;

  /**
   * Cancel a running Experiment resource.
   */
  cancel is ArmResourceActionNoResponseContentAsync<Experiment, void>;

  /**
   * Start a Experiment resource.
   */
  start is ArmResourceActionNoResponseContentAsync<Experiment, void>;
}

@@doc(Experiments.createOrUpdate::parameters.resource,
  "Experiment resource to be created or updated."
);
@@doc(Experiments.update::parameters.properties,
  "Parameters supplied to the Update experiment operation."
);
