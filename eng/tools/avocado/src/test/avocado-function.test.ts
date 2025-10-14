// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import * as md from '@ts-common/commonmark-to-markdown'
import * as assert from 'assert'
import { readFileSync } from 'fs'
import * as path from 'path'
import { describe, it } from 'vitest'
import * as avocado from '../index.js'

describe('avocado', () => {
  it('get default tag', () => {
    const readme = readFileSync('src/test/test-readmes/readme.md').toString()
    const m = md.parse(readme)
    const r = avocado.isContainsMultiVersion(m)
    assert.deepStrictEqual(r, false)
    const readme1 = readFileSync('src/test/test-readmes/readme1.md').toString()
    const m1 = md.parse(readme1)
    const r1 = avocado.isContainsMultiVersion(m1)
    assert.deepStrictEqual(r1, false)
  })

  it('get version from input-files ', () => {
    const r = avocado.getVersionFromInputFile('/test/json')
    assert.deepStrictEqual(r, undefined)
    const r2 = avocado.getVersionFromInputFile('json')
    assert.deepStrictEqual(r2, undefined)
    const r1 = avocado.getVersionFromInputFile('/test/json/2020-05-01-preview/b.json')
    assert.deepStrictEqual(r1, '2020-05-01-preview')
  })
})

describe('check default tag should contains all apiVersion', () => {
  it('check RP level folder securityinsights', () => {
    const root = 'src/test/default_tag_latest_swaggers/specification/'
    const rpFolder = path.join(root, 'securityinsights')
    const res = avocado.validateRPMustContainAllLatestApiVersionSwagger(rpFolder).toArray()
    assert.deepStrictEqual(res.length, 21)
    assert.deepStrictEqual(
      res.some((it) => it.code === 'MISSING_APIS_IN_DEFAULT_TAG'),
      true,
    )
    assert.deepStrictEqual(
      res.some((it) => it.code === 'NOT_LATEST_API_VERSION_IN_DEFAULT_TAG'),
      true,
    )
  })

  it('normalize api path should succeed', () => {
    let apiPath = '/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/configurations/{configurationName}'
    let ret = avocado.normalizeApiPath(apiPath)
    assert.deepStrictEqual(ret, '/subscriptions/{}/providers/Microsoft.Advisor/configurations/{}')

    apiPath = '/providers/Microsoft.Advisor/operations'
    ret = avocado.normalizeApiPath(apiPath)
    assert.deepStrictEqual(ret, '/providers/Microsoft.Advisor/operations')

    apiPath = '/{resourceUri}/providers/Microsoft.Advisor/recommendations/{recommendationId}/suppressions/{name}'
    ret = avocado.normalizeApiPath(apiPath)
    assert.deepStrictEqual(ret, '/{}/providers/Microsoft.Advisor/recommendations/{}/suppressions/{}')
  })

  it('get all swagger api path from swagger file', () => {
    const root = 'src/test/default_tag_latest_swaggers/specification/'
    const swaggerPath = path.join(
      root,
      'securityinsights/resource-manager/Microsoft.SecurityInsights/stable/2021-04-01/Incidents.json',
    )
    const swagger = JSON.parse(readFileSync(swaggerPath).toString())
    const result = avocado.getAllPathFromSwagger(swagger)
    assert.deepStrictEqual(result, [
      '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents',
      '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}',
      '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/alerts',
      '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/bookmarks',
      '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/comments',
      '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/comments/{incidentCommentId}',
      '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/entities',
      '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/relations',
      '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/relations/{relationName}',
    ])
  })

  it('get all swagger api path with x-ms-paths', () => {
    const root = 'src/test/swagger_fixtures/'
    const swaggerPath = path.join(root, 'apimapis.json')
    const swagger = JSON.parse(readFileSync(swaggerPath).toString())
    const result: string[] = avocado.getAllPathFromSwagger(swagger)

    // should contain x-ms-paths
    assert.ok(
      result.includes(
        '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/apis/{apiId}?export=true',
      ),
    )
  })
})
