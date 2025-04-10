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
@parentResource(Workspace)
model DicomService
  is Azure.ResourceManager.TrackedResource<DicomServiceProperties> {
  ...ResourceNameParameter<
    Resource = DicomService,
    KeyName = "dicomServiceName",
    SegmentName = "dicomservices",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DicomServices {
  /**
   * Gets the properties of the specified DICOM Service.
   */
  get is ArmResourceRead<DicomService>;

  /**
   * Creates or updates a DICOM Service resource with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DicomService,
    Response = ArmResourceUpdatedResponse<DicomService> | ArmResourceCreatedResponse<
      DicomService,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: DicomService;
    })
  >;

  /**
   * Patch DICOM Service details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DicomService,
    PatchModel = DicomServicePatchResource,
    Response = ArmResponse<DicomService> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: DicomService;
    })
  >;

  /**
   * Deletes a DICOM Service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    DicomService,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all DICOM Services for the given workspace
   */
  listByWorkspace is ArmResourceListByParent<
    DicomService,
    Response = ArmResponse<DicomServiceCollection>
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
