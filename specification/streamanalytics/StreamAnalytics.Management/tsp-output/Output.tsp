import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StreamingJob.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StreamAnalytics;
/**
 * An output object, containing all information associated with the named output. All outputs are contained under a streaming job.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(StreamingJob)
@includeInapplicableMetadataInPayload(false)
model Output extends SubResource {
  /**
   * The name of the output.
   */
  @path
  @key("outputName")
  @segment("outputs")
  @visibility("read")
  name: string;

  /**
   * The properties that are associated with an output. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: OutputProperties;
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
    {
      ...BaseParameters<Output>;

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
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    Output,
    Output,
    {
      ...BaseParameters<Output>;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Outputs_ListByStreamingJob")
  listByStreamingJob is ArmResourceListByParent<
    Output,
    {
      ...BaseParameters<Output>;

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
  test is ArmResourceActionAsync<Output, Output, ResourceTestStatus>;
}

@@projectedName(Outputs.createOrReplace::parameters.resource, "json", "output");
@@extension(Outputs.createOrReplace::parameters.resource,
  "x-ms-client-name",
  "output"
);
@@doc(Outputs.createOrReplace::parameters.resource,
  "The definition of the output that will be used to create a new output or replace the existing one under the streaming job."
);
@@projectedName(Outputs.update::parameters.properties, "json", "output");
@@extension(Outputs.update::parameters.properties,
  "x-ms-client-name",
  "output"
);
@@doc(Outputs.update::parameters.properties,
  "An Output object. The properties specified here will overwrite the corresponding properties in the existing output (ie. Those properties will be updated). Any properties that are set to null here will mean that the corresponding property in the existing output will remain the same and not change as a result of this PATCH operation."
);
@@projectedName(Outputs.test::parameters.body, "json", "output");
@@extension(Outputs.test::parameters.body, "x-ms-client-name", "output");
@@doc(Outputs.test::parameters.body,
  "If the output specified does not already exist, this parameter must contain the full output definition intended to be tested. If the output specified already exists, this parameter can be left null to test the existing output as is or if specified, the properties specified will overwrite the corresponding properties in the existing output (exactly like a PATCH operation) and the resulting output will be tested."
);
