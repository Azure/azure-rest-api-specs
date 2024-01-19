import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("The managed instance encryption protector.")
@parentResource(ManagedInstance)
model ManagedInstanceEncryptionProtector
  is ProxyResource<ManagedInstanceEncryptionProtectorProperties> {
  @doc("The name of the encryption protector to be retrieved.")
  @path
  @key("encryptionProtectorName")
  @segment("encryptionProtector")
  name: EncryptionProtectorName;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ManagedInstanceEncryptionProtectors {
  @doc("Gets a managed instance encryption protector.")
  get is ArmResourceRead<ManagedInstanceEncryptionProtector>;

  @doc("Updates an existing encryption protector.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedInstanceEncryptionProtector>;

  @doc("Gets a list of managed instance encryption protectors")
  listByInstance is ArmResourceListByParent<ManagedInstanceEncryptionProtector>;

  @doc("Revalidates an existing encryption protector.")
  revalidate is ArmResourceActionAsync<
    ManagedInstanceEncryptionProtector,
    void,
    void
  >;
}

@@projectedName(ManagedInstanceEncryptionProtectors.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedInstanceEncryptionProtectors.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedInstanceEncryptionProtectors.createOrUpdate::parameters.resource,
  "The requested encryption protector resource state."
);
