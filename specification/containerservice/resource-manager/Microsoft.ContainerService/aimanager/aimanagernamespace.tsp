import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ContainerService;

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIManager is a valid name"
@doc("The AI Manager namespace.")
@resource("namespaces")
@parentResource(AIManager)
model AIManagerNamespace is ProxyResource<AIManagerNamespaceProperties> {
  @doc("The name of the AI Manager namespace resource.")
  @key("namespaceName")
  @segment("namespaces")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(63)
  @path
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;

  ...EntityTagProperty;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIManager is a valid name"
@doc("The properties of an AI Manager namespace.")
model AIManagerNamespaceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: AIManagerNamespaceProvisioningState;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Records is the most semantically correct choice for this use-case"
  @doc("The labels for the namespace.")
  labels?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Records is the most semantically correct choice for this use-case"
  @doc("The annotations for the namespace.")
  annotations?: Record<string>;
}

@doc("The provisioning state of the AI Manager namespace resource.")
union AIManagerNamespaceProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The provisioning state of a namespace being created.")
  Creating: "Creating",

  @doc("The provisioning state of a namespace being updated.")
  Updating: "Updating",

  @doc("The provisioning state of a namespace being deleted.")
  Deleting: "Deleting",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIManager is a valid name"
@armResourceOperations
interface AIManagerNamespaces {
  get is ArmResourceRead<AIManagerNamespace>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    AIManagerNamespace,
    Azure.ResourceManager.Foundations.BaseParameters<AIManagerNamespace> &
      IfMatchParameters<AIManagerNamespace> &
      IfNoneMatchParameters<AIManagerNamespace>
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    AIManagerNamespace,
    Azure.ResourceManager.Foundations.BaseParameters<AIManagerNamespace> &
      IfMatchParameters<AIManagerNamespace>
  >;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "AIManager is a valid name"
  listByAIManager is ArmResourceListByParent<AIManagerNamespace>;

  @doc("Lists the credentials of an AI Manager namespace.")
  @post
  listCredential is ArmResourceActionSync<
    AIManagerNamespace,
    void,
    ArmResponse<CredentialResults>
  >;
}
