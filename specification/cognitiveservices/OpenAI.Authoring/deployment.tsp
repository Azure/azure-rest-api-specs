import "@azure-tools/typespec-azure-core";
import "./models/deployment.models.tsp";
import "./serviceCustomizations.tsp";

namespace Azure.OpenAI;

using TypeSpec.Http;
using Azure.Core;

interface Deployments {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
  @summary("Gets the list of deployments owned by the Azure OpenAI resource.")
  @doc("Gets the list of deployments owned by the Azure OpenAI resource.")
  @route("/")
  @get
  // TODO: enum value types not supported in csharp emitter, change string literal to TypeDiscriminatorKnownValues enum when fixed
  listDeployments is ServiceCustomizations.OpenAIListOperation<
    Deployment,
    "deployment"
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing spec"
  @summary("""
Creates a new deployment for the Azure OpenAI resource according to the given
specification.
""")
  @doc("""
Creates a new deployment for the Azure OpenAI resource according to the given
specification.
""")
  createDeployment is CustomResourceCreateWithServiceProvidedName<Deployment>;

  @summary("Gets details for a single deployment specified by the given deployment_id.")
  @doc("Gets details for a single deployment specified by the given deployment_id.")
  getDeployment is ResourceRead<Deployment>;

  @summary("Updates the mutable details of the deployment with the given deployment_id.")
  @doc("Updates the mutable details of the deployment with the given deployment_id.")
  updateDeployment is ResourceCreateOrUpdate<Deployment>;

  @summary("Deletes the deployment specified by the given deployment_id.")
  @doc("Deletes the deployment specified by the given deployment_id.")
  deleteDeployment is ResourceDelete<Deployment>;
}
