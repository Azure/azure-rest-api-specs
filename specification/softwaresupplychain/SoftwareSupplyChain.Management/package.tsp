import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.SoftwareSupplyChain;

@parentResource(Insight)
model PackageType is ProxyResource<PackageTypeProperties> {
  ...ResourceNameParameter<PackageType>;
}

/** The properties of PackageType resource */
model PackageTypeProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface PackageTypes {
  get is ArmResourceRead<PackageType>;
  listByParent is ArmResourceListByParent<PackageType>;
}

@parentResource(PackageType)
model Package is ExtensionResource<PackageNameProperties> {
  ...ResourceNameParameter<Package, NamePattern = "^[a-zA-Z0-9-.]{3,64}$">;
}

/** The properties of PackageName resource */
model PackageNameProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Packages {
  get is ArmResourceRead<Package>;
  listByParent is ArmResourceListByParent<Package>;
}

@parentResource(Package)
model PackageVersion is ExtensionResource<PackageVersionProperties> {
  ...ResourceNameParameter<
    PackageVersion,
    NamePattern = "^[a-zA-Z0-9-.]{3,128}$"
  >;
}

/** The properties of PackageVersion resource derived from the purl spec */
model PackageVersionProperties {
  /** The package "type" or package "protocol" such as maven, npm, nuget, gem, pypi, etc */
  packageType: string;

  /** Some name prefix such as a Maven groupId, a Docker image owner, a GitHub user or organization. Optional and type-specific. */
  packageNamespace?: string;

  /** The name of the package */
  packageName: string;

  /** The version of the package */
  packageVersion: string;

  /** Extra subpath within a package, relative to the package root */
  subpath: string;

  /** Extra qualifying data for a package such as an OS, architecture, a distro, etc */
  @Azure.ResourceManager.identifiers(#[])
  qualifiers?: QualifierProperties[];

  /** The package url as per the https://github.com/package-url/purl-spec spec */
  purl?: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** The properties of the Qualifier type */
model QualifierProperties {
  /** The key of the qualifier */
  key: string;

  /** The value of the qualifier */
  value: string;
}

@armResourceOperations
interface PackageVersions {
  get is ArmResourceRead<PackageVersion>;
  listByParent is ArmResourceListByParent<PackageVersion>;
}
