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
 * A transformation object, containing all information associated with the named transformation. All transformations are contained under a streaming job.
 */
@parentResource(StreamingJob)
model Transformation
  is Azure.ResourceManager.ProxyResource<TransformationProperties> {
  ...ResourceNameParameter<
    Resource = Transformation,
    KeyName = "transformationName",
    SegmentName = "transformations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Transformations {
  /**
   * Gets details about the specified transformation.
   */
  get is ArmResourceRead<Transformation>;

  /**
   * Creates a transformation or replaces an already existing transformation under an existing streaming job.
   */
  createOrReplace is ArmResourceCreateOrReplaceSync<
    Transformation,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current transformation. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      IfMatch?: string;

      /**
       * Set to '*' to allow a new transformation to be created, but to prevent updating an existing transformation. Other values will result in a 412 Pre-condition Failed response.
       */
      @header
      IfNoneMatch?: string;
    }
  >;

  /**
   * Updates an existing transformation under an existing streaming job. This can be used to partially update (ie. update one or two properties) a transformation without affecting the rest the job or transformation definition.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Transformation,
    PatchModel = Transformation,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current transformation. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      IfMatch?: string;
    }
  >;
}

@@doc(Transformation.name, "The name of the transformation.");
@@doc(Transformation.properties,
  "The properties that are associated with a transformation. Required on PUT (CreateOrReplace) requests."
);
@@doc(Transformations.createOrReplace::parameters.resource,
  "The definition of the transformation that will be used to create a new transformation or replace the existing one under the streaming job."
);
@@doc(Transformations.update::parameters.properties,
  "A Transformation object. The properties specified here will overwrite the corresponding properties in the existing transformation (ie. Those properties will be updated). Any properties that are set to null here will mean that the corresponding property in the existing transformation will remain the same and not change as a result of this PATCH operation."
);
