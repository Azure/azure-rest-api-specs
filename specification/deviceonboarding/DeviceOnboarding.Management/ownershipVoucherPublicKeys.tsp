import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./discoveryServices.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.DeviceOnboarding;

// ------------------------------------------------------------------
// Section 2.5: Ownership Voucher Public Key (Child resource)
// ------------------------------------------------------------------
// TODO: does this cause issues with CMK
@doc("Ownership voucher public key resource.")
@added(Versions.v2024_12_01_preview)
@removed(Versions.v2025_05_01_preview)
@parentResource(DiscoveryService)
model OwnershipVoucherPublicKey
  is Azure.ResourceManager.TrackedResource<OwnershipVoucherPublicKeyProperties> {
  @doc("The name of the ownership voucher public key resource.")
  @maxLength(128)
  @pattern("^[a-zA-Z0-9-]{3,63}[a-zA-Z0-9]$")
  @segment("ownershipVoucherPublicKeys")
  @key("ownershipVoucherPublicKeyName")
  @path
  name: string;
}

@doc("Details of the Allowed Ownership Voucher Public Key resource")
@added(Versions.v2024_12_01_preview)
@removed(Versions.v2025_05_01_preview)
model OwnershipVoucherPublicKeyProperties {
  @doc("Public key.")
  publicKeyDetails: PublicKeyDetails;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Details of public key type")
@added(Versions.v2024_12_01_preview)
@removed(Versions.v2025_05_01_preview)
@discriminator("publicKeyType")
model PublicKeyDetails {
  publicKeyType: PublicKeyType;
}

@doc("Options of public key types to validate ownership vouchers.")
@added(Versions.v2024_12_01_preview)
@removed(Versions.v2025_05_01_preview)
union PublicKeyType {
  string,

  @doc("Public key type represented by a X5Chain.")
  X5Chain: "X5Chain",
}

@doc("X5Chain Public Key Details.")
@added(Versions.v2024_12_01_preview)
@removed(Versions.v2025_05_01_preview)
model X5ChainPublicKeyDetails extends PublicKeyDetails {
  @doc("X5Chain type public key details")
  publicKeyType: PublicKeyType.X5Chain;

  @doc("X509CertificateChain used as public keys to validate Ownership Voucher.")
  x5Chain: bytes[];
}

@armResourceOperations
@added(Versions.v2024_12_01_preview)
@removed(Versions.v2025_05_01_preview)
interface OwnershipVoucherPublicKeys {
  get is ArmResourceRead<OwnershipVoucherPublicKey>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OwnershipVoucherPublicKey>;
  delete is ArmResourceDeleteWithoutOkAsync<OwnershipVoucherPublicKey>;
  update is ArmResourcePatchAsync<
    OwnershipVoucherPublicKey,
    OwnershipVoucherPublicKeyProperties
  >;
  listByParent is ArmResourceListByParent<OwnershipVoucherPublicKey>;
}
