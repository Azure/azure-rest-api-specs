#!/usr/bin/env node
// Tests for fetch-resource-providers.js

const path = require('path');
const { findRepoRoot, findResourceProviders, formatOutput } = require('../fetch-resource-providers.js');

function assert(condition, message) {
    if (!condition) throw new Error(`Test failed: ${message}`);
}

function testFindRepoRoot() {
    const repoRoot = findRepoRoot();
    assert(repoRoot.endsWith('azure-rest-api-specs'), 'Repo root should end with azure-rest-api-specs');
    assert(require('fs').existsSync(path.join(repoRoot, 'specification')), 'Specification directory should exist');
    console.log('✓ findRepoRoot test passed');
}

function testFindResourceProvidersWithout() {
    const repoRoot = findRepoRoot();
    const rps = findResourceProviders(repoRoot, false);
    assert(rps.length > 0, 'Should find resource providers without service groups');
    assert(rps.every(rp => rp.name && rp.service && rp.path), 'All RPs should have name, service, and path');
    assert(rps.every(rp => !rp.service_groups), 'RPs without service groups should not have service_groups field');
    assert(rps.some(rp => rp.name === 'Microsoft.Storage'), 'Should include Microsoft.Storage');
    assert(!rps.some(rp => rp.name === 'Microsoft.Compute'), 'Should not include Microsoft.Compute (has service groups)');
    console.log(`✓ findResourceProviders (without) test passed - found ${rps.length} RPs`);
}

function testFindResourceProvidersWith() {
    const repoRoot = findRepoRoot();
    const rps = findResourceProviders(repoRoot, true);
    assert(rps.length > 0, 'Should find resource providers with service groups');
    assert(rps.every(rp => rp.name && rp.service && rp.path && rp.service_groups), 'All RPs should have name, service, path, and service_groups');
    assert(rps.every(rp => Array.isArray(rp.service_groups)), 'service_groups should be an array');
    const compute = rps.find(rp => rp.name === 'Microsoft.Compute');
    assert(compute, 'Should include Microsoft.Compute');
    assert(compute.service === 'compute', 'Microsoft.Compute service should be "compute"');
    assert(compute.service_groups.includes('ComputeRP'), 'Microsoft.Compute should have ComputeRP service group');
    assert(!rps.some(rp => rp.name === 'Microsoft.Storage'), 'Should not include Microsoft.Storage (no service groups)');
    console.log(`✓ findResourceProviders (with) test passed - found ${rps.length} RPs`);
}

function testFormatOutputList() {
    const rps = [
        { name: 'Microsoft.Test', service: 'test', path: 'test/path' },
        { name: 'Microsoft.Test2', service: 'test2', path: 'test2/path', service_groups: ['Group1', 'Group2'] }
    ];
    
    const outputWithout = formatOutput([rps[0]], 'list', false);
    assert(outputWithout.includes('test, Microsoft.Test'), 'List format should include service and name');
    
    const outputWith = formatOutput([rps[1]], 'list', true);
    assert(outputWith.includes('test2, Microsoft.Test2, [Group1, Group2]'), 'List format with groups should include service, name, and groups');
    
    console.log('✓ formatOutput (list) test passed');
}

function testFormatOutputJson() {
    const rps = [{ name: 'Microsoft.Test', service: 'test', path: 'test/path' }];
    const output = formatOutput(rps, 'json', false);
    const parsed = JSON.parse(output);
    assert(Array.isArray(parsed), 'JSON output should be an array');
    assert(parsed[0].name === 'Microsoft.Test', 'JSON should preserve RP name');
    console.log('✓ formatOutput (json) test passed');
}

function testFormatOutputTable() {
    const rps = [{ name: 'Microsoft.Test', service: 'test', path: 'test/path' }];
    const output = formatOutput(rps, 'table', false);
    assert(output.includes('Service'), 'Table should have Service header');
    assert(output.includes('Resource Provider'), 'Table should have Resource Provider header');
    assert(output.includes('test'), 'Table should include service name');
    assert(output.includes('Microsoft.Test'), 'Table should include RP name');
    console.log('✓ formatOutput (table) test passed');
}

function runTests() {
    console.log('Running tests for fetch-resource-providers.js...\n');
    
    try {
        testFindRepoRoot();
        testFindResourceProvidersWithout();
        testFindResourceProvidersWith();
        testFormatOutputList();
        testFormatOutputJson();
        testFormatOutputTable();
        
        console.log('\n✅ All tests passed!');
        return 0;
    } catch (error) {
        console.error(`\n❌ ${error.message}`);
        console.error(error.stack);
        return 1;
    }
}

if (require.main === module) {
    process.exit(runTests());
}
