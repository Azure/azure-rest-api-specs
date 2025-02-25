import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Unified;

interface Models {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get a deployed model.")
  @route("/models/{name}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the model container.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;
    },
    Model
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List all deployed models in the project.")
  @route("/models")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Model publisher to filter models by")
      @query("$modelPublisher")
      modelPublisher: string,

      @doc("Model name (the publisher specific name) to filter models by")
      @query("$modelName")
      modelName: string,

      @doc("Flag to include models from connections in response. Accepted values are 'true' and 'false'")
      @query("$includeConnectionModels")
      includeConnectionModels: string,

      ...StandardListQueryParameters;
    },
    Model
  >;
}
