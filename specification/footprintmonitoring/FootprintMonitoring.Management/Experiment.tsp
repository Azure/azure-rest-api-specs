import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.FootprintMonitoring;
/**
 * A model representing the Footprint experiment.
 */
@parentResource(Profile)
model Experiment is Azure.ResourceManager.ProxyResource<ExperimentProperties> {
  ...ResourceNameParameter<
    Resource = Experiment,
    KeyName = "experimentName",
    SegmentName = "experiments",
    NamePattern = "^[a-zA-Z0-9]"
  >;

  /**
   * The type of the resource.
   */
  // @visibility("read")
  // type?: string;
}

@armResourceOperations
interface Experiments {
  /**
   * Retrieves the information about a single Footprint experiment.
   */
  get is ArmResourceRead<Experiment>;

  /**
   * Creates or updates a Footprint experiment with the specified properties.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Experiment>;

  /**
   * Deletes an existing Footprint experiment.
   */
  delete is ArmResourceDeleteSync<Experiment>;

  /**
   * Retrieves the information about all experiments under a Footprint profile.
   */
  listByProfile is ArmResourceListByParent<Experiment>;
}

@@maxLength(Experiment.name, 64);
@@minLength(Experiment.name, 5);
@@doc(Experiment.name, "Name of the Footprint experiment resource.");
@@doc(Experiments.createOrUpdate::parameters.resource,
  "Footprint experiment creation or update parameters."
);
