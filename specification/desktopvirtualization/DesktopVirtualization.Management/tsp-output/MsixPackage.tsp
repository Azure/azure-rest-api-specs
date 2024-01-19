import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HostPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a msixpackage.")
  @operationId("MSIXPackages_Get")
  get is ArmResourceRead<MsixPackage>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a MSIX package.")
  @operationId("MSIXPackages_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MsixPackage>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update an  MSIX Package.")
  @operationId("MSIXPackages_Update")
  update is ArmCustomPatchSync<MsixPackage, MsixPackagePatch>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Remove an MSIX Package.")
  @operationId("MSIXPackages_Delete")
  delete is ArmResourceDeleteSync<MsixPackage>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List MSIX packages in hostpool.")
  @operationId("MSIXPackages_List")
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

@@projectedName(MsixPackages.createOrUpdate::parameters.resource,
  "json",
  "msixPackage"
);
@@extension(MsixPackages.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "msixPackage"
);
@@doc(MsixPackages.createOrUpdate::parameters.resource,
  "Object containing  MSIX Package definitions."
);
@@projectedName(MsixPackages.update::parameters.properties,
  "json",
  "msixPackage"
);
@@extension(MsixPackages.update::parameters.properties,
  "x-ms-client-name",
  "msixPackage"
);
@@doc(MsixPackages.update::parameters.properties,
  "Object containing MSIX Package definitions."
);
