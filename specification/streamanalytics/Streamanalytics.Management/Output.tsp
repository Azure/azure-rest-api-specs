import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StreamingJob.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StreamAnalytics;
/**
 * An output object, containing all information associated with the named output. All outputs are contained under a streaming job.
 */
@parentResource(StreamingJob)
model Output is Azure.ResourceManager.ProxyResource<OutputProperties> {
  ...ResourceNameParameter<
    Resource = Output,
    KeyName = "outputName",
    SegmentName = "outputs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Outputs {
  /**
   * Gets details about the specified output.
   */
  get is ArmResourceRead<Output>;

  /**
   * Creates an output or replaces an already existing output under an existing streaming job.
   */
  createOrReplace is ArmResourceCreateOrReplaceSync<
    Output,
    Parameters = {
      /**
       * The ETag of the output. Omit this value to always overwrite the current output. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      IfMatch?: string;

      /**
       * Set to '*' to allow a new output to be created, but to prevent updating an existing output. Other values will result in a 412 Pre-condition Failed response.
       */
      @header
      IfNoneMatch?: string;
    }
  >;

  /**
   * Updates an existing output under an existing streaming job. This can be used to partially update (ie. update one or two properties) an output without affecting the rest the job or output definition.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Output,
    PatchModel = Output,
    Parameters = {
      /**
       * The ETag of the output. Omit this value to always overwrite the current output. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      IfMatch?: string;
    }
  >;

  /**
   * Deletes an output from the streaming job.
   */
  delete is ArmResourceDeleteSync<Output>;

  /**
   * Lists all of the outputs under the specified streaming job.
   */
  listByStreamingJob is ArmResourceListByParent<
    Output,
    Parameters = {
      /**
       * The $select OData query parameter. This is a comma-separated list of structural properties to include in the response, or "*" to include all properties. By default, all properties are returned except diagnostics. Currently only accepts '*' as a valid value.
       */
      @query("$select")
      $select?: string;
    }
  >;

  /**
   * Tests whether an output’s datasource is reachable and usable by the Azure Stream Analytics service.
   */
  test is ArmResourceActionAsync<
    Output,
    {
      /**
       * If the output specified does not already exist, this parameter must contain the full output definition intended to be tested. If the output specified already exists, this parameter can be left null to test the existing output as is or if specified, the properties specified will overwrite the corresponding properties in the existing output (exactly like a PATCH operation) and the resulting output will be tested.
       */
      @bodyRoot
      output?: Output;
    },
    ArmResponse<ResourceTestStatus>
  >;
}

@@doc(Output.name, "The name of the output.");
@@doc(Output.properties,
  "The properties that are associated with an output. Required on PUT (CreateOrReplace) requests."
);
@@doc(Outputs.createOrReplace::parameters.resource,
  "The definition of the output that will be used to create a new output or replace the existing one under the streaming job."
);
@@doc(Outputs.update::parameters.properties,
  "An Output object. The properties specified here will overwrite the corresponding properties in the existing output (ie. Those properties will be updated). Any properties that are set to null here will mean that the corresponding property in the existing output will remain the same and not change as a result of this PATCH operation."
);
