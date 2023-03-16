import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./models/model.models.tsp";
import "./serviceCustomizations.tsp";

namespace Azure.OpenAI;

using Cadl.Rest;
using Cadl.Http;
using Azure.Core;

interface Models {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
  @summary("""
Gets a list of all models that are accessible by the Azure OpenAI
resource.
These include base models as well as all successfully completed
fine-tuned models owned by the Azure OpenAI resource.
""")
  @doc("""
Gets a list of all models that are accessible by the Azure OpenAI
resource.
These include base models as well as all successfully completed
fine-tuned models owned by the Azure OpenAI resource.
""")
  @route("/models")
  @get
  // TODO: enum value types not supported in csharp emitter, change string literal to TypeDiscriminatorKnownValues enum when fixed
  ListModels is ServiceCustomizations.OpenAIListOperation<Model, "model">;

  @summary("Gets details for the model specified by the given model_id.")
  @doc("Gets details for the model specified by the given model_id.")
  GetModel is ResourceRead<Model>;
}
