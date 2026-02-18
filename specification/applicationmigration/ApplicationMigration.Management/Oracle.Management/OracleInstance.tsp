import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./OracleSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;
/**
 * The OracleInstance resource definition.
 */
@parentResource(OracleSite)
model OracleInstance
  is Azure.ResourceManager.ProxyResource<OracleInstanceProperties, false> {
  ...ResourceNameParameter<
    Resource = OracleInstance,
    KeyName = "instanceName",
    SegmentName = "oracleInstances",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface OracleInstances {
  /**
   * Gets the OracleInstances resource.
   */
  get is ArmResourceRead<OracleInstance>;
  /**
   * Puts the OracleInstances resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<OracleInstance>;
  /**
   * Patch the OracleInstances resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    OracleInstance,
    OracleInstanceResourcePatchProperties
  >;

  /**
   * Deletes the OracleInstances resource.
   */
  delete is ArmResourceDeleteSync<OracleInstance>;

  /**
   * Lists the OracleInstances resource in OracleSites.
   */
  listBySite is ArmResourceListByParent<
    OracleInstance,
    Response = ArmResponse<OracleInstanceList>
  >;
}

@@maxLength(OracleInstance.name, 63);
@@minLength(OracleInstance.name, 3);
@@doc(OracleInstance.name, "The name of Instance");
@@doc(OracleInstance.properties, "Resource properties.");
@@doc(OracleInstances.createOrUpdate::parameters.resource,
  "The request body for creating or updating a OracleInstance resource."
);
@@doc(OracleInstances.update::parameters.properties,
  "The request body for updating a OracleInstance resource."
);
