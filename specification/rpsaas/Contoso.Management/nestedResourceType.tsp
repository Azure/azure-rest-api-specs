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

/** NestedResourceType resource */
@parentResource(Employee)
model NestedResourceType is ProxyResource<NestedResourceTypeProperties> {
  ...ResourceNameParameter<
    NestedResourceType,
    SegmentName = "nestedResourceType" // Override SegmentName to remove the 's'
  >;
}

/** NestedResourceType properties */
model NestedResourceTypeProperties {
  /** First name of NestedResourceType */
  @pattern("^[A-Za-z0-9-._]+$")
  @minLength(1)
  @maxLength(10)
  firstName: string;

  /** Middle name of NestedResourceType */
  @pattern("^[A-Za-z0-9-._]+$")
  @minLength(1)
  @maxLength(10)
  middleName?: string;

  /** Last name of NestedResourceType */
  @pattern("^[A-Za-z0-9-._]+$")
  @minLength(1)
  @maxLength(10)
  lastName: string;

  /** Identification number of NestedResourceType assigned at creation */
  @visibility(Lifecycle.Read)
  identificationNumber?: string;

  /** Group of NestedResourceType */
  group: string;

  /** Boolean indicating whether the NestedResourceType likes tea or not */
  likesTea: likesTea;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface NestedResourceTypes {
  get is ArmResourceRead<NestedResourceType>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NestedResourceType>;
  update is ArmResourcePatchSync<
    NestedResourceType,
    NestedResourceTypeProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NestedResourceType>;
  list is ArmResourceListByParent<NestedResourceType>;
}
