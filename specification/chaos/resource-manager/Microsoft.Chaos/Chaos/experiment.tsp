import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./experiment.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;

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
   * Update an experiment.
   */
  @patch(#{ implicitOptionality: false })
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
    Parameters = {
      /**
       * Optional value that indicates whether to filter results based on if the Experiment is currently running. If null, then the results will not be filtered.
       */
      #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing list.running has a boolean wire value; preserve the published property contract."
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing list.running retains the running query parameter; preserve wire compatibility."
      @query("running")
      running?: boolean;

      /**
       * String that sets the continuation token.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing list.continuationToken retains the continuationToken query parameter; preserve wire compatibility."
      @query("continuationToken")
      continuationToken?: string;
    },
    Response = ExperimentListResult
  >;

  /**
   * Get a list of Experiment resources in a subscription.
   */
  listAll is ArmListBySubscription<
    Experiment,
    Parameters = {
      /**
       * Optional value that indicates whether to filter results based on if the Experiment is currently running. If null, then the results will not be filtered.
       */
      #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing listAll.running has a boolean wire value; preserve the published property contract."
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listAll.running retains the running query parameter; preserve wire compatibility."
      @query("running")
      running?: boolean;

      /**
       * String that sets the continuation token.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listAll.continuationToken retains the continuationToken query parameter; preserve wire compatibility."
      @query("continuationToken")
      continuationToken?: string;
    },
    Response = ExperimentListResult
  >;

  /**
   * Cancel a running Experiment resource.
   */
  cancel is ArmResourceActionNoResponseContentAsync<Experiment, void>;

  /**
   * Start a Experiment resource.
   */
  start is ArmResourceActionNoResponseContentAsync<Experiment, void>;
}

@@minLength(Experiment.name, 1);
@@doc(Experiment.name, "String that represents a Experiment resource name.");
@@doc(Experiment.properties, "The properties of the experiment resource.");
@@doc(
  Experiments.createOrUpdate::parameters.resource,
  "Experiment resource to be created or updated."
);
@@doc(
  Experiments.update::parameters.properties,
  "Parameters supplied to the Update experiment operation."
);
