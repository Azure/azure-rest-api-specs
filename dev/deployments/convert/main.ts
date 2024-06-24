/*
To run:
git checkout origin/main -- specification/resources/resource-manager/Microsoft.Resources
npm --prefix dev/deployments/convert ci
npm --prefix dev/deployments/convert start
*/

import { dirname, resolve } from 'path';
import { readFileSync, readdirSync, writeFile, writeFileSync } from 'fs';

const deploymentsPaths = [
  '/{scope}/providers/Microsoft.Resources/deployments/{deploymentName}',
  '/{scope}/providers/Microsoft.Resources/deployments/{deploymentName}/cancel',
  '/{scope}/providers/Microsoft.Resources/deployments/{deploymentName}/validate',
  '/{scope}/providers/Microsoft.Resources/deployments/{deploymentName}/exportTemplate',
  '/{scope}/providers/Microsoft.Resources/deployments/',
  '/providers/Microsoft.Resources/deployments/{deploymentName}',
  '/providers/Microsoft.Resources/deployments/{deploymentName}/cancel',
  '/providers/Microsoft.Resources/deployments/{deploymentName}/validate',
  '/providers/Microsoft.Resources/deployments/{deploymentName}/whatIf',
  '/providers/Microsoft.Resources/deployments/{deploymentName}/exportTemplate',
  '/providers/Microsoft.Resources/deployments/',
  '/providers/Microsoft.Management/managementGroups/{groupId}/providers/Microsoft.Resources/deployments/{deploymentName}',
  '/providers/Microsoft.Management/managementGroups/{groupId}/providers/Microsoft.Resources/deployments/{deploymentName}/cancel',
  '/providers/Microsoft.Management/managementGroups/{groupId}/providers/Microsoft.Resources/deployments/{deploymentName}/validate',
  '/providers/Microsoft.Management/managementGroups/{groupId}/providers/Microsoft.Resources/deployments/{deploymentName}/whatIf',
  '/providers/Microsoft.Management/managementGroups/{groupId}/providers/Microsoft.Resources/deployments/{deploymentName}/exportTemplate',
  '/providers/Microsoft.Management/managementGroups/{groupId}/providers/Microsoft.Resources/deployments/',
  '/subscriptions/{subscriptionId}/providers/Microsoft.Resources/deployments/{deploymentName}',
  '/subscriptions/{subscriptionId}/providers/Microsoft.Resources/deployments/{deploymentName}/cancel',
  '/subscriptions/{subscriptionId}/providers/Microsoft.Resources/deployments/{deploymentName}/validate',
  '/subscriptions/{subscriptionId}/providers/Microsoft.Resources/deployments/{deploymentName}/whatIf',
  '/subscriptions/{subscriptionId}/providers/Microsoft.Resources/deployments/{deploymentName}/exportTemplate',
  '/subscriptions/{subscriptionId}/providers/Microsoft.Resources/deployments/',
  '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Resources/deployments/{deploymentName}',
  '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Resources/deployments/{deploymentName}/cancel',
  '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Resources/deployments/{deploymentName}/validate',
  '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Resources/deployments/{deploymentName}/whatIf',
  '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Resources/deployments/{deploymentName}/exportTemplate',
  '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Resources/deployments/',
  '/{scope}/providers/Microsoft.Resources/deployments/{deploymentName}/operations/{operationId}',
  '/{scope}/providers/Microsoft.Resources/deployments/{deploymentName}/operations',
  '/providers/Microsoft.Resources/deployments/{deploymentName}/operations/{operationId}',
  '/providers/Microsoft.Resources/deployments/{deploymentName}/operations',
  '/providers/Microsoft.Management/managementGroups/{groupId}/providers/Microsoft.Resources/deployments/{deploymentName}/operations/{operationId}',
  '/providers/Microsoft.Management/managementGroups/{groupId}/providers/Microsoft.Resources/deployments/{deploymentName}/operations',
  '/subscriptions/{subscriptionId}/providers/Microsoft.Resources/deployments/{deploymentName}/operations/{operationId}',
  '/subscriptions/{subscriptionId}/providers/Microsoft.Resources/deployments/{deploymentName}/operations',
  '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/deployments/{deploymentName}/operations/{operationId}',
  '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/deployments/{deploymentName}/operations',
  '/providers/Microsoft.Resources/calculateTemplateHash',
];

async function* getFiles(dir: string): AsyncGenerator<string> {
    const dirents = readdirSync(dir, { withFileTypes: true });
    for (const dirent of dirents) {
      const res = resolve(dir, dirent.name);
      if (dirent.isDirectory()) {
        yield* getFiles(res);
      } else {
        yield res;
      }
    }
  }

async function main() {
  const path = resolve(__dirname, '../../../specification/resources/resource-manager/Microsoft.Resources');
  for await (const file of getFiles(path)) {
    if (!file.endsWith('resources.json')) {
      continue;
    }
    await split(file);
  }
}

async function split(resourcesPath: string) {
  const basePath = dirname(resourcesPath);
  const contentsString = readFileSync(resourcesPath, { encoding: 'utf-8'});
  const existing = JSON.parse(contentsString);
  const newDeployments = JSON.parse(contentsString);
  const newResources = JSON.parse(contentsString);

  const paths = existing['paths'];
  const deploymentRefs = new Set<string>();
  const resourcesRefs = new Set<string>();
  for (const path of Object.keys(paths)) {
    const isDeploymentsOwned = deploymentsPaths.indexOf(path) > -1;

    if (isDeploymentsOwned) {
      delete newResources['paths'][path];
    } else {
      delete newDeployments['paths'][path];
    }

    for (const ref of obtainRefs(existing, paths[path])) {
      if (isDeploymentsOwned) {
        deploymentRefs.add(ref);
      } else {
        resourcesRefs.add(ref);
      }
    }
  }

  for (const ref of deploymentRefs) {
    if (!resourcesRefs.has(ref)) {
      deleteRef(newResources, ref);
    }
  }
  for (const ref of resourcesRefs) {
    if (!deploymentRefs.has(ref)) {
      deleteRef(newDeployments, ref);
    }
  }

  writeFileSync(resolve(basePath, 'deployments.json'), JSON.stringify(newDeployments, null, 2) + '\n');
  writeFileSync(resolve(basePath, 'resources.json'), JSON.stringify(newResources, null, 2) + '\n');  
}

function deleteRef(document: any, ref: string) {
  if (!ref.startsWith('#/')) {
    throw `Cannot process ref ${ref}`;
  }

  const path = ref.substring(2).split('/');
  let refLookup = document;
  while (path.length > 1) {
    const key = path.shift() as string;
    refLookup = refLookup[key];
  }

  delete refLookup[path[0]];
}

function obtainRefs(document: any, node: any): string[] {
  const refs = new Set<string>();
  const nodes = [node];

  while (nodes.length > 0) {
    const curNode = nodes.pop();
    const curRefs = findRefsRecursive(document, curNode);
    for (const curRef of curRefs) {
      if (refs.has(curRef)) {
        continue;
      }

      refs.add(curRef);
      if (curRef.startsWith('#/')) {
        const path = curRef.substring(2).split('/');
        let refLookup = document;
        while (path.length > 0) {
          const key = path.shift() as string;
          refLookup = refLookup[key];
        }

        if (!refLookup) {
          throw `Failed to find definition ${curRef}`;
        }

        nodes.push(refLookup);
      }
    }
  }

  return [...refs].filter(x => x.startsWith('#/'));
}

function* findRefsRecursive(document: any, node: any): Generator<string> {
  if (typeof node === 'object') {
    if (typeof node['$ref'] === 'string') {
      yield node['$ref'];
    }
    if (typeof node['x-ms-odata'] === 'string') {
      yield node['x-ms-odata'];
    }

    for (const key of Object.keys(node)) {
      yield* findRefsRecursive(document, node[key]);
    }
  } else if (Array.isArray(node)) {
    for (const item of node) {
      yield* findRefsRecursive(document, item);
    }
  }
}

main();