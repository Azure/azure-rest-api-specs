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

@armResourceOperations(#{ omitTags: true })
interface Scripts {
  /**
   * Gets a Kusto cluster database script.
   */
  @tag("Scripts")
  get is ArmResourceRead<Script>;

  /**
   * Creates a Kusto database script.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Scripts")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Script,
    Response = ArmResourceUpdatedResponse<Script> | ArmResourceCreatedResponse<Script> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Script> &
      ArmAsyncOperationHeader<FinalResult = Script> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: Script;
    })
  >;

  /**
   * Updates a database script.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Scripts")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Script,
    PatchModel = Script,
    Response = ArmResponse<Script> | (ArmAcceptedLroResponse<
      "Update accepted.",
      LroHeaders = ArmLroLocationHeader<FinalResult = Script> &
        ArmAsyncOperationHeader<FinalResult = Script> &
        Azure.Core.Foundations.RetryAfterHeader
    > & {
      @bodyRoot
      _: Script;
    })
  >;

  /**
   * Deletes a Kusto database script.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Scripts")
  delete is ArmResourceDeleteWithoutOkAsync<
    Script,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Returns the list of database scripts for given database.
   */
  @tag("scripts")
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
