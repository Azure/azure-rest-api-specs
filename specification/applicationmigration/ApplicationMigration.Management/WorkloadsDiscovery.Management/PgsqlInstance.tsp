import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PgsqlSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;
/**
 * The PGSQLInstance resource definition.
 */
@parentResource(PgsqlSite)
model PgsqlInstance
  is Azure.ResourceManager.ProxyResource<PgsqlInstanceProperties, false> {
  ...ResourceNameParameter<
    Resource = PgsqlInstance,
    KeyName = "instanceName",
    SegmentName = "PGSQLInstances",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface PgsqlInstances {
  /**
   * Gets the PGSQLInstances resource.
   */
  get is ArmResourceRead<PgsqlInstance>;

  /**
   * Puts the PGSQLInstances resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<PgsqlInstance>;

  /**
   * Patch the PGSQLInstances resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    PgsqlInstance,
    PgsqlInstanceResourcePatchProperties
  >;

  /**
   * Deletes the PGSQLInstances resource.
   */
  delete is ArmResourceDeleteSync<PgsqlInstance>;

  /**
   * Lists the PGSQLInstances resource in PGSQLSites.
   */
  listBySite is ArmResourceListByParent<
    PgsqlInstance,
    Response = ArmResponse<PgsqlInstanceList>
  >;
}

@@maxLength(PgsqlInstance.name, 63);
@@minLength(PgsqlInstance.name, 3);
@@doc(PgsqlInstance.name, "The name of Instance");
@@doc(PgsqlInstance.properties, "Resource properties.");
@@doc(PgsqlInstances.createOrUpdate::parameters.resource,
  "The machines to add to the assessment"
);
@@doc(PgsqlInstances.update::parameters.properties, "Clouds patch payload.");
