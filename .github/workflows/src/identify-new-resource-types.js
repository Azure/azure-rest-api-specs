/**
 * Identify new ARM resource types in PRs using Azure OpenAPI Validator
 */

import { resolve } from 'path';
import { execSync } from 'child_process';
import { Swagger } from '../../shared/src/swagger.js';
import { ArmHelper } from '@microsoft.azure/openapi-validator-rulesets/dist/native/utilities/arm-helper.js';
import { SwaggerInventory } from '@microsoft.azure/openapi-validator-core';

const RESOURCE_TYPE_REGEX = /\/providers\/([^\/]+\/[^\/\{]+)/;
const PROVIDER_REGEX = /\/providers\/([^\/]+)\//;

/** Extract resource type from API path */
function getResourceType(apiPath) {
  return apiPath.match(RESOURCE_TYPE_REGEX)?.[1] || null;
}

/** Extract provider from API path */
function getProvider(apiPath) {
  return apiPath.match(PROVIDER_REGEX)?.[1] || 'Unknown';
}

/** Get all ARM resource types from swagger using openapi-validator */
export function getResourceTypesFromSwagger(swaggerDoc, specPath) {
  const armHelper = new ArmHelper(swaggerDoc, resolve(specPath), new SwaggerInventory());
  const resourceTypes = new Map();
  
  for (const resource of armHelper.getAllResources()) {
    const firstOp = resource.operations[0];
    const resourceType = getResourceType(firstOp.apiPath);
    
    if (resourceType && !resourceTypes.has(resourceType)) {
      resourceTypes.set(resourceType, {
        resourceType,
        provider: getProvider(firstOp.apiPath),
        modelName: resource.modelName,
        operations: resource.operations.map(op => ({ method: op.method, apiPath: op.apiPath }))
      });
    }
  }
  
  return resourceTypes;
}

/** Load swagger file */
export async function loadSwaggerFile(filePath) {
  return await new Swagger(filePath).getContentObject();
}

/** Get file content from git branch */
function getFileFromBranch(filePath, branch) {
  try {
    return execSync(`git show ${branch}:${filePath}`, {
      encoding: 'utf8',
      stdio: ['pipe', 'pipe', 'ignore']
    });
  } catch {
    return null;
  }
}

/** Compare resource types between branches */
export async function compareResourceTypes(swaggerPath, baseBranch = 'main') {
  const currentDoc = await loadSwaggerFile(swaggerPath);
  const currentTypes = getResourceTypesFromSwagger(currentDoc, swaggerPath);
  
  const baseContent = getFileFromBranch(swaggerPath, baseBranch);
  const baseTypes = baseContent 
    ? getResourceTypesFromSwagger(JSON.parse(baseContent), swaggerPath)
    : new Map();

  const newTypes = [];
  for (const [type, info] of currentTypes) {
    if (!baseTypes.has(type)) {
      newTypes.push({
        resourceType: type,
        provider: info.provider,
        modelName: info.modelName,
        operations: info.operations.map(op => op.method)
      });
    }
  }
  
  return { file: swaggerPath, newTypes };
}

/** Check multiple swagger files */
export async function checkMultipleFiles(swaggerFiles, baseBranch = 'main') {
  const results = [];
  for (const file of swaggerFiles) {
    const result = await compareResourceTypes(file, baseBranch);
    if (result.newTypes.length) {
      results.push(result);
    }
  }
  return results;
}

/** Format results summary */
export function formatSummary(results) {
  const totalNew = results.reduce((sum, r) => sum + r.newTypes.length, 0);
  
  if (!totalNew) {
    return 'No new resource types detected';
  }
  
  let summary = `New Resource Types (${totalNew})\n` + '='.repeat(80) + '\n\n';
  
  for (const result of results) {
    if (result.newTypes.length) {
      summary += `${result.file}\n`;
      for (const item of result.newTypes) {
        summary += `   ${item.resourceType} (${item.provider})\n`;
        if (item.operations?.length) {
          summary += `     Operations: ${item.operations.join(', ')}\n`;
        }
      }
      summary += '\n';
    }
  }
  
  // To-Do: After the PR (https://github.com/Azure/azure-rest-api-specs/pull/39625) is merged, check the ARM Leases condition here
  summary += 'All new resource types require Modeling Office Hours review\n';
  summary += 'https://aka.ms/modelling-officehours\n';
   
  return summary;
}

export default { getResourceTypesFromSwagger, loadSwaggerFile, compareResourceTypes, checkMultipleFiles, formatSummary };
