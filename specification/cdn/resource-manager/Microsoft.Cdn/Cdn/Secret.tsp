import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * Friendly Secret name mapping to the any Secret or secret related information.
 */
@parentResource(Profile)
model Secret is Azure.ResourceManager.ProxyResource<SecretProperties> {
  ...ResourceNameParameter<
    Resource = Secret,
    KeyName = "secretName",
    SegmentName = "secrets",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Secrets {
  /**
   * Gets an existing Secret within a profile.
   */
  get is ArmResourceRead<Secret>;

  /**
   * Creates a new Secret within the specified profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    Secret,
    Response = ArmResourceUpdatedResponse<Secret> | ArmResourceCreatedResponse<Secret> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = Secret> &
      ArmLroLocationHeader<FinalResult = Secret>> & {
      @bodyRoot
      _: Secret;
    })
  >;

  /**
   * Deletes an existing Secret within profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    Secret,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists existing AzureFrontDoor secrets.
   */
  @list
  listByProfile is ArmResourceListByParent<Secret>;
}

@@doc(Secret.name, "Name of the Secret under the profile.");
@@doc(Secret.properties,
  "The JSON object that contains the properties of the Secret to create."
);
@@doc(Secrets.create::parameters.resource, "The Secret properties.");
