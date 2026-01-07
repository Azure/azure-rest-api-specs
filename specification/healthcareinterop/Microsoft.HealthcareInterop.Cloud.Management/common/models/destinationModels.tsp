import "@typespec/versioning";
import "../resourceIds.tsp";

using TypeSpec.Versioning;

@versioned(Microsoft.HealthcareInterop.Versions)
namespace Microsoft.HealthcareInterop;

@doc("The destination configuration for the FHIR query batch based channel resources.")
@discriminator("connectorType")
model FhirQueryBatchChannelDestinationProperties {
  @doc("The type of destination connector.")
  connectorType: FhirQueryBatchChannelDestinationConnectorType;
}

@doc("Types of destination connectors supported for the FHIR query batch based channel resources.")
union FhirQueryBatchChannelDestinationConnectorType {
  string,

  @doc("Storage Account destination connector.")
  StorageAccountConnector: "StorageAccountConnector",

  @doc("One Lake destination connector.")
  OneLakeConnector: "OneLakeConnector",
}

@doc("StorageAccountConnector destination properties.")
model FhirQueryBatchStorageAccountConnectorDestinationProperties
  extends FhirQueryBatchChannelDestinationProperties {
  @doc("The type of destination connector to be used for the channel.")
  connectorType: FhirQueryBatchChannelDestinationConnectorType.StorageAccountConnector;

  @doc("The resource ID of an existing storageAccountConnector resource linked/associated to the same hub resource, to use as destination.")
  storageAccountConnectorResourceId: StorageAccountConnectorResourceId;
}

@doc("OneLakeConnector destination properties.")
model FhirQueryBatchOneLakeConnectorDestinationProperties
  extends FhirQueryBatchChannelDestinationProperties {
  @doc("The type of destination connector to be used for the channel.")
  connectorType: FhirQueryBatchChannelDestinationConnectorType.OneLakeConnector;

  @doc("The resource ID of an existing oneLakeConnector resource linked/associated to the same hub resource, to use as destination.")
  oneLakeConnectorResourceId: OneLakeConnectorResourceId;
}
