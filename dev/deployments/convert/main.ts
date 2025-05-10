/*
To run:
git checkout origin/main -- specification/resources/resource-manager/Microsoft.Resources
npm --prefix dev/deployments/convert ci
npm --prefix dev/deployments/convert start
*/

import path, { basename, dirname } from 'path';
import { mkdirSync, readFileSync, readdirSync, renameSync, unlinkSync, writeFileSync } from 'fs';
import { spawnSync } from 'child_process';
import { replaceSourceReadmes, writeMarkdownFiles } from './markdown';

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

function getFiles(dir: string, fileName: string) {
  const dirents = readdirSync(dir, { withFileTypes: true });
  let files: string[] = [];
  for (const dirent of dirents) {
    const res = path.resolve(dir, dirent.name);
    if (dirent.isDirectory()) {
      files = [...files, ...getFiles(res, fileName)];
    } else {
      if (basename(res).toLowerCase() === fileName.toLowerCase()) {
        files = [...files, res];
      }
    }
  }

  return files;
}

function splitResourcesJson(resourcesPath: string) {
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

  const parentPath = path.dirname(resourcesPath);
  const specsBasePath = path.dirname(path.dirname(parentPath));

  const deploymentsBasePath = path.resolve(specsBasePath, 'deployments');
  const newDeploymentsPath = path.resolve(deploymentsBasePath, path.relative(specsBasePath, parentPath), 'deployments.json');

  writeFileSync(resourcesPath, JSON.stringify(newResources, null, 2) + '\n');

  newDeployments['info']['title'] = 'DeploymentsClient';
  newDeployments['info']['description'] = 'Provides operations for working with deployments.';
  writeSpecAndExamples(newDeployments, resourcesPath, newDeploymentsPath);

  return newDeploymentsPath;
}

function writeSpecAndExamples(spec: any, sourcePath: string, destPath: string) {
  fixRelativePaths(spec);

  mkdirSync(path.dirname(destPath), { recursive: true });
  writeFileSync(destPath, JSON.stringify(spec, null, 2) + '\n');

  for (const examplePath of obtainExamples(spec)) {
    const exampleSourcePath = path.resolve(dirname(sourcePath), examplePath);
    const exampleDestPath = path.resolve(dirname(destPath), examplePath);

    mkdirSync(path.dirname(exampleDestPath), { recursive: true });
    renameSync(exampleSourcePath, exampleDestPath);
  }
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
    const curRefs = findRefsRecursive(curNode);
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

function* obtainExamples(document: any) {
  for (const exampleBlock of findExamplesRecursive(document)) {
    for (const example of Object.values(exampleBlock)) {
      if (typeof example['$ref'] === 'string') {
        yield example['$ref'];
      }
    }
  }
}

function* findRefsRecursive(node: any): Generator<string> {
  if (typeof node === 'object') {
    if (typeof node['$ref'] === 'string') {
      yield node['$ref'];
    }
    if (typeof node['x-ms-odata'] === 'string') {
      yield node['x-ms-odata'];
    }

    for (const key of Object.keys(node)) {
      yield* findRefsRecursive(node[key]);
    }
  } else if (Array.isArray(node)) {
    for (const item of node) {
      yield* findRefsRecursive(item);
    }
  }
}

function* findExamplesRecursive(node: any): Generator<Record<string, any>> {
  if (typeof node === 'object') {
    if (typeof node['x-ms-examples'] === 'object') {
      yield node['x-ms-examples'];
    }

    for (const key of Object.keys(node)) {
      yield* findExamplesRecursive(node[key]);
    }
  } else if (Array.isArray(node)) {
    for (const item of node) {
      yield* findExamplesRecursive(item);
    }
  }
}

function fixRelativePaths(node: any) {
  if (typeof node === 'object') {
    if (typeof node['$ref'] === 'string' &&
        node['$ref'].startsWith('../../../../../common-types/')) {
      // new files are emitted one dir level deeper, we need to adjust for that
      node['$ref'] = `../${node['$ref']}`;
    }

    for (const key of Object.keys(node)) {
      fixRelativePaths(node[key]);
    }
  } else if (Array.isArray(node)) {
    for (const item of node) {
      fixRelativePaths(item);
    }
  }
}

function moveJsonSpec(specPath: string, newPathName: string) {
  const contentsString = readFileSync(specPath, { encoding: 'utf-8'});
  const existing = JSON.parse(contentsString);
  
  const parentPath = path.dirname(specPath);
  const specsBasePath = path.dirname(path.dirname(parentPath));

  const deploymentsBasePath = path.resolve(specsBasePath, newPathName);
  const newSpecPath = path.resolve(deploymentsBasePath, path.relative(specsBasePath, parentPath), basename(specPath));

  writeSpecAndExamples(existing, specPath, newSpecPath);
  unlinkSync(specPath);

  return newSpecPath;
}

function generateDeploymentsFiles(basePath: string) {
  const filePaths = getFiles(basePath, 'resources.json');
  const newFilePaths = filePaths.map(p => p.replace('resources.json', 'deployments.json'));

  let newPaths = [];
  for (const filePath of filePaths) {
    newPaths.push(splitResourcesJson(filePath));
  }
  writeMarkdownFiles(path.resolve(basePath, 'deployments'), newFilePaths.map(x => path.relative(basePath, x)), 'Deployments', 'DeploymentsClient');

  return newPaths;
}

function generateDeploymentScriptsFiles(basePath: string) {
  const filePaths = getFiles(basePath, 'deploymentScripts.json');

  let newPaths = [];
  for (const filePath of filePaths) {
    newPaths.push(moveJsonSpec(filePath, 'deploymentScripts'));
  }
  writeMarkdownFiles(path.resolve(basePath, 'deploymentScripts'), filePaths.map(x => path.relative(basePath, x)), 'DeploymentScripts', 'DeploymentScriptsClient');

  return newPaths;
}

function generateDeploymentStacksFiles(basePath: string) {
  const filePaths = getFiles(basePath, 'deploymentStacks.json');

  let newPaths = [];
  for (const filePath of filePaths) {
    newPaths.push(moveJsonSpec(filePath, 'deploymentStacks'));
  }
  writeMarkdownFiles(path.resolve(basePath, 'deploymentStacks'), filePaths.map(x => path.relative(basePath, x)), 'DeploymentStacks', 'DeploymentStacksClient');

  return newPaths;
}

function generateTemplateSpecsFiles(basePath: string) {
  const filePaths = getFiles(basePath, 'templateSpecs.json');

  let newPaths = [];
  for (const filePath of filePaths) {
    newPaths.push(moveJsonSpec(filePath, 'templateSpecs'));
  }
  writeMarkdownFiles(path.resolve(basePath, 'templateSpecs'), filePaths.map(x => path.relative(basePath, x)), 'TemplateSpecs', 'TemplateSpecsClient');

  return newPaths;
}

function generateBicepFiles(basePath: string) {
  const filePaths = getFiles(basePath, 'bicepClient.json');

  let newPaths = [];
  for (const filePath of filePaths) {
    newPaths.push(moveJsonSpec(filePath, 'bicep'));
  }
  writeMarkdownFiles(path.resolve(basePath, 'bicep'), filePaths.map(x => path.relative(basePath, x)), 'Bicep', 'BicepClient');

  return newPaths;
}

function writeSuppressions(basePath: string, apiFilesByService: Record<string, string[]>) {
  let contents = '';

  for (const [_, filePaths] of Object.entries(apiFilesByService)) {
    const relativePaths = filePaths.map(x => path.relative(basePath, x));
    contents += `
- tool: TypeSpecRequirement
  paths:
    - ${relativePaths.join('\n    - ')}
  reason: Brownfield service not ready to migrate
`;
  }

  writeFileSync(path.resolve(basePath, 'suppressions.yaml'), contents);
}

function main() {
  // change this if wanting to base off a later commit #
  const baseCommit = 'fc1f625dbec2d92ba4d9dd0df16ece543b04fec9';
  const serviceBasePath = path.resolve(__dirname, '../../../specification/resources');
  const rpBasePath = path.resolve(serviceBasePath, 'resource-manager/Microsoft.Resources');

  spawnSync('git', ['restore', `--source=${baseCommit}`, '--worktree', '--', serviceBasePath]);

  let apiFilesByService: Record<string, string[]> = {};
  apiFilesByService['deployments'] = generateDeploymentsFiles(rpBasePath);
  apiFilesByService['templateSpecs'] = generateTemplateSpecsFiles(rpBasePath);
  apiFilesByService['deploymentStacks'] = generateDeploymentStacksFiles(rpBasePath);
  apiFilesByService['deploymentScripts'] = generateDeploymentScriptsFiles(rpBasePath);
  apiFilesByService['bicep'] = generateBicepFiles(rpBasePath);

  writeSuppressions(rpBasePath, apiFilesByService);

  replaceSourceReadmes(rpBasePath);
}

main();