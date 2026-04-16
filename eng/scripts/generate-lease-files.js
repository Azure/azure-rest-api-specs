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
        orgName: null,
        rpNamespace: null,
        serviceNames: [],
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
            case '--orgName':
            case '--service':
                args.orgName = process.argv[++i];
                break;
            case '--rpNamespace':
            case '--resource-provider':
            case '--rp':
                args.rpNamespace = process.argv[++i];
                break;
            case '--serviceName':
            case '--service-groups':
            case '--sg':
                args.serviceNames = process.argv[++i].split(',').map(s => s.trim()).filter(Boolean);
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
    node generate-lease-files.js --orgName <name> --rpNamespace <name> --reviewer <name> [options]

  From input file:
    node generate-lease-files.js --input <file> --reviewer <name> [options]

  Interactive mode:
    node generate-lease-files.js --interactive

Options:
  --orgName <name>                Organization/service name (lowercase alphanumeric)
  --rpNamespace <name>            Resource provider namespace (e.g., Microsoft.Storage)
  --serviceName <list>            Comma-separated service groups (e.g., DiskRP,ComputeRP)
  --reviewer <name>               Reviewer GitHub alias starting with @ (e.g., @githubUser)
  --startdate <YYYY-MM-DD>        Lease start date (default: today)
  --duration <P#D>                Lease duration (default: P180D, max: P180D)
  --repo-root <path>              Repository root path (auto-detected if not provided)
  --dry-run                       Show what would be created without writing files
  --interactive, -i               Interactive mode with prompts
  --help, -h                      Show this help message

Input File Format:
  The input file should contain one entry per line in CSV format:
  - Without service groups: orgName, rpNamespace
  - With service groups: orgName, rpNamespace, [serviceName1, serviceName2, ...]

  Example:
    storage, Microsoft.Storage
    compute, Microsoft.Compute, [ComputeRP, DiskRP, GalleryRP]

Examples:
  # Single RP without service groups
  node generate-lease-files.js --orgName storage --rpNamespace Microsoft.Storage --reviewer "@johnDoe"

  # Single RP with service groups
  node generate-lease-files.js --orgName compute --rpNamespace Microsoft.Compute \\
    --serviceName "ComputeRP,DiskRP" --reviewer "@janeSmith"

  # From fetch-resource-providers.js output
  node fetch-resource-providers.js > rps.txt
  node generate-lease-files.js --input rps.txt --reviewer "@johnDoe"

  # From fetch-resource-providers.js with service groups
  node fetch-resource-providers.js --with-service-groups > rps-with-groups.txt
  node generate-lease-files.js --input rps-with-groups.txt --reviewer "@janeSmith"

  # Interactive mode
  node generate-lease-files.js --interactive

  # Dry run to preview
  node generate-lease-files.js --input rps.txt --reviewer "@testUser" --dry-run

Output:
  Creates lease.yaml files at:
  .github/arm-leases/<orgName>/<rpNamespace>/[<serviceName>/]lease.yaml

  Each file contains:
    lease:
      resource-provider: <rpNamespace>
      startdate: <YYYY-MM-DD>
      duration: <P#D>
      reviewer: <@githubAlias>
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
    if (isNaN(dateObj.getTime())) {
        throw new Error(`Invalid calendar date: ${date}`);
    }
    const gracePeriodDate = new Date();
    gracePeriodDate.setHours(0, 0, 0, 0);
    gracePeriodDate.setDate(gracePeriodDate.getDate() - 10);

    if (dateObj < gracePeriodDate) {
        throw new Error(`Startdate is too far in the past: ${date} (must be within 10 days of today)`);
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

function validateRpNamespace(rpNamespace) {
    const parts = rpNamespace.split('.');
    for (const part of parts) {
        if (!/^[A-Z]/.test(part)) {
            throw new Error(`rpNamespace parts must start with capital letter: ${rpNamespace}`);
        }
    }
    return rpNamespace;
}

function validateOrgName(orgName) {
    if (!/^[a-z0-9]+$/.test(orgName)) {
        throw new Error(`orgName must be lowercase alphanumeric: ${orgName}`);
    }
    return orgName;
}

function validateReviewer(reviewer) {
    if (!reviewer || reviewer.trim().length === 0) {
        throw new Error('Reviewer is required and cannot be empty');
    }
    const trimmed = reviewer.trim();
    if (!trimmed.startsWith('@') || trimmed.length <= 1) {
        throw new Error(`Reviewer must be a GitHub alias starting with @ (e.g., @githubUser). Got: ${reviewer}`);
    }
    return trimmed;
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

    const orgName = match[1].trim();
    const rpNamespace = match[2].trim();
    const serviceNamesStr = match[3];
    const serviceNames = serviceNamesStr
        ? serviceNamesStr.split(',').map(s => s.trim()).filter(Boolean)
        : [];

    return { orgName, rpNamespace, serviceNames };
}

function generateLeaseYaml(rpNamespace, startdate, duration, reviewer) {
    return `lease:
  resource-provider: ${rpNamespace}
  startdate: ${startdate}
  duration: ${duration}
  reviewer: ${reviewer}
`;
}

function getLeasePath(repoRoot, orgName, rpNamespace, serviceName = null) {
    const basePath = path.join(repoRoot, LEASE_BASE_PATH, orgName, rpNamespace);
    if (serviceName) {
        return path.join(basePath, serviceName, 'lease.yaml');
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
    const { orgName, rpNamespace, serviceNames } = entry;
    const { startdate, duration, reviewer, dryRun } = args;

    try {
        validateOrgName(orgName);
        validateRpNamespace(rpNamespace);

        const content = generateLeaseYaml(rpNamespace, startdate, duration, reviewer);

        if (serviceNames.length === 0) {
            const leasePath = getLeasePath(repoRoot, orgName, rpNamespace);
            createLeaseFile(leasePath, content, dryRun);
        } else {
            for (const serviceName of serviceNames) {
                const leasePath = getLeasePath(repoRoot, orgName, rpNamespace, serviceName);
                createLeaseFile(leasePath, content, dryRun);
            }
        }
    } catch (error) {
        console.error(`Error processing ${orgName}/${rpNamespace}: ${error.message}`);
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

    const reviewer = await question('Enter reviewer GitHub alias (required, e.g., @githubUser): ');
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
    console.log('Format: orgName, rpNamespace, [optional serviceNames]');
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
            const reviewer = validateReviewer(args.reviewer);
            const startdate = validateStartDate(args.startdate);
            const duration = validateDuration(args.duration);

            console.log(`\nRepository root: ${repoRoot}`);
            console.log(`Reviewer: ${reviewer}`);
            console.log(`Start date: ${startdate}`);
            console.log(`Duration: ${duration}\n`);

            for (const entry of interactive.entries) {
                processEntry(entry, { ...args, startdate, duration, reviewer }, repoRoot);
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
        const reviewer = validateReviewer(args.reviewer);
        const startdate = validateStartDate(args.startdate);
        const duration = validateDuration(args.duration);

        console.log(`Repository root: ${repoRoot}`);
        console.log(`Reviewer: ${reviewer}`);
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
        } else if (args.orgName && args.rpNamespace) {
            entries.push({
                orgName: args.orgName,
                rpNamespace: args.rpNamespace,
                serviceNames: args.serviceNames,
            });
        } else {
            console.error('Error: Either --input or both --orgName and --rpNamespace are required');
            console.error('Use --help for usage information');
            return 1;
        }

        for (const entry of entries) {
            processEntry(entry, { ...args, startdate, duration, reviewer }, repoRoot);
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
    validateRpNamespace,
    validateOrgName,
    validateReviewer,
    getTodayDate,
};
