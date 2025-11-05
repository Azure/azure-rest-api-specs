import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./ImportPipeline.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.ContainerRegistry;
/**
 * An object that represents an import pipeline for a container registry.
 */
@added(Versions.vLatestPreview)
@parentResource(Registry)
model ImportPipeline
  is Azure.ResourceManager.ProxyResource<ImportPipelineProperties> {
  ...ResourceNameParameter<
    Resource = ImportPipeline,
    KeyName = "importPipelineName",
    SegmentName = "importPipelines",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;

  /**
   * The location of the import pipeline.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;

  /**
   * The identity of the import pipeline.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: IdentityProperties;
}

@added(Versions.vLatestPreview)
@armResourceOperations
interface ImportPipelines {
  /**
   * Gets the properties of the import pipeline.
   */
  get is ArmResourceRead<ImportPipeline>;

  /**
   * Creates an import pipeline for a container registry with the specified parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<ImportPipeline>;

  /**
   * Deletes an import pipeline from a container registry.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ImportPipeline,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all import pipelines for the specified container registry.
   */
  @list
  list is ArmResourceListByParent<
    ImportPipeline,
    Response = ArmResponse<ImportPipelineListResult>
  >;
}

@@maxLength(ImportPipeline.name, 50);
@@minLength(ImportPipeline.name, 5);
@@doc(ImportPipeline.name, "The name of the import pipeline.");
@@doc(ImportPipeline.properties, "The properties of the import pipeline.");
@@doc(ImportPipelines.create::parameters.resource,
  "The parameters for creating an import pipeline."
);
