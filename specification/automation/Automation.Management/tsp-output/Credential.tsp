import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the credential.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AutomationAccount)
@Azure.ResourceManager.Private.armResourceInternal(CredentialProperties)
@includeInapplicableMetadataInPayload(false)
model Credential extends ProxyResourceBase {
  /**
   * The name of credential.
   */
  @path
  @key("credentialName")
  @segment("credentials")
  name: string;

  /**
   * Gets or sets the properties of the credential.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CredentialProperties;
}

@armResourceOperations
interface Credentials {
  /**
   * Retrieve the credential identified by credential name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Credential_Get")
  get is ArmResourceRead<Credential>;

  /**
   * Create a credential.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Credential_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Credential>;

  /**
   * Update a credential.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Credential_Update")
  update is ArmCustomPatchSync<Credential, CredentialUpdateParameters>;

  /**
   * Delete the credential.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Credential_Delete")
  delete is ArmResourceDeleteSync<Credential>;

  /**
   * Retrieve a list of credentials.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Credential_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<Credential>;
}

@@projectedName(Credentials.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Credentials.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Credentials.createOrUpdate::parameters.resource,
  "The parameters supplied to the create or update credential operation."
);
@@projectedName(Credentials.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(Credentials.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Credentials.update::parameters.properties,
  "The parameters supplied to the Update credential operation."
);
