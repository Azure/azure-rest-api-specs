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
/**
 * IoT Connector FHIR destination definition.
 */
@parentResource(IotConnector)
model IotFhirDestination is ProxyResource<IotFhirDestinationProperties> {
  /**
   * The name of IoT Connector FHIR destination resource.
   */
  @maxLength(24)
  @minLength(3)
  @path
  @key("fhirDestinationName")
  @segment("fhirdestinations")
  name: string;
}

@armResourceOperations
interface IotFhirDestinations {
  /**
   * Gets the properties of the specified Iot Connector FHIR destination.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotConnectorFhirDestination_Get")
  get is ArmResourceRead<IotFhirDestination>;

  /**
   * Creates or updates an IoT Connector FHIR destination resource with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotConnectorFhirDestination_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<IotFhirDestination>;

  /**
   * Deletes an IoT Connector FHIR destination.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotConnectorFhirDestination_Delete")
  delete is ArmResourceDeleteAsync<IotFhirDestination>;

  /**
   * Lists all FHIR destinations for the given IoT Connector
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
