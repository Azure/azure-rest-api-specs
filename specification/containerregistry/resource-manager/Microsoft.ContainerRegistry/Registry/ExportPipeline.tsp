import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./ExportPipeline.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.ContainerRegistry;
/**
 * An object that represents an export pipeline for a container registry.
 */
@added(Versions.vLatestPreview)
@parentResource(Registry)
model ExportPipeline
  is Azure.ResourceManager.ProxyResource<ExportPipelineProperties> {
  ...ResourceNameParameter<
    Resource = ExportPipeline,
    KeyName = "exportPipelineName",
    SegmentName = "exportPipelines",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;

  /**
   * The location of the export pipeline.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;

  /**
   * The identity of the export pipeline.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: IdentityProperties;
}

@added(Versions.vLatestPreview)
@armResourceOperations
interface ExportPipelines {
  /**
   * Gets the properties of the export pipeline.
   */
  get is ArmResourceRead<ExportPipeline>;

  /**
   * Creates an export pipeline for a container registry with the specified parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<ExportPipeline>;

  /**
   * Deletes an export pipeline from a container registry.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ExportPipeline,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all export pipelines for the specified container registry.
   */
  @list
  list is ArmResourceListByParent<
    ExportPipeline,
    Response = ArmResponse<ExportPipelineListResult>
  >;
}

@@maxLength(ExportPipeline.name, 50);
@@minLength(ExportPipeline.name, 5);
@@doc(ExportPipeline.name, "The name of the export pipeline.");
@@doc(ExportPipeline.properties, "The properties of the export pipeline.");
@@doc(ExportPipelines.create::parameters.resource,
  "The parameters for creating an export pipeline."
);
