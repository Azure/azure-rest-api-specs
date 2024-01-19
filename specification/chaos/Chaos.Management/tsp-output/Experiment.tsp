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
@doc("Model that represents a Experiment resource.")
model Experiment is TrackedResource<ExperimentProperties> {
  @doc("String that represents a Experiment resource name.")
  @minLength(1)
  @pattern("^[^<>%&:?#/\\\\]+$")
  @path
  @key("experimentName")
  @segment("experiments")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Experiments {
  @doc("Get a Experiment resource.")
  get is ArmResourceRead<Experiment>;

  @doc("Create or update a Experiment resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Experiment,
    BaseParameters<Experiment>,
    ArmAsyncOperationHeader
  >;

  @doc("The operation to update an experiment.")
  update is ArmCustomPatchAsync<
    Experiment,
    ExperimentUpdate,
    BaseParameters<Experiment>,
    ArmLroLocationHeader
  >;

  @doc("Delete a Experiment resource.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Experiment,
    BaseParameters<Experiment>,
    ArmLroLocationHeader
  >;

  @doc("Get a list of Experiment resources in a resource group.")
  list is ArmResourceListByParent<
    Experiment,
    {
      ...BaseParameters<Experiment>;

      @doc("Optional value that indicates whether to filter results based on if the Experiment is currently running. If null, then the results will not be filtered.")
      @query("running")
      running?: boolean;

      @doc("String that sets the continuation token.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;

  @doc("Get a list of Experiment resources in a subscription.")
  listAll is ArmListBySubscription<Experiment>;

  @doc("Cancel a running Experiment resource.")
  cancel is ArmResourceActionNoResponseContentAsync<
    Experiment,
    void,
    BaseParameters<Experiment>,
    ArmLroLocationHeader
  >;

  @doc("Start a Experiment resource.")
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
