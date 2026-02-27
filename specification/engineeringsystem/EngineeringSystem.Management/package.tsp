import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.EngineeringSystem;

@parentResource(Product)
model PackageType is ProxyResource<PackageTypeProperties> {
  ...ResourceNameParameter<PackageType>;
}

/** The properties of PackageType resource. */
model PackageTypeProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@parentResource(PackageType)
model Package is ExtensionResource<PackageNameProperties> {
  ...ResourceNameParameter<Package, NamePattern = "^[a-zA-Z0-9-.]{3,64}$">;
}

/** The properties of PackageName resource. */
model PackageNameProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@parentResource(Package)
model PackageVersion is ExtensionResource<PackageVersionProperties> {
  ...ResourceNameParameter<
    PackageVersion,
    NamePattern = "^[a-zA-Z0-9-.]{3,128}$"
  >;
}

/** The properties of PackageVersion resource derived from the purl spec. */
model PackageVersionProperties {
  /** The package "type" or package "protocol" such as maven, npm, nuget, gem, pypi, etc. */
  packageType: string;

  /** The name of the package. */
  packageName: string;

  /** The version of the package. */
  packageVersion: string;

  /** The package url as per the https://github.com/package-url/purl-spec spec. */
  purl?: string;

  /** The package SPDX ID. */
  spdxId?: string;

  /** The package source. */
  packageSource?: string;

  /** The package supplier. */
  supplier?: string;

  /** The package license. */
  license?: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Packages {
  get is ArmResourceRead<Package>;
  listByParent is ArmResourceListByParent<Package>;
}

@armResourceOperations
interface PackageVersions {
  get is ArmResourceRead<PackageVersion>;
  listByParent is ArmResourceListByParent<PackageVersion>;
}

@armResourceOperations
interface PackageTypes {
  get is ArmResourceRead<PackageType>;
  listByParent is ArmResourceListByParent<PackageType>;
}
