import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SBNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceBus;
/**
 * Single item in List or Get Alias(Disaster Recovery configuration) operation
 */
@parentResource(SBNamespace)
model ArmDisasterRecovery
  is Azure.ResourceManager.ProxyResource<ArmDisasterRecoveryProperties> {
  ...ResourceNameParameter<
    Resource = ArmDisasterRecovery,
    KeyName = "alias",
    SegmentName = "disasterRecoveryConfigs",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface ArmDisasterRecoveries {
  /**
   * Retrieves Alias(Disaster Recovery configuration) for primary or secondary namespace
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<ArmDisasterRecovery, Error = ErrorResponse>;

  /**
   * Creates or updates a new Alias(Disaster Recovery configuration)
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ArmDisasterRecovery,
    Error = ErrorResponse
  >;

  /**
   * Deletes an Alias(Disaster Recovery configuration)
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteSync<ArmDisasterRecovery, Error = ErrorResponse>;

  /**
   * Gets all Alias(Disaster Recovery configurations)
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  list is ArmResourceListByParent<ArmDisasterRecovery, Error = ErrorResponse>;

  /**
   * This operation disables the Disaster Recovery and stops replicating changes from primary to secondary namespaces
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  breakPairing is ArmResourceActionSync<
    ArmDisasterRecovery,
    void,
    OkResponse,
    Error = ErrorResponse
  >;

  /**
   * Invokes GEO DR failover and reconfigure the alias to point to the secondary namespace
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("failover")
  failOver is ArmResourceActionSync<
    ArmDisasterRecovery,
    NamespaceFailoverProperties,
    OkResponse,
    OptionalRequestBody = true,
    Error = ErrorResponse
  >;
}

@@maxLength(ArmDisasterRecovery.name, 50);
@@minLength(ArmDisasterRecovery.name, 1);
@@doc(ArmDisasterRecovery.name, "The Disaster Recovery configuration name");
@@doc(ArmDisasterRecovery.properties,
  "Properties required to the Create Or Update Alias(Disaster Recovery configurations)"
);
@@doc(ArmDisasterRecoveries.createOrUpdate::parameters.resource,
  "Parameters required to create an Alias(Disaster Recovery configuration)"
);
@@doc(ArmDisasterRecoveries.failOver::parameters.body,
  "Parameters required to create an Alias(Disaster Recovery configuration)"
);
