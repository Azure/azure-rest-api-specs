import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./HealthcareApisIotConnector.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HealthcareApis;
@doc("IoT Connector FHIR destination definition.")
@parentResource(HealthcareApisIotConnector)
model HealthcareApisIotFhirDestination
  is ProxyResource<IotFhirDestinationProperties> {
  @doc("The name of IoT Connector FHIR destination resource.")
  @maxLength(24)
  @minLength(3)
  @path
  @key("fhirDestinationName")
  @segment("fhirdestinations")
  name: string;
}

@armResourceOperations
interface HealthcareApisIotFhirDestinations {
  @doc("Gets the properties of the specified Iot Connector FHIR destination.")
  get is ArmResourceRead<HealthcareApisIotFhirDestination>;
  @doc("Creates or updates an IoT Connector FHIR destination resource with the specified parameters.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<HealthcareApisIotFhirDestination>;
  @doc("Deletes an IoT Connector FHIR destination.")
  delete is ArmResourceDeleteAsync<HealthcareApisIotFhirDestination>;
  @doc("Lists all FHIR destinations for the given IoT Connector")
  listByIotConnector is ArmResourceListByParent<HealthcareApisIotFhirDestination>;
}
