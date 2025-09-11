import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";
import "./likesTea.tsp";
import "./provisioningState.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Contoso;

/** ProxyResource resource */
model GlobalResourceType is ProxyResource<GlobalResourceTypeProperties> {
  ...ResourceNameParameter<GlobalResourceType>;
}

/** ProxyResource properties */
model GlobalResourceTypeProperties {
  /** First name of ProxyResource */
  @pattern("^[A-Za-z0-9-._]+$")
  @minLength(1)
  @maxLength(10)
  firstName: string;

  /** Middle name of ProxyResource */
  @pattern("^[A-Za-z0-9-._]+$")
  @minLength(1)
  @maxLength(10)
  middleName?: string;

  /** Last name of ProxyResource */
  @pattern("^[A-Za-z0-9-._]+$")
  @minLength(1)
  @maxLength(10)
  lastName: string;

  /** Identification number of ProxyResource assigned at creation */
  @visibility(Lifecycle.Read)
  identificationNumber?: string;

  /** Group of ProxyResource */
  group: string;

  /** Boolean indicating whether the ProxyResource likes tea or not */
  likesTea: likesTea;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface GlobalResourceTypes {
  get is ArmResourceRead<GlobalResourceType>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<GlobalResourceType>;
  update is ArmResourcePatchSync<
    GlobalResourceType,
    GlobalResourceTypeProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<GlobalResourceType>;
  listByResourceGroup is ArmResourceListByParent<GlobalResourceType>;
  listBySubscription is ArmListBySubscription<GlobalResourceType>;
}
