import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

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
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Experiment>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("The operation to update an experiment.")
  update is ArmCustomPatchAsync<Experiment, ExperimentUpdate>;
  @doc("Delete a Experiment resource.")
  delete is ArmResourceDeleteWithoutOkAsync<Experiment>;
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
  cancel is ArmResourceActionNoResponseContentAsync<Experiment, {}>;
  @doc("Start a Experiment resource.")
  start is ArmResourceActionNoResponseContentAsync<Experiment, {}>;
}
