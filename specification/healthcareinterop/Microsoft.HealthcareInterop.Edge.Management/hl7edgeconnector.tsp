import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/models/extendedLocation.tsp";
import "./common/models/requirements.tsp";
import "./common/models/hl7Models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.HealthcareInterop;

@doc("The healthcare interop Hl7EdgeConnector resource.")
model Hl7EdgeConnector is TrackedResource<Hl7EdgeConnectorProperties> {
  @doc("The name of the hl7 edge connector")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("hl7EdgeConnectorName")
  @segment("hl7EdgeConnectors")
  @path
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("The extended location.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  extendedLocation: ExtendedLocation;
}

@doc("Hl7EdgeConnector properties")
model Hl7EdgeConnectorProperties {
  @doc("The Receiver Configuration to be used for hl7 connector configuration.")
  receiver?: {
    @doc("Settings used to customize how HL7 messages are read.")
    hl7Configuration?: Hl7Configuration;

    @doc("The Listener Configuration to be used for hl7 connector configuration.")
    @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
    messageListenerConfiguration: MessageListenerConfiguration;

    @doc("The resource requirements for the application (CPU, Memory, and Storage).")
    requirements?: Requirements;

    @doc("The Storage Endpoint Configuration to be used for hl7 connector configuration.")
    @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
    storageEndpointConfiguration: {
      @doc("URL of the storage endpoint where the output will be stored.")
      @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
      @pattern("^https://.*$")
      endpoint: string;

      @doc("Name of the container in the blob storage.")
      @pattern("^[a-z0-9](?!.*--)[a-z0-9-]{1,61}[a-z0-9]$")
      @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
      container: string;

      @doc("Optional file extension for the output file.")
      @pattern("^[a-zA-Z0-9]+$")
      fileExtension?: string;

      @doc("Optional format for the output file name.")
      @maxLength(255)
      outputFileNameFormat?: string;

      @doc("Optional format for the output folder.")
      @maxLength(255)
      outputFolderFormat?: string;
    };
  };

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Hl7EdgeConnectors {
  get is ArmResourceRead<Hl7EdgeConnector>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Hl7EdgeConnector>;
  update is ArmResourcePatchAsync<Hl7EdgeConnector, Hl7EdgeConnectorProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Hl7EdgeConnector>;
  listByResourceGroup is ArmResourceListByParent<Hl7EdgeConnector>;
  listBySubscription is ArmListBySubscription<Hl7EdgeConnector>;
}
