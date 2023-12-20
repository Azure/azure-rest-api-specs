import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./HostPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DesktopVirtualization;
@doc("Schema for MSIX Package properties.")
@parentResource(HostPool)
model MsixPackage is ProxyResource<MsixPackageProperties> {
  @doc("The version specific package full name of the MSIX package within specified hostpool")
  @maxLength(100)
  @minLength(3)
  @path
  @key("msixPackageFullName")
  @segment("msixPackages")
  name: string;
}

@armResourceOperations
interface MsixPackages {
  @doc("Get a msixpackage.")
  get is ArmResourceRead<MsixPackage>;
  @doc("Create or update a MSIX package.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MsixPackage>;
  @doc("Update an  MSIX Package.")
  update is ArmResourcePatchSync<MsixPackage, MsixPackageProperties>;
  @doc("Remove an MSIX Package.")
  delete is ArmResourceDeleteSync<MsixPackage>;
  @doc("List MSIX packages in hostpool.")
  list is ArmResourceListByParent<
    MsixPackage,
    {
      ...BaseParameters<MsixPackage>;

      @doc("Number of items per page.")
      @query("pageSize")
      pageSize?: int32;

      @doc("Indicates whether the collection is descending.")
      @query("isDescending")
      isDescending?: boolean;

      @doc("Initial number of items to skip.")
      @query("initialSkip")
      initialSkip?: int32;
    }
  >;
}
