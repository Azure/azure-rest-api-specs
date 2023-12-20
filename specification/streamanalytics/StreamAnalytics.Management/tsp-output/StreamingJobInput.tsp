import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./StreamingJob.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.StreamAnalytics;
@doc("An input object, containing all information associated with the named input. All inputs are contained under a streaming job.")
@parentResource(StreamingJob)
model StreamingJobInput is ProxyResource<InputProperties> {
  @doc("The name of the input.")
  @path
  @key("inputName")
  @segment("inputs")
  name: string;
}

@armResourceOperations
interface StreamingJobInputs {
  @doc("Gets details about the specified input.")
  get is ArmResourceRead<StreamingJobInput>;
  @doc("Creates an input or replaces an already existing input under an existing streaming job.")
  createOrReplace is ArmResourceCreateOrReplaceSync<
    StreamingJobInput,
    {
      ...BaseParameters<StreamingJobInput>;

      @doc("The ETag of the input. Omit this value to always overwrite the current input. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;

      @doc("Set to '*' to allow a new input to be created, but to prevent updating an existing input. Other values will result in a 412 Pre-condition Failed response.")
      @header
      IfNoneMatch?: string;
    }
  >;
  @doc("Updates an existing input under an existing streaming job. This can be used to partially update (ie. update one or two properties) an input without affecting the rest the job or input definition.")
  update is ArmResourcePatchSync<
    StreamingJobInput,
    InputProperties,
    {
      ...BaseParameters<StreamingJobInput>;

      @doc("The ETag of the input. Omit this value to always overwrite the current input. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Deletes an input from the streaming job.")
  delete is ArmResourceDeleteSync<StreamingJobInput>;
  @doc("Lists all of the inputs under the specified streaming job.")
  listByStreamingJob is ArmResourceListByParent<
    StreamingJobInput,
    {
      ...BaseParameters<StreamingJobInput>;

      @doc("The $select OData query parameter. This is a comma-separated list of structural properties to include in the response, or \"*\" to include all properties. By default, all properties are returned except diagnostics. Currently only accepts '*' as a valid value.")
      @query("$select")
      $select?: string;
    }
  >;
  @doc("Tests whether an input’s datasource is reachable and usable by the Azure Stream Analytics service.")
  test is ArmResourceActionAsync<
    StreamingJobInput,
    StreamingJobInput,
    ResourceTestStatus
  >;
}
