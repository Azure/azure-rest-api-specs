import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SimGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * SIM resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(SimGroup)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SimPropertiesFormat)
model Sim extends ProxyResourceBase {
  /**
   * The name of the SIM.
   */
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("simName")
  @segment("sims")
  @visibility("read")
  name: string;

  /**
   * SIM Properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: SimPropertiesFormat;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Sim,
    BaseParameters<Sim>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes the specified SIM.
   */
  delete is ArmResourceDeleteAsync<
    Sim,
    BaseParameters<Sim>,
    ArmLroLocationHeader
  >;

  /**
   * Gets all the SIMs in a SIM group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Sims_ListByGroup")
  listByGroup is ArmResourceListByParent<Sim>;
}

@@projectedName(Sims.createOrUpdate::parameters.resource, "json", "parameters");
@@extension(Sims.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Sims.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update SIM operation."
);
