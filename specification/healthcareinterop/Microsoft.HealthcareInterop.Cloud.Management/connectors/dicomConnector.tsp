import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./../common/provisioningState.tsp";
import "./../common/resourceIds.tsp";
import "./../../Microsoft.HealthcareInterop.Edge.Management/common/models/requirements.tsp";
import "./../../Microsoft.HealthcareInterop.Edge.Management/common/models/dicomModels.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.HealthcareInterop;

@added(Versions.v2025_06_01_preview)
@doc("The healthcare interop DICOM connector resource that reads healthcare images from on-prem systems which is processed by the healthcare interop channel resource(s) associated with this connector.")
@resource("dicomConnectors")
model DicomConnector is TrackedResource<DicomConnectorProperties> {
  @doc("The name of the Dicom connector resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("dicomConnectorName")
  @segment("dicomConnectors")
  @path
  name: string;
}

@added(Versions.v2025_06_01_preview)
@doc("The properties to configure the DICOM connector resource.")
model DicomConnectorProperties {
  @doc("The status of the last provisioning operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningLROState;

  @doc("The resource ID of an existing hub resource to link/associate this dicomConnector resource to.")
  hubResourceId: HubResourceId;

  @doc("The resource ID of the remote connector environment connected cluster where the connector will be deployed.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  connectedClusterId: ConnectedClusterResourceId;

  @doc("The receiver configuration to be used for the DICOM connector.")
  receiver?: {
    @added(Versions.v2025_06_01_preview)
    @doc("The listener configuration to be used for DICOM connector.")
    dicomListenerConfiguration: DicomListenerConfiguration;

    @doc("The resource requirements for the application (CPU, Memory, and Storage).")
    requirements?: Requirements;
  };

  @visibility(Lifecycle.Read)
  @doc("The resource ID of the dicomEdgeConnector resource managed by this resource.")
  managedDicomEdgeConnectorResourceId?: DicomEdgeConnectorResourceId;
}

@added(Versions.v2025_06_01_preview)
@armResourceOperations
interface DicomConnectors {
  get is ArmResourceRead<DicomConnector>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DicomConnector>;
  update is ArmResourcePatchAsync<DicomConnector, DicomConnectorProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<DicomConnector>;
  listByResourceGroup is ArmResourceListByParent<DicomConnector>;
  listBySubscription is ArmListBySubscription<DicomConnector>;
}
