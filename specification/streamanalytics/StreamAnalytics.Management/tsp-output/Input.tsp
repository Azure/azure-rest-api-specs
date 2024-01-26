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
 * An input object, containing all information associated with the named input. All inputs are contained under a streaming job.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(StreamingJob)
@includeInapplicableMetadataInPayload(false)
model Input extends SubResource {
  /**
   * The name of the input.
   */
  @path
  @key("inputName")
  @segment("inputs")
  @visibility("read")
  name: string;

  /**
   * The properties that are associated with an input. Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: InputProperties;
}

@armResourceOperations
interface Inputs {
  /**
   * Gets details about the specified input.
   */
  get is ArmResourceRead<Input>;

  /**
   * Creates an input or replaces an already existing input under an existing streaming job.
   */
  createOrReplace is ArmResourceCreateOrReplaceSync<
    Input,
    {
      ...BaseParameters<Input>;

      /**
       * The ETag of the input. Omit this value to always overwrite the current input. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      IfMatch?: string;

      /**
       * Set to '*' to allow a new input to be created, but to prevent updating an existing input. Other values will result in a 412 Pre-condition Failed response.
       */
      @header
      IfNoneMatch?: string;
    }
  >;

  /**
   * Updates an existing input under an existing streaming job. This can be used to partially update (ie. update one or two properties) an input without affecting the rest the job or input definition.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    Input,
    Input,
    {
      ...BaseParameters<Input>;

      /**
       * The ETag of the input. Omit this value to always overwrite the current input. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      IfMatch?: string;
    }
  >;

  /**
   * Deletes an input from the streaming job.
   */
  delete is ArmResourceDeleteSync<Input>;

  /**
   * Lists all of the inputs under the specified streaming job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Inputs_ListByStreamingJob")
  listByStreamingJob is ArmResourceListByParent<
    Input,
    {
      ...BaseParameters<Input>;

      /**
       * The $select OData query parameter. This is a comma-separated list of structural properties to include in the response, or "*" to include all properties. By default, all properties are returned except diagnostics. Currently only accepts '*' as a valid value.
       */
      @query("$select")
      $select?: string;
    }
  >;

  /**
   * Tests whether an input’s datasource is reachable and usable by the Azure Stream Analytics service.
   */
  test is ArmResourceActionAsync<Input, Input, ResourceTestStatus>;
}

@@projectedName(Inputs.createOrReplace::parameters.resource, "json", "input");
@@extension(Inputs.createOrReplace::parameters.resource,
  "x-ms-client-name",
  "input"
);
@@doc(Inputs.createOrReplace::parameters.resource,
  "The definition of the input that will be used to create a new input or replace the existing one under the streaming job."
);
@@projectedName(Inputs.update::parameters.properties, "json", "input");
@@extension(Inputs.update::parameters.properties, "x-ms-client-name", "input");
@@doc(Inputs.update::parameters.properties,
  "An Input object. The properties specified here will overwrite the corresponding properties in the existing input (ie. Those properties will be updated). Any properties that are set to null here will mean that the corresponding property in the existing input will remain the same and not change as a result of this PATCH operation."
);
@@projectedName(Inputs.test::parameters.body, "json", "input");
@@extension(Inputs.test::parameters.body, "x-ms-client-name", "input");
@@doc(Inputs.test::parameters.body,
  "If the input specified does not already exist, this parameter must contain the full input definition intended to be tested. If the input specified already exists, this parameter can be left null to test the existing input as is or if specified, the properties specified will overwrite the corresponding properties in the existing input (exactly like a PATCH operation) and the resulting input will be tested."
);
