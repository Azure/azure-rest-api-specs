import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/models/extendedLocation.tsp";
import "./common/models/requirements.tsp";
import "./common/models/dicomModels.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.HealthcareInterop;

@added(Versions.v2025_06_01_preview)
@doc("The healthcare interop DicomEdgeConnector resource.")
model DicomEdgeConnector is TrackedResource<DicomEdgeConnectorProperties> {
  @doc("The name of the dicom edge connector")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("dicomEdgeConnectorName")
  @segment("dicomEdgeConnectors")
  @path
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("The extended location.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  extendedLocation: ExtendedLocation;
}

@added(Versions.v2025_06_01_preview)
@doc("DicomEdgeConnector properties")
model DicomEdgeConnectorProperties {
  @doc("The Receiver Configuration to be used for dicom connector configuration.")
  receiver?: {
    @added(Versions.v2025_06_01_preview)
    @doc("The Listener Configuration to be used for dicom connector configuration.")
    @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
    dicomListenerConfiguration: DicomListenerConfiguration;

    @doc("The resource requirements for the application (CPU, Memory, and Storage).")
    requirements?: Requirements;

    @doc("The Storage Endpoint Configuration to be used for dicom connector configuration.")
    @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
    storageEndpointConfiguration?: {
      @doc("URL of the storage endpoint where the output will be stored.")
      @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
      @pattern("^https://.*$")
      endpoint: string;

      @doc("Name of the container in the blob storage.")
      @pattern("^[a-z0-9](?!.*--)[a-z0-9-]{1,61}[a-z0-9]$")
      @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
      container: string;

      @doc("Format for the output folder.")
      @maxLength(255)
      outputFolderFormat?: string;
    };
  };

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2025_06_01_preview)
@armResourceOperations
interface DicomEdgeConnectors {
  get is ArmResourceRead<DicomEdgeConnector>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DicomEdgeConnector>;
  update is ArmResourcePatchAsync<
    DicomEdgeConnector,
    DicomEdgeConnectorProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DicomEdgeConnector>;
  listByResourceGroup is ArmResourceListByParent<DicomEdgeConnector>;
  listBySubscription is ArmListBySubscription<DicomEdgeConnector>;
}
