// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { handler } from './handler.ts';
import { serve } from 'https://deno.land/std@0.131.0/http/server.ts';

console.log('Hello from Add teacher subcategory Functions!');

serve(handler);
