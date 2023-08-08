import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@useDependency(Easm.Versions.v2023_03_01_preview)
@client({
    name: "EasmDefenderClient",
    service: Easm,
})
namespace EasmCustomizations;
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@operationGroup
interface Assets {
    list is Easm.Assets.list;
    update is Easm.Assets.update;
    get is Easm.Assets.get;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@operationGroup
interface DataConnections {
    list is Easm.DataConnections.list;
    validate is Easm.DataConnections.validate;
    get is Easm.DataConnections.get;
    put is Easm.DataConnections.put;
    delete is Easm.DataConnections.delete;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@operationGroup
interface DiscoveryGroups {
    list is Easm.DiscoveryGroups.list;
    validate is Easm.DiscoveryGroups.validate;
    get is Easm.DiscoveryGroups.get;
    put is Easm.DiscoveryGroups.put;
    run is Easm.DiscoveryGroups.run;
    listRuns is Easm.DiscoveryGroups.listRuns;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@operationGroup
interface DiscoveryTemplates {
    list is Easm.DiscoveryTemplates.list;
    get is Easm.DiscoveryTemplates.get;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@operationGroup
interface Reports {
    getBillable is Easm.Reports.billable;
    getSnapshot is Easm.Reports.snapshot;
    getSummary is Easm.Reports.summary;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@operationGroup
interface SavedFilters {
    list is Easm.SavedFilters.list;
    get is Easm.SavedFilters.get;
    put is Easm.SavedFilters.put;
    delete is Easm.SavedFilters.delete;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@operationGroup
interface Tasks {
    list is Easm.Tasks.list;
    get is Easm.Tasks.get;
    cancel is Easm.Tasks.cancel;
}
