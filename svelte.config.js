import adapter from '@sveltejs/adapter-node';
import { vitePreprocess } from '@sveltejs/vite-plugin-svelte';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	// Consult https://kit.svelte.dev/docs/integrations#preprocessors
	// for more information about preprocessors
	preprocess: vitePreprocess(),

	kit: {
		// Use the Node.js adapter instead of auto
		adapter: adapter({
		  out: 'build', // Output directory for the build files
		  precompress: false, // Enable gzip compression for faster delivery
		}),
	},
};

export default config;
