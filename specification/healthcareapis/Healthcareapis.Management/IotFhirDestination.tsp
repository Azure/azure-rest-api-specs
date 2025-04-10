import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IotConnector.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HealthcareApis;
/**
 * IoT Connector FHIR destination definition.
 */
@parentResource(IotConnector)
model IotFhirDestination
  is Azure.ResourceManager.ProxyResource<IotFhirDestinationProperties, false> {
  ...ResourceNameParameter<
    Resource = IotFhirDestination,
    KeyName = "fhirDestinationName",
    SegmentName = "fhirdestinations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface IotFhirDestinations {
  /**
   * Gets the properties of the specified Iot Connector FHIR destination.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotConnectorFhirDestination_Get")
  get is ArmResourceRead<IotFhirDestination>;

  /**
   * Creates or updates an IoT Connector FHIR destination resource with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("IotConnectorFhirDestination_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    IotFhirDestination,
    Response = ArmResourceUpdatedResponse<IotFhirDestination> | ArmResourceCreatedResponse<
      IotFhirDestination,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: IotFhirDestination;
    })
  >;

  /**
   * Deletes an IoT Connector FHIR destination.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("IotConnectorFhirDestination_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    IotFhirDestination,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all FHIR destinations for the given IoT Connector
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FhirDestinations_ListByIotConnector")
  listByIotConnector is ArmResourceListByParent<
    IotFhirDestination,
    Response = ArmResponse<IotFhirDestinationCollection>
  >;
}

@@maxLength(IotFhirDestination.name, 24);
@@minLength(IotFhirDestination.name, 3);
@@doc(IotFhirDestination.name,
  "The name of IoT Connector FHIR destination resource."
);
@@doc(IotFhirDestination.properties, "IoT FHIR Destination settings.");
@@doc(IotFhirDestinations.createOrUpdate::parameters.resource,
  "The parameters for creating or updating an IoT Connector FHIR destination resource."
);
