import assert from "node:assert/strict";
import path from "node:path";
import { compile, getNamespaceFullName, listServices, NodeHost } from "@typespec/compiler";
import { getArmResources } from "@azure-tools/typespec-azure-resource-manager";

const program = await compile(NodeHost, path.resolve("main.tsp"), { noEmit: true });
assert.equal(program.hasError(), false, "The service must compile.");
const employee = getArmResources(program).find(
  (resource) =>
    resource.name === "Employee" && resource.armProviderNamespace === "Microsoft.Widget",
);
assert.ok(employee, "Employee must be reachable from main.tsp as an ARM resource.");
assert.equal(employee.kind, "Tracked", "Employee must be a tracked ARM resource.");
assert.ok(employee.typespecType.namespace, "Employee must have a namespace.");
const namespace = getNamespaceFullName(employee.typespecType.namespace);
assert.ok(
  listServices(program).some(({ type }) => {
    const service = getNamespaceFullName(type);
    return namespace === service || namespace.startsWith(service + ".");
  }),
  "Employee must belong to the compiled service.",
);
/** @type {readonly ["createOrUpdate", "read", "update", "delete"]} */
const lifecycleOperations = ["createOrUpdate", "read", "update", "delete"];
for (const operation of lifecycleOperations) {
  assert.ok(employee.operations.lifecycle[operation], `Employee must expose ${operation}.`);
}
const lists = Object.values(employee.operations.lists);
assert.ok(
  lists.some(({ path }) => /\/resourceGroups\//i.test(path)),
  "Employee must expose list-by-resource-group.",
);
assert.ok(
  lists.some(({ path }) => /\/subscriptions\//i.test(path) && !/\/resourceGroups\//i.test(path)),
  "Employee must expose list-by-subscription.",
);
console.log("Employee and its CRUD/list operations are reachable in the compiled service.");
