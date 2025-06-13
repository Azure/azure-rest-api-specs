import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A shared secret in a lab.
 */
@parentResource(Lab)
model LabSecret
  is Azure.ResourceManager.ProxyResource<LabSecretProperties, false> {
  ...ResourceNameParameter<
    Resource = LabSecret,
    KeyName = "name",
    SegmentName = "secrets",
    NamePattern = ""
  >;
}

@armResourceOperations
interface LabSecrets {
  /**
   * Get lab secret.
   */
  get is ArmResourceRead<LabSecret>;

  /**
   * Create or replace an existing Lab Secret. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LabSecret,
    Response = ArmResourceCreatedResponse<
      LabSecret,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Allows modifying tags of lab secrets. All other properties will be ignored.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    LabSecret,
    PatchModel = SecretFragment,
    Response = ArmResourceCreatedSyncResponse<LabSecret>
  >;

  /**
   * Delete lab secret. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    LabSecret,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List lab secrets in a given lab.
   */
  list is ArmResourceListByParent<
    LabSecret,
    Parameters = {
      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')'
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<LabSecretList>
  >;
}

@@doc(LabSecret.name, "The name of the lab secret.");
@@doc(LabSecret.properties, "The properties of the resource.");
@@doc(LabSecrets.createOrUpdate::parameters.resource,
  "A shared secret in a lab."
);
@@doc(LabSecrets.update::parameters.properties,
  "Allows modifying tags of lab secrets. All other properties will be ignored."
);
