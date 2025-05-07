// cspell:words mobo

import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@added(Microsoft.Mission.Versions.v2025_05_01_preview)
@doc("Read only (common-type) property that shows the moboBroker resource that manages the MRG of our resource.")
model ManagedOnBehalfOfConfiguration is Azure.ResourceManager.CommonTypes.ManagedOnBehalfOfConfiguration;
