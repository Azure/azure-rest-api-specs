import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SimGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * SIM resource.
 */
@parentResource(SimGroup)
model Sim is Azure.ResourceManager.ProxyResource<SimPropertiesFormat, false> {
  ...ResourceNameParameter<
    Resource = Sim,
    KeyName = "simName",
    SegmentName = "sims",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]*$"
  >;
}

@armResourceOperations
interface Sims {
  /**
   * Gets information about the specified SIM.
   */
  get is ArmResourceRead<Sim>;

  /**
   * Creates or updates a SIM.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Sim>;

  /**
   * Deletes the specified SIM.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Sim,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all the SIMs in a SIM group.
   */
  listByGroup is ArmResourceListByParent<Sim>;
}

@@maxLength(Sim.name, 64);
@@doc(Sim.name, "The name of the SIM.");
@@doc(Sim.properties, "SIM Properties.");
@@doc(Sims.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update SIM operation."
);
