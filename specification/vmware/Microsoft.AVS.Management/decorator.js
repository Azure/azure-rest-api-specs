import { setRouteOptionsForNamespace } from "@typespec/http";
import { getResourceTypeForKeyParam } from "@typespec/rest";
export function $autoRouteForSingleton(context, entity) {
    // Set route options for the whole namespace
    const program = context.program;
    setRouteOptionsForNamespace(context.program, entity, {
        autoRouteOptions: {
            // Filter key parameters for singleton resource types to insert the
            // singleton key value
            routeParamFilter: (operation, param) => {
                const paramResourceType = getResourceTypeForKeyParam(program, param);
                if (paramResourceType) {
                    const singletonKey = getSingletonResourceKey(program, paramResourceType);
                    if (singletonKey) {
                        return {
                            routeParamString: singletonKey,
                            excludeFromOperationParams: true,
                        };
                    }
                }
                // Returning undefined leaves the parameter unaffected
                return undefined;
            },
        },
    });
}
function azureResourceManagerCreateStateSymbol(name) {
    return Symbol.for(`@azure-tools/typespec-azure-resource-manager.${name}`);
}
const ArmStateKeys = {
    armSingletonResources: azureResourceManagerCreateStateSymbol("armSingletonResources"),
};
function getSingletonResourceKey(program, resourceType) {
    return program.stateMap(ArmStateKeys.armSingletonResources).get(resourceType);
}
