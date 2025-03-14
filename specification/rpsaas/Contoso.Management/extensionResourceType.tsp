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

/** ExtensionResourceType resource */
// TODO: seems like this is not actually an extension resource. Use Azure.ResourceManager.ExtensionResource when it should be an extension resource.
// i.e.: `is Azure.ResourceManager.ExtensionResource<ExtensionResourceTypeProperties> {`
model ExtensionResourceType
  is TrackedResource<ExtensionResourceTypeProperties> {
  ...ResourceNameParameter<
    ExtensionResourceType,
    // TODO: resource type names should end in 's'
    SegmentName = "extensionResourceType" // Override SegmentName to remove the 's'
  >;
}

/** ExtensionResourceType properties */
model ExtensionResourceTypeProperties {
  /** First name of ExtensionResourceType */
  @pattern("^[A-Za-z0-9-._]+$")
  @minLength(1)
  @maxLength(10)
  firstName: string;

  /** Middle name of ExtensionResourceType */
  @pattern("^[A-Za-z0-9-._]+$")
  @minLength(1)
  @maxLength(10)
  middleName?: string;

  /** Last name of ExtensionResourceType */
  @pattern("^[A-Za-z0-9-._]+$")
  @minLength(1)
  @maxLength(10)
  lastName: string;

  /** Identification number of ExtensionResourceType assigned at creation */
  @visibility(Lifecycle.Read)
  identificationNumber?: string;

  /** Group of ExtensionResourceType */
  group: string;

  /** Boolean indicating whether the ExtensionResourceType likes tea or not */
  likesTea: likesTea;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface ExtensionResourceTypes {
  get is ArmResourceRead<ExtensionResourceType>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ExtensionResourceType>;
  update is ArmResourcePatchSync<
    ExtensionResourceType,
    ExtensionResourceTypeProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ExtensionResourceType>;
  listByResourceGroup is ArmResourceListByParent<ExtensionResourceType>;
  listBySubscription is ArmListBySubscription<ExtensionResourceType>;
}
