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
@doc("An output object, containing all information associated with the named output. All outputs are contained under a streaming job.")
@parentResource(StreamingJob)
model Output is ProxyResource<OutputProperties> {
  @doc("The name of the output.")
  @key("outputName")
  @segment("outputs")
  name: string;
}

@armResourceOperations
interface Outputs {
  @doc("Gets details about the specified output.")
  get is ArmResourceRead<Output>;
  @doc("Creates an output or replaces an already existing output under an existing streaming job.")
  createOrReplace is ArmResourceCreateOrReplaceSync<
    Output,
    {
      ...BaseParameters<Output>;

      @doc("The ETag of the output. Omit this value to always overwrite the current output. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;

      @doc("Set to '*' to allow a new output to be created, but to prevent updating an existing output. Other values will result in a 412 Pre-condition Failed response.")
      @header
      IfNoneMatch?: string;
    }
  >;
  @doc("Updates an existing output under an existing streaming job. This can be used to partially update (ie. update one or two properties) an output without affecting the rest the job or output definition.")
  update is ArmCustomPatchSync<
    Output,
    Output,
    {
      ...BaseParameters<Output>;

      @doc("The ETag of the output. Omit this value to always overwrite the current output. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Deletes an output from the streaming job.")
  delete is ArmResourceDeleteSync<Output>;
  @doc("Lists all of the outputs under the specified streaming job.")
  listByStreamingJob is ArmResourceListByParent<
    Output,
    {
      ...BaseParameters<Output>;

      @doc("The $select OData query parameter. This is a comma-separated list of structural properties to include in the response, or \"*\" to include all properties. By default, all properties are returned except diagnostics. Currently only accepts '*' as a valid value.")
      @query("$select")
      $select?: string;
    }
  >;
  @doc("Tests whether an output’s datasource is reachable and usable by the Azure Stream Analytics service.")
  test is ArmResourceActionAsync<Output, Output, ResourceTestStatus>;
}
