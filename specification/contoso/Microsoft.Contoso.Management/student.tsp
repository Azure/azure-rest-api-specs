import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Contoso;

/** Student resource */
@added(Versions.v2023_11_01_preview)
model Student is TrackedResource<StudentProperties> {
  ...ResourceNameParameter<Student>;
}

/** Student properties */
@added(Versions.v2023_11_01_preview)
model StudentProperties {
  /** Age of Student */
  age?: int32;

  /** Student id of Student */
  studentId?: int32;

  /** Hometown of Student */
  hometown?: string;

  /** Profile of Student */
  @encode("base64url")
  profile?: bytes;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** Major of Student. */
  @added(Versions.v2023_12_01_preview)
  major?: string;

  /** The date of birth of the Student. */
  @removed(Versions.v2023_12_01_preview)
  dateOfBirth?: string;
}

@added(Versions.v2023_11_01_preview)
@armResourceOperations
interface Students {
  get is ArmResourceRead<Student>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Student>;
  update is ArmResourcePatchSync<Student, StudentProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Student>;
  listByResourceGroup is ArmResourceListByParent<Student>;
  listBySubscription is ArmListBySubscription<Student>;
}
