import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/models";
using TypeSpec.Http;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/models")
@tag("Models")
interface Models {
  @list
  @get
  @summary("Lists the currently available models, and provides basic information about each one such as the owner and availability.")
  listModels is OpenAIOperation<{}, OpenAI.ListModelsResponse>;

  @route("{model}")
  @delete
  @summary("Delete a fine-tuned model. You must have the Owner role in your organization to delete a model.")
  deleteModel is OpenAIOperation<
    {
      /** The model to delete */
      @path
      `model`: string;
    },
    OpenAI.DeleteModelResponse
  >;

  @route("{model}")
  @get
  @summary("Retrieves a model instance, providing basic information about the model such as the owner and permissioning.")
  retrieveModel is OpenAIOperation<
    {
      /** The ID of the model to use for this request */
      @path
      `model`: string;
    },
    OpenAI.Model
  >;
}
