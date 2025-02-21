import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Contains metadata of a diagnostic type
 */
@singleton("diskInspection")
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model ComputeDiagnosticBase
  is Azure.ResourceManager.ProxyResource<DiagnosticProperties> {
  ...ResourceNameParameter<
    Resource = ComputeDiagnosticBase,
    KeyName = "diagnostic",
    SegmentName = "diagnostics",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ComputeDiagnosticBases {
  /**
   * Gets a specific Compute diagnostic for a subscription in a location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiskInspection_Get")
  get is ArmResourceRead<
    ComputeDiagnosticBase,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Lists all available Compute diagnostics for a subscription in a location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_List")
  list is ArmResourceListByParent<
    ComputeDiagnosticBase,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ComputeDiagnosticsList
  >;

  /**
   * Creates a request for executing disk Inspection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiskInspection_Create")
  create is ArmResourceActionNoResponseContentAsync<
    ComputeDiagnosticBase,
    RunDiskInspectionInput,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Register a storageAccount for a subscription used for DiskInspection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiskInspectionStorageConfiguration_Register")
  register is ArmResourceActionSync<
    ComputeDiagnosticBase,
    StorageConfigurationInput,
    void,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Validate if a storageAccount configuration exists for a subscription used for DiskInspection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiskInspectionStorageConfiguration_Validate")
  validate is ArmResourceActionSync<
    ComputeDiagnosticBase,
    void,
    StorageConfigurationResponse,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(ComputeDiagnosticBase.name, "");
@@doc(ComputeDiagnosticBase.properties,
  "Contains additional properties of a diagnostic"
);
@@doc(ComputeDiagnosticBases.create::parameters.body,
  "RunDiskInspection object supplied in the body of the Post run disk inspection operation."
);
@@doc(ComputeDiagnosticBases.register::parameters.body,
  "Storage Configuration object supplied in the body of the Post to cache storageAccount for a given subscription."
);
@@doc(ComputeDiagnosticsList.value,
  "The collection of available Compute diagnostics returned by the listing operation."
);
@@doc(ComputeDiagnosticsList.nextLink, "The continuation token.");
