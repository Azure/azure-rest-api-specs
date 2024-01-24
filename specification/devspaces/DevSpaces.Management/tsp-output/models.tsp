import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DevSpaces;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Provisioning state of the Azure Dev Spaces Controller.
 */
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Updating,
  Creating,
  Deleting,
  Deleted,
}

/**
 * The name of the SKU for Azure Dev Spaces Controller.
 */
enum SkuName {
  S1,
}

/**
 * The tier of the SKU for Azure Dev Spaces Controller.
 */
enum SkuTier {
  Standard,
}

/**
 * Container host mapping object specifying the Container host resource ID and its associated Controller resource.
 */
model ContainerHostMapping {
  /**
   * ARM ID of the Container Host resource
   */
  containerHostResourceId?: string;

  /**
   * ARM ID of the mapped Controller resource
   */
  @visibility("read")
  mappedControllerResourceId?: string;
}

/**
 * Error response indicates that the service is not able to process the incoming request. The reason is provided in the error message.
 */
@error
model DevSpacesErrorResponse {
  /**
   * The details of the error.
   */
  error?: ErrorDetails;
}

model ErrorDetails {
  /**
   * Status code for the error.
   */
  @visibility("read")
  code?: string;

  /**
   * Error message describing the error in detail.
   */
  @visibility("read")
  message?: string;

  /**
   * The target of the particular error.
   */
  @visibility("read")
  target?: string;
}

model ResourceProviderOperationDefinition {
  /**
   * Resource provider operation name.
   */
  name?: string;

  display?: ResourceProviderOperationDisplay;
}

model ResourceProviderOperationDisplay {
  /**
   * Name of the resource provider.
   */
  provider?: string;

  /**
   * Name of the resource type.
   */
  resource?: string;

  /**
   * Name of the resource provider operation.
   */
  operation?: string;

  /**
   * Description of the resource provider operation.
   */
  description?: string;
}

model ControllerProperties {
  /**
   * Provisioning state of the Azure Dev Spaces Controller.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * DNS suffix for public endpoints running in the Azure Dev Spaces Controller.
   */
  @visibility("read")
  hostSuffix?: string;

  /**
   * DNS name for accessing DataPlane services
   */
  @visibility("read")
  dataPlaneFqdn?: string;

  /**
   * DNS of the target container host's API server
   */
  @visibility("read")
  targetContainerHostApiServerFqdn?: string;

  /**
   * Resource ID of the target container host
   */
  @visibility("read", "create")
  targetContainerHostResourceId: string;

  /**
   * Credentials of the target container host (base64).
   */
  @visibility("create")
  targetContainerHostCredentialsBase64: string;
}

/**
 * Model representing SKU for Azure Dev Spaces Controller.
 */
model Sku {
  /**
   * The name of the SKU for Azure Dev Spaces Controller.
   */
  name: SkuName;

  /**
   * The tier of the SKU for Azure Dev Spaces Controller.
   */
  tier?: SkuTier;
}

/**
 * An Azure resource.
 */
model Resource {
  /**
   * Fully qualified resource Id for the resource.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility("read")
  type?: string;
}

/**
 * Parameters for updating an Azure Dev Spaces Controller.
 */
model ControllerUpdateParameters {
  /**
   * Tags for the Azure Dev Spaces Controller.
   */
  tags?: Record<string>;

  @extension("x-ms-client-flatten", true)
  properties?: ControllerUpdateParametersProperties;
}

model ControllerUpdateParametersProperties {
  /**
   * Credentials of the target container host (base64).
   */
  targetContainerHostCredentialsBase64?: string;
}

/**
 * Parameters for listing connection details of an Azure Dev Spaces Controller.
 */
model ListConnectionDetailsParameters {
  /**
   * Resource ID of the target container host mapped to the Azure Dev Spaces Controller.
   */
  targetContainerHostResourceId: string;
}

model ControllerConnectionDetailsList {
  /**
   * List of Azure Dev Spaces Controller connection details.
   */
  connectionDetailsList?: ControllerConnectionDetails[];
}

model ControllerConnectionDetails {
  /**
   * Base class for types that supply values used to connect to container orchestrators
   */
  orchestratorSpecificConnectionDetails?: OrchestratorSpecificConnectionDetails;
}

/**
 * Base class for types that supply values used to connect to container orchestrators
 */
@discriminator("instanceType")
model OrchestratorSpecificConnectionDetails {}

/**
 * Contains information used to connect to a Kubernetes cluster
 */
model KubernetesConnectionDetails
  extends OrchestratorSpecificConnectionDetails {
  /**
   * Gets the kubeconfig for the cluster.
   */
  kubeConfig?: string;

  /**
   * Gets the Instance type.
   */
  instanceType: "Kubernetes";
}
