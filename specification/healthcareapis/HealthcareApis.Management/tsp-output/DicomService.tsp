import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HealthcareApis;
@doc("The description of Dicom Service")
@parentResource(Workspace)
model DicomService is TrackedResource<DicomServiceProperties> {
  @doc("The name of DICOM Service resource.")
  @maxLength(24)
  @minLength(3)
  @key("dicomServiceName")
  @segment("dicomservices")
  name: string;
}

@armResourceOperations
interface DicomServices {
  @doc("Gets the properties of the specified DICOM Service.")
  get is ArmResourceRead<DicomService>;

  @doc("Creates or updates a DICOM Service resource with the specified parameters.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DicomService>;

  @doc("Patch DICOM Service details.")
  update is ArmCustomPatchAsync<DicomService, DicomServicePatchResource>;

  @doc("Deletes a DICOM Service.")
  delete is ArmResourceDeleteAsync<DicomService>;

  @doc("Lists all DICOM Services for the given workspace")
  listByWorkspace is ArmResourceListByParent<DicomService>;
}
