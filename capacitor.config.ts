import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.orebeats.player',
  appName: 'Ore Beats',
  webDir: 'dist',
  bundledWebRuntime: false,
  ios: {
    contentInset: 'automatic',
    scheme: 'orebeats'
  }
};

export default config;
