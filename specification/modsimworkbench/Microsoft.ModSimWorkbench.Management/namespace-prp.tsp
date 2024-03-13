import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
using Azure.ResourceManager;
namespace Private {
  @@armProviderNamespace(Microsoft.ModSimWorkbench,
    "Microsoft.ModSimWorkbench"
  );
}
