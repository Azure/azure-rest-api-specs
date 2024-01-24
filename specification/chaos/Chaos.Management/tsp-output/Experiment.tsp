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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(ExperimentProperties)
@includeInapplicableMetadataInPayload(false)
model Experiment extends TrackedResourceBase {
  /**
   * String that represents a Experiment resource name.
   */
  @minLength(1)
  @pattern("^[^<>%&:?#/\\\\]+$")
  @path
  @key("experimentName")
  @segment("experiments")
  name: string;

  /**
   * The properties of the experiment resource.
   */
  @extension("x-ms-client-flatten", true)
  properties: ExperimentProperties;

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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Experiment,
    BaseParameters<Experiment>,
    ArmAsyncOperationHeader
  >;

  /**
   * The operation to update an experiment.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Experiment,
    ExperimentUpdate,
    BaseParameters<Experiment>,
    ArmLroLocationHeader
  >;

  /**
   * Delete a Experiment resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Experiment,
    BaseParameters<Experiment>,
    ArmLroLocationHeader
  >;

  /**
   * Get a list of Experiment resources in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Experiments_List")
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
  cancel is ArmResourceActionNoResponseContentAsync<
    Experiment,
    void,
    BaseParameters<Experiment>,
    ArmLroLocationHeader
  >;

  /**
   * Start a Experiment resource.
   */
  start is ArmResourceActionNoResponseContentAsync<
    Experiment,
    void,
    BaseParameters<Experiment>,
    ArmLroLocationHeader
  >;
}

@@projectedName(Experiments.createOrUpdate::parameters.resource,
  "json",
  "experiment"
);
@@extension(Experiments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "experiment"
);
@@doc(Experiments.createOrUpdate::parameters.resource,
  "Experiment resource to be created or updated."
);
@@projectedName(Experiments.update::parameters.properties,
  "json",
  "experiment"
);
@@extension(Experiments.update::parameters.properties,
  "x-ms-client-name",
  "experiment"
);
@@doc(Experiments.update::parameters.properties,
  "Parameters supplied to the Update experiment operation."
);
