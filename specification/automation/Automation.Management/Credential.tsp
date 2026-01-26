import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the credential.
 */
@parentResource(AutomationAccount)
model Credential is Azure.ResourceManager.ProxyResource<CredentialProperties> {
  ...ResourceNameParameter<
    Resource = Credential,
    KeyName = "credentialName",
    SegmentName = "credentials",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Credentials {
  /**
   * Retrieve the credential identified by credential name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Credential_Get")
  get is ArmResourceRead<Credential>;

  /**
   * Create a credential.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Credential_CreateOrUpdate")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    Credential,
    Request = CredentialCreateOrUpdateParameters
  >;

  /**
   * Update a credential.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Credential_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Credential,
    PatchModel = CredentialUpdateParameters
  >;

  /**
   * Delete the credential.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Credential_Delete")
  delete is ArmResourceDeleteSync<Credential, Response = ArmDeletedResponse>;

  /**
   * Retrieve a list of credentials.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Credential_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<Credential>;
}

@@doc(Credential.name, "The name of credential.");
@@doc(Credential.properties, "Gets or sets the properties of the credential.");
@@doc(Credentials.createOrUpdate::parameters.resource,
  "The parameters supplied to the create or update credential operation."
);
@@doc(Credentials.update::parameters.properties,
  "The parameters supplied to the Update credential operation."
);
