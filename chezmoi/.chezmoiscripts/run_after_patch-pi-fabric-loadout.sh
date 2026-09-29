#!/bin/sh
# Pi Fabric 0.101.1 registers its tool before it loads config. Pi calls this hook
# during registration, so accessing state.config here raises a startup error.
set -eu

PI_FABRIC_ROOT=${PI_FABRIC_ROOT:-"$HOME/.pi/agent/npm/node_modules/pi-fabric"}
export PI_FABRIC_ROOT
node <<'NODE'
const fs = require('node:fs');
const path = require('node:path');

const root = process.env.PI_FABRIC_ROOT;
const manifest = path.join(root, 'package.json');
if (!fs.existsSync(manifest)) process.exit(0); // Package may not be installed yet.
if (JSON.parse(fs.readFileSync(manifest, 'utf8')).version !== '0.101.1') process.exit(0);

const entry = path.join(root, 'dist/index.js');
const original = 'prepareLoadout: (loadout) => fabricToolLoadout(loadout, state.config.fullCodeMode || state.config.schema.mode === "enforce"),';
const patched = 'prepareLoadout: (loadout) => state.bootstrapped ? fabricToolLoadout(loadout, state.config.fullCodeMode || state.config.schema.mode === "enforce") : void 0,';
const source = fs.readFileSync(entry, 'utf8');
if (source.includes(patched)) process.exit(0);
if (source.split(original).length !== 2) throw new Error(`Unexpected Pi Fabric 0.101.1 loadout hook in ${entry}`);
fs.writeFileSync(entry, source.replace(original, patched));
console.log(`Patched Pi Fabric startup loadout hook: ${entry}`);
NODE
