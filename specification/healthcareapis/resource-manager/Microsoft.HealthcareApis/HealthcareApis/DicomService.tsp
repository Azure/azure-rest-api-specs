import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HealthcareApis;
/**
 * The description of Dicom Service
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Workspace)
model DicomService
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<DicomServiceProperties> {
  ...ResourceNameParameter<
    Resource = DicomService,
    KeyName = "dicomServiceName",
    SegmentName = "dicomservices",
    NamePattern = ""
  >;

  /**
   * An etag associated with the resource, used for optimistic concurrency when editing it.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface DicomServices {
  /**
   * Gets the properties of the specified DICOM Service.
   */
  get is ArmResourceRead<DicomService, Error = ErrorDetails>;

  /**
   * Creates or updates a DICOM Service resource with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DicomService,
    Response = ArmResourceUpdatedResponse<DicomService> | ArmResourceCreatedResponse<
      DicomService,
      ArmLroLocationHeader<FinalResult = DicomService> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: DicomService;
    }),
    Error = ErrorDetails
  >;

  /**
   * Patch DICOM Service details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DicomService,
    PatchModel = DicomServicePatchResource,
    Response = ArmResponse<DicomService> | (ArmAcceptedLroResponse<
      "Resource update request accepted.",
      LroHeaders = ArmLroLocationHeader<FinalResult = DicomService> &
        Azure.Core.Foundations.RetryAfterHeader
    > & {
      @bodyRoot
      _: DicomService;
    }),
    Error = ErrorDetails
  >;

  /**
   * Deletes a DICOM Service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    DicomService,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = Error
  >;

  /**
   * Lists all DICOM Services for the given workspace
   */
  listByWorkspace is ArmResourceListByParent<
    DicomService,
    Response = ArmResponse<DicomServiceCollection>,
    Error = ErrorDetails
  >;
}

@@maxLength(DicomService.name, 24);
@@minLength(DicomService.name, 3);
@@doc(DicomService.name, "The name of DICOM Service resource.");
@@doc(DicomService.properties, "Dicom Service configuration.");
@@doc(DicomServices.createOrUpdate::parameters.resource,
  "The parameters for creating or updating a Dicom Service resource."
);
@@doc(DicomServices.update::parameters.properties,
  "The parameters for updating a Dicom Service."
);
