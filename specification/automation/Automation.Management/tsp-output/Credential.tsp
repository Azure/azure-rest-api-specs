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
@doc("Definition of the credential.")
@parentResource(AutomationAccount)
model Credential is ProxyResource<CredentialProperties> {
  @doc("The name of credential.")
  @path
  @key("credentialName")
  @segment("credentials")
  name: string;
}

@armResourceOperations
interface Credentials {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the credential identified by credential name.")
  @operationId("Credential_Get")
  get is ArmResourceRead<Credential>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a credential.")
  @operationId("Credential_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Credential>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a credential.")
  @operationId("Credential_Update")
  update is ArmCustomPatchSync<Credential, CredentialUpdateParameters>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the credential.")
  @operationId("Credential_Delete")
  delete is ArmResourceDeleteSync<Credential>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of credentials.")
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
