import "@azure-tools/typespec-azure-resource-manager";
import "../../models/managedidentity/managedIdentityResource.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;
using Autorest;

namespace Oracle.Database;

@added(Versions.v20260101_preview)
@armResourceOperations
interface ManagedIdentityResources
  extends OracleTrackedResource<
      ManagedIdentityResource,
      ManagedIdentityResourceProperties
    > {}
