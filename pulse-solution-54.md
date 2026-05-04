import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.reinhardtmarta.a4flow',
  appName: 'a4-flow',
  webDir: 'dist',
  server: {
    androidScheme: 'https'
  },
  // Configurações para melhorar a experiência mobile
  plugins: {
    SplashScreen: {
      launchShowDuration: 2000,
      backgroundColor: '#0f172a',
      showSpinner: true,
      androidSpinnerStyle: 'large',
      spinnerColor: '#3b82f6'
    }
  }
};

export default config;