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

  /**
   * An etag associated with the resource, used for optimistic concurrency when editing it.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  /**
   * The resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

@armResourceOperations(#{ omitTags: true })
interface IotFhirDestinations {
  /**
   * Gets the properties of the specified Iot Connector FHIR destination.
   */
  @tag("IotConnectors")
  get is ArmResourceRead<IotFhirDestination, Error = ErrorDetails>;

  /**
   * Creates or updates an IoT Connector FHIR destination resource with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("IotConnectors")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    IotFhirDestination,
    Response = ArmResourceUpdatedResponse<IotFhirDestination> | ArmResourceCreatedResponse<
      IotFhirDestination,
      ArmLroLocationHeader<FinalResult = IotFhirDestination> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: IotFhirDestination;
    }),
    Error = ErrorDetails
  >;

  /**
   * Deletes an IoT Connector FHIR destination.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("IotConnectors")
  delete is ArmResourceDeleteWithoutOkAsync<
    IotFhirDestination,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = Error
  >;

  /**
   * Lists all FHIR destinations for the given IoT Connector
   */
  @tag("IotConnectors")
  listByIotConnector is ArmResourceListByParent<
    IotFhirDestination,
    Response = ArmResponse<IotFhirDestinationCollection>,
    Error = ErrorDetails
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
