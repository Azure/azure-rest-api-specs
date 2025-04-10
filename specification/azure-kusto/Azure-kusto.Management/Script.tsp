import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Kusto;
/**
 * Class representing a database script.
 */
@parentResource(Database)
model Script is Azure.ResourceManager.ProxyResource<ScriptProperties> {
  ...ResourceNameParameter<
    Resource = Script,
    KeyName = "scriptName",
    SegmentName = "scripts",
    NamePattern = "^.*$"
  >;
}

@armResourceOperations
interface Scripts {
  /**
   * Gets a Kusto cluster database script.
   */
  get is ArmResourceRead<Script>;

  /**
   * Creates a Kusto database script.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Script,
    Response = ArmResourceUpdatedResponse<Script> | ArmResourceCreatedResponse<
      Script,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Script;
    })
  >;

  /**
   * Updates a database script.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Script,
    PatchModel = Script,
    Response = ArmResponse<Script> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Script;
    })
  >;

  /**
   * Deletes a Kusto database script.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Script,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns the list of database scripts for given database.
   */
  listByDatabase is ArmResourceListByParent<
    Script,
    Response = ArmResponse<ScriptListResult>
  >;
}

@@doc(Script.name, "The name of the Kusto database script.");
@@doc(Script.properties, "The database script.");
@@doc(Scripts.createOrUpdate::parameters.resource,
  "The Kusto Script parameters contains the KQL to run."
);
@@doc(Scripts.update::parameters.properties,
  "The Kusto Script parameters contains to the KQL to run."
);
