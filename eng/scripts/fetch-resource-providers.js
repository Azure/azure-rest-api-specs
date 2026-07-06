#!/usr/bin/env node
// Fetch Azure resource providers with or without service groups
// Usage: node fetch-resource-providers.js [--with-service-groups] [--format list|json|table] [--count]

const fs = require('fs');
const path = require('path');

function isServiceGroupDirectory(dirPath) {
    const excludeNames = new Set(['stable', 'preview', 'common-types', 'examples']);
    try {
        return !excludeNames.has(path.basename(dirPath)) && fs.statSync(dirPath).isDirectory();
    } catch { return false; }
}

function hasVersionDirectories(rpPath) {
    return fs.existsSync(path.join(rpPath, 'stable')) || fs.existsSync(path.join(rpPath, 'preview'));
}

function findRepoRoot(startPath = process.cwd()) {
    let current = path.resolve(startPath);
    for (let i = 0; i < 6; i++) {
        if (fs.existsSync(path.join(current, 'specification'))) return current;
        const parent = path.dirname(current);
        if (parent === current) break;
        current = parent;
    }
    throw new Error('Could not find repository root. Run from within azure-rest-api-specs.');
}

function findResourceProviders(repoRoot, withServiceGroups = false) {
    const results = [];
    const specDir = path.join(repoRoot, 'specification');
    if (!fs.existsSync(specDir)) throw new Error(`Specification directory not found: ${specDir}`);
    
    for (const serviceName of fs.readdirSync(specDir)) {
        const serviceDir = path.join(specDir, serviceName);
        if (!fs.statSync(serviceDir).isDirectory()) continue;
        
        const rmDir = path.join(serviceDir, 'resource-manager');
        if (!fs.existsSync(rmDir)) continue;
        
        for (const rpName of fs.readdirSync(rmDir)) {
            const rpPath = path.join(rmDir, rpName);
            if (!fs.statSync(rpPath).isDirectory() || !rpName.startsWith('Microsoft.')) continue;
            
            const serviceGroups = fs.readdirSync(rpPath)
                .filter(sg => isServiceGroupDirectory(path.join(rpPath, sg)))
                .sort();
            
            if (withServiceGroups && serviceGroups.length > 0) {
                results.push({
                    name: rpName,
                    path: path.relative(repoRoot, rpPath),
                    service: serviceName,
                    service_groups: serviceGroups
                });
            } else if (!withServiceGroups && serviceGroups.length === 0 && hasVersionDirectories(rpPath)) {
                results.push({
                    name: rpName,
                    path: path.relative(repoRoot, rpPath),
                    service: serviceName
                });
            }
        }
    }
    return results.sort((a, b) => a.name.localeCompare(b.name));
}

function formatOutput(rps, format, withSG) {
    if (format === 'json') return JSON.stringify(rps, null, 2);
    if (rps.length === 0) return `No resource providers ${withSG ? 'with' : 'without'} service groups found.`;
    
    if (format === 'table') {
        const maxSvc = Math.max(...rps.map(r => r.service.length));
        const maxName = Math.max(...rps.map(r => r.name.length));
        const header = withSG 
            ? `${'Service'.padEnd(maxSvc)}  ${'Resource Provider'.padEnd(maxName)}  Service Groups`
            : `${'Service'.padEnd(maxSvc)}  ${'Resource Provider'.padEnd(maxName)}  Path`;
        const sep = `${'-'.repeat(maxSvc)}  ${'-'.repeat(maxName)}  ${'-'.repeat(60)}`;
        const rows = withSG
            ? rps.map(r => `${r.service.padEnd(maxSvc)}  ${r.name.padEnd(maxName)}  ${r.service_groups.join(', ')}`)
            : rps.map(r => `${r.service.padEnd(maxSvc)}  ${r.name.padEnd(maxName)}  ${r.path}`);
        return [header, sep, ...rows].join('\n');
    }
    
    return withSG
        ? rps.map(r => `${r.service}, ${r.name}, [${r.service_groups.join(', ')}]`).join('\n')
        : rps.map(r => `${r.service}, ${r.name}`).join('\n');
}

function main() {
    const args = { repoRoot: null, format: 'list', count: false, withSG: false };
    
    for (let i = 2; i < process.argv.length; i++) {
        const arg = process.argv[i];
        if (arg === '--help' || arg === '-h') {
            console.log('Usage: node fetch-resource-providers.js [--with-service-groups] [--format list|json|table] [--count] [--repo-root PATH]');
            return 0;
        }
        if (arg === '--repo-root') args.repoRoot = process.argv[++i];
        else if (arg === '--format') args.format = process.argv[++i];
        else if (arg === '--count') args.count = true;
        else if (arg === '--with-service-groups') args.withSG = true;
    }
    
    try {
        const repoRoot = args.repoRoot ? path.resolve(args.repoRoot) : findRepoRoot();
        const rps = findResourceProviders(repoRoot, args.withSG);
        
        if (args.count) {
            console.log(rps.length);
        } else {
            console.log(formatOutput(rps, args.format, args.withSG));
            if (args.format !== 'json') {
                console.log(`\nTotal: ${rps.length} resource provider(s) ${args.withSG ? 'with' : 'without'} service groups`);
            }
        }
        return 0;
    } catch (error) {
        console.error(`Error: ${error.message}`);
        return 1;
    }
}

if (require.main === module) process.exit(main());

module.exports = { findRepoRoot, findResourceProviders, formatOutput, isServiceGroupDirectory, hasVersionDirectories };

