import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IotConnector.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HealthcareApis;
@doc("IoT Connector FHIR destination definition.")
@parentResource(IotConnector)
model IotFhirDestination is ProxyResource<IotFhirDestinationProperties> {
  @doc("The name of IoT Connector FHIR destination resource.")
  @maxLength(24)
  @minLength(3)
  @path
  @key("fhirDestinationName")
  @segment("fhirdestinations")
  name: string;
}

@armResourceOperations
interface IotFhirDestinations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the properties of the specified Iot Connector FHIR destination.")
  @operationId("IotConnectorFhirDestination_Get")
  get is ArmResourceRead<IotFhirDestination>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates an IoT Connector FHIR destination resource with the specified parameters.")
  @operationId("IotConnectorFhirDestination_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<IotFhirDestination>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an IoT Connector FHIR destination.")
  @operationId("IotConnectorFhirDestination_Delete")
  delete is ArmResourceDeleteAsync<IotFhirDestination>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all FHIR destinations for the given IoT Connector")
  @operationId("FhirDestinations_ListByIotConnector")
  listByIotConnector is ArmResourceListByParent<IotFhirDestination>;
}

@@projectedName(IotFhirDestinations.createOrUpdate::parameters.resource,
  "json",
  "iotFhirDestination"
);
@@extension(IotFhirDestinations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "iotFhirDestination"
);
@@doc(IotFhirDestinations.createOrUpdate::parameters.resource,
  "The parameters for creating or updating an IoT Connector FHIR destination resource."
);
