import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DevSpaces;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning state of the Azure Dev Spaces Controller.")
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Updating,
  Creating,
  Deleting,
  Deleted,
}

@doc("The name of the SKU for Azure Dev Spaces Controller.")
enum SkuName {
  S1,
}

@doc("Container host mapping object specifying the Container host resource ID and its associated Controller resource.")
model ContainerHostMapping {
  @doc("ARM ID of the Container Host resource")
  containerHostResourceId?: string;

  @doc("ARM ID of the mapped Controller resource")
  @visibility("read")
  mappedControllerResourceId?: string;
}

@doc("Error response indicates that the service is not able to process the incoming request. The reason is provided in the error message.")
@error
model DevSpacesErrorResponse {
  @doc("The details of the error.")
  error?: ErrorDetails;
}

model ErrorDetails {
  @doc("Status code for the error.")
  @visibility("read")
  code?: string;

  @doc("Error message describing the error in detail.")
  @visibility("read")
  message?: string;

  @doc("The target of the particular error.")
  @visibility("read")
  target?: string;
}

model ResourceProviderOperationDefinition {
  @doc("Resource provider operation name.")
  name?: string;

  display?: ResourceProviderOperationDisplay;
}

model ResourceProviderOperationDisplay {
  @doc("Name of the resource provider.")
  provider?: string;

  @doc("Name of the resource type.")
  resource?: string;

  @doc("Name of the resource provider operation.")
  operation?: string;

  @doc("Description of the resource provider operation.")
  description?: string;
}

model ControllerProperties {
  @doc("Provisioning state of the Azure Dev Spaces Controller.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("DNS suffix for public endpoints running in the Azure Dev Spaces Controller.")
  @visibility("read")
  hostSuffix?: string;

  @doc("DNS name for accessing DataPlane services")
  @visibility("read")
  dataPlaneFqdn?: string;

  @doc("DNS of the target container host's API server")
  @visibility("read")
  targetContainerHostApiServerFqdn?: string;

  @doc("Resource ID of the target container host")
  @visibility("read", "create")
  targetContainerHostResourceId: string;

  @doc("Credentials of the target container host (base64).")
  @visibility("create")
  targetContainerHostCredentialsBase64: string;
}

@doc("Model representing SKU for Azure Dev Spaces Controller.")
model Sku {
  @doc("The name of the SKU for Azure Dev Spaces Controller.")
  name: SkuName;

  @doc("The tier of the SKU for Azure Dev Spaces Controller.")
  tier?: SkuTier;
}

@doc("An Azure resource.")
model Resource {
  @doc("Fully qualified resource Id for the resource.")
  @visibility("read")
  id?: string;

  @doc("The name of the resource.")
  @visibility("read")
  name?: string;

  @doc("The type of the resource.")
  @visibility("read")
  type?: string;
}

@doc("Parameters for updating an Azure Dev Spaces Controller.")
model ControllerUpdateParameters {
  @doc("Tags for the Azure Dev Spaces Controller.")
  tags?: Record<string>;

  properties?: ControllerUpdateParametersProperties;
}

model ControllerUpdateParametersProperties {
  @doc("Credentials of the target container host (base64).")
  targetContainerHostCredentialsBase64?: string;
}

@doc("Parameters for listing connection details of an Azure Dev Spaces Controller.")
model ListConnectionDetailsParameters {
  @doc("Resource ID of the target container host mapped to the Azure Dev Spaces Controller.")
  targetContainerHostResourceId: string;
}

model ControllerConnectionDetailsList {
  @doc("List of Azure Dev Spaces Controller connection details.")
  connectionDetailsList?: ControllerConnectionDetails[];
}

model ControllerConnectionDetails {
  @doc("Base class for types that supply values used to connect to container orchestrators")
  orchestratorSpecificConnectionDetails?: OrchestratorSpecificConnectionDetails;
}

@doc("Base class for types that supply values used to connect to container orchestrators")
@discriminator("instanceType")
model OrchestratorSpecificConnectionDetails {}

@doc("Contains information used to connect to a Kubernetes cluster")
model KubernetesConnectionDetails
  extends OrchestratorSpecificConnectionDetails {
  @doc("Gets the kubeconfig for the cluster.")
  kubeConfig?: string;

  @doc("Gets the Instance type.")
  instanceType: "Kubernetes";
}
