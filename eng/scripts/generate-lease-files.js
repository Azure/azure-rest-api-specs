#!/usr/bin/env node
// Generate lease.yaml files from resource provider data

const fs = require('fs');
const path = require('path');
const readline = require('readline');

const DEFAULT_DURATION = 'P180D';
const LEASE_BASE_PATH = '.github/arm-leases';

function parseArgs() {
    const args = {
        input: null,
        service: null,
        resourceProvider: null,
        serviceGroups: [],
        reviewer: null,
        startdate: null,
        duration: DEFAULT_DURATION,
        repoRoot: null,
        dryRun: false,
        interactive: false,
    };

    for (let i = 2; i < process.argv.length; i++) {
        const arg = process.argv[i];
        switch (arg) {
            case '--help':
            case '-h':
                printHelp();
                process.exit(0);
            case '--input':
                args.input = process.argv[++i];
                break;
            case '--service':
                args.service = process.argv[++i];
                break;
            case '--resource-provider':
            case '--rp':
                args.resourceProvider = process.argv[++i];
                break;
            case '--service-groups':
            case '--sg':
                args.serviceGroups = process.argv[++i].split(',').map(s => s.trim()).filter(Boolean);
                break;
            case '--reviewer':
                args.reviewer = process.argv[++i];
                break;
            case '--startdate':
                args.startdate = process.argv[++i];
                break;
            case '--duration':
                args.duration = process.argv[++i];
                break;
            case '--repo-root':
                args.repoRoot = process.argv[++i];
                break;
            case '--dry-run':
                args.dryRun = true;
                break;
            case '--interactive':
            case '-i':
                args.interactive = true;
                break;
            default:
                console.error(`Unknown argument: ${arg}`);
                process.exit(1);
        }
    }

    return args;
}

function printHelp() {
    console.log(`
Generate lease.yaml files for Azure Resource Providers

Usage:
  Single RP:
    node generate-lease-files.js --service <name> --resource-provider <name> --reviewer <name> [options]

  From input file:
    node generate-lease-files.js --input <file> --reviewer <name> [options]

  Interactive mode:
    node generate-lease-files.js --interactive

Options:
  --service <name>                Service name (lowercase alphanumeric)
  --resource-provider, --rp <name> Resource provider name (e.g., Microsoft.Test)
  --service-groups, --sg <list>   Comma-separated service groups (e.g., DiskRP,ComputeRP)
  --reviewer <name>               Reviewer name (required)
  --startdate <YYYY-MM-DD>        Lease start date (default: today)
  --duration <P#D>                Lease duration (default: P180D, max: P180D)
  --repo-root <path>              Repository root path (auto-detected if not provided)
  --dry-run                       Show what would be created without writing files
  --interactive, -i               Interactive mode with prompts
  --help, -h                      Show this help message

Input File Format:
  The input file should contain one entry per line in CSV format:
  - Without service groups: service, resource_provider
  - With service groups: service, resource_provider, [group1, group2, ...]

  Example:
    storage, Microsoft.Storage
    compute, Microsoft.Compute, [ComputeRP, DiskRP, GalleryRP]

Examples:
  # Single RP without service groups
  node generate-lease-files.js --service storage --rp Microsoft.Storage --reviewer "John Doe"

  # Single RP with service groups
  node generate-lease-files.js --service compute --rp Microsoft.Compute \\
    --sg "ComputeRP,DiskRP" --reviewer "Jane Smith"

  # From fetch-resource-providers.js output
  node fetch-resource-providers.js > rps.txt
  node generate-lease-files.js --input rps.txt --reviewer "John Doe"

  # From fetch-resource-providers.js with service groups
  node fetch-resource-providers.js --with-service-groups > rps-with-groups.txt
  node generate-lease-files.js --input rps-with-groups.txt --reviewer "Jane Smith"

  # Interactive mode
  node generate-lease-files.js --interactive

  # Dry run to preview
  node generate-lease-files.js --input rps.txt --reviewer "Test" --dry-run

Output:
  Creates lease.yaml files at:
  .github/arm-leases/<service>/<resource-provider>/[<service-group>/]lease.yaml

  Each file contains:
    lease:
      resource-provider: <RP-name>
      startdate: <YYYY-MM-DD>
      duration-days: <P#D>
      reviewer: <name>
`);
}

function findRepoRoot(startPath = process.cwd()) {
    let current = path.resolve(startPath);
    for (let i = 0; i < 6; i++) {
        if (fs.existsSync(path.join(current, 'specification'))) {
            return current;
        }
        const parent = path.dirname(current);
        if (parent === current) break;
        current = parent;
    }
    throw new Error('Could not find repository root. Run from within azure-rest-api-specs.');
}

function validateStartDate(date) {
    if (!/^\d{4}-\d{2}-\d{2}$/.test(date)) {
        throw new Error(`Invalid date format: ${date}. Expected YYYY-MM-DD`);
    }
    const dateObj = new Date(date);
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    if (dateObj < today) {
        throw new Error(`Startdate cannot be in the past: ${date}`);
    }
    
    return date;
}

function validateDuration(duration) {
    const match = duration.match(/^P(\d+)D$/i);
    if (!match) {
        throw new Error(`Invalid duration format: ${duration}. Expected P#D (e.g., P180D)`);
    }
    
    const days = parseInt(match[1], 10);
    if (days <= 0 || days > 180) {
        throw new Error(`Duration must be between 1 and 180 days. Got: ${days}`);
    }
    
    return duration.toUpperCase();
}

function validateResourceProvider(rp) {
    const parts = rp.split('.');
    for (const part of parts) {
        if (!/^[A-Z]/.test(part)) {
            throw new Error(`Resource provider parts must start with capital letter: ${rp}`);
        }
    }
    return rp;
}

function validateServiceName(service) {
    if (!/^[a-z0-9]+$/.test(service)) {
        throw new Error(`Service name must be lowercase alphanumeric: ${service}`);
    }
    return service;
}

function parseInputLine(line) {
    line = line.trim();
    if (!line || line.startsWith('#')) {
        return null;
    }

    const match = line.match(/^([^,]+),\s*([^,\[]+)(?:,\s*\[([^\]]+)\])?$/);
    if (!match) {
        console.warn(`Skipping invalid line: ${line}`);
        return null;
    }

    const service = match[1].trim();
    const resourceProvider = match[2].trim();
    const serviceGroupsStr = match[3];
    const serviceGroups = serviceGroupsStr 
        ? serviceGroupsStr.split(',').map(s => s.trim()).filter(Boolean)
        : [];

    return { service, resourceProvider, serviceGroups };
}

function generateLeaseYaml(resourceProvider, startdate, duration, reviewer) {
    return `lease:
  resource-provider: ${resourceProvider}
  startdate: ${startdate}
  duration-days: ${duration}
  reviewer: ${reviewer}
`;
}

function getLeasePath(repoRoot, service, resourceProvider, serviceGroup = null) {
    const basePath = path.join(repoRoot, LEASE_BASE_PATH, service, resourceProvider);
    if (serviceGroup) {
        return path.join(basePath, serviceGroup, 'lease.yaml');
    }
    return path.join(basePath, 'lease.yaml');
}

function createLeaseFile(filePath, content, dryRun = false) {
    if (dryRun) {
        console.log(`[DRY RUN] Would create: ${filePath}`);
        console.log(content);
        console.log('---');
        return;
    }

    const dir = path.dirname(filePath);
    if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true });
    }

    if (fs.existsSync(filePath)) {
        console.warn(`Warning: File already exists, skipping: ${filePath}`);
        return;
    }

    fs.writeFileSync(filePath, content, 'utf-8');
    console.log(`Created: ${filePath}`);
}

function processEntry(entry, args, repoRoot) {
    const { service, resourceProvider, serviceGroups } = entry;
    const { startdate, duration, reviewer, dryRun } = args;

    try {
        validateServiceName(service);
        validateResourceProvider(resourceProvider);

        const content = generateLeaseYaml(resourceProvider, startdate, duration, reviewer);

        if (serviceGroups.length === 0) {
            const leasePath = getLeasePath(repoRoot, service, resourceProvider);
            createLeaseFile(leasePath, content, dryRun);
        } else {
            for (const group of serviceGroups) {
                const leasePath = getLeasePath(repoRoot, service, resourceProvider, group);
                createLeaseFile(leasePath, content, dryRun);
            }
        }
    } catch (error) {
        console.error(`Error processing ${service}/${resourceProvider}: ${error.message}`);
    }
}

async function promptInteractive() {
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });

    const question = (prompt) => new Promise((resolve) => {
        rl.question(prompt, resolve);
    });

    console.log('\nInteractive Lease File Generator');
    console.log('=================================\n');

    const reviewer = await question('Enter reviewer name (required): ');
    if (!reviewer.trim()) {
        console.error('Error: Reviewer name is required');
        rl.close();
        process.exit(1);
    }

    const startdateInput = await question(`Enter start date [YYYY-MM-DD] (default: ${getTodayDate()}): `);
    const startdate = startdateInput.trim() || getTodayDate();

    const durationInput = await question(`Enter duration [P#D] (default: ${DEFAULT_DURATION}): `);
    const duration = durationInput.trim() || DEFAULT_DURATION;

    console.log('\nEnter resource provider entries (one per line, empty line to finish):');
    console.log('Format: service, resource_provider, [optional_groups]');
    console.log('Example: storage, Microsoft.Storage');
    console.log('Example: compute, Microsoft.Compute, [ComputeRP, DiskRP]\n');

    const entries = [];
    while (true) {
        const line = await question('> ');
        if (!line.trim()) break;
        
        const entry = parseInputLine(line);
        if (entry) {
            entries.push(entry);
        }
    }

    rl.close();

    return {
        reviewer: reviewer.trim(),
        startdate,
        duration,
        entries,
        dryRun: false,
    };
}

function getTodayDate() {
    const today = new Date();
    return today.toISOString().split('T')[0];
}

async function main() {
    let args = parseArgs();

    if (args.interactive) {
        const interactive = await promptInteractive();
        args.reviewer = interactive.reviewer;
        args.startdate = interactive.startdate;
        args.duration = interactive.duration;
        
        if (interactive.entries.length === 0) {
            console.error('Error: No entries provided');
            return 1;
        }

        try {
            const repoRoot = args.repoRoot ? path.resolve(args.repoRoot) : findRepoRoot();
            const startdate = validateStartDate(args.startdate);
            const duration = validateDuration(args.duration);

            console.log(`\nRepository root: ${repoRoot}`);
            console.log(`Reviewer: ${args.reviewer}`);
            console.log(`Start date: ${startdate}`);
            console.log(`Duration: ${duration}\n`);

            for (const entry of interactive.entries) {
                processEntry(entry, { ...args, startdate, duration }, repoRoot);
            }

            console.log(`\nProcessed ${interactive.entries.length} entries`);
            return 0;
        } catch (error) {
            console.error(`Error: ${error.message}`);
            return 1;
        }
    }

    if (!args.reviewer) {
        console.error('Error: --reviewer is required');
        console.error('Use --help for usage information');
        return 1;
    }

    if (!args.startdate) {
        args.startdate = getTodayDate();
    }

    try {
        const repoRoot = args.repoRoot ? path.resolve(args.repoRoot) : findRepoRoot();
        const startdate = validateStartDate(args.startdate);
        const duration = validateDuration(args.duration);

        console.log(`Repository root: ${repoRoot}`);
        console.log(`Reviewer: ${args.reviewer}`);
        console.log(`Start date: ${startdate}`);
        console.log(`Duration: ${duration}\n`);

        const entries = [];

        if (args.input) {
            const inputPath = path.resolve(args.input);
            if (!fs.existsSync(inputPath)) {
                throw new Error(`Input file not found: ${inputPath}`);
            }

            const content = fs.readFileSync(inputPath, 'utf-8');
            const lines = content.split('\n');
            
            for (const line of lines) {
                const entry = parseInputLine(line);
                if (entry) {
                    entries.push(entry);
                }
            }

            if (entries.length === 0) {
                console.warn('Warning: No valid entries found in input file');
                return 0;
            }
        } else if (args.service && args.resourceProvider) {
            entries.push({
                service: args.service,
                resourceProvider: args.resourceProvider,
                serviceGroups: args.serviceGroups,
            });
        } else {
            console.error('Error: Either --input or both --service and --resource-provider are required');
            console.error('Use --help for usage information');
            return 1;
        }

        for (const entry of entries) {
            processEntry(entry, { ...args, startdate, duration }, repoRoot);
        }

        console.log(`\nProcessed ${entries.length} entries`);
        return 0;

    } catch (error) {
        console.error(`Error: ${error.message}`);
        return 1;
    }
}

if (require.main === module) {
    main().then(code => process.exit(code));
}

module.exports = {
    parseInputLine,
    generateLeaseYaml,
    getLeasePath,
    validateStartDate,
    validateDuration,
    validateResourceProvider,
    validateServiceName,
    getTodayDate,
};
