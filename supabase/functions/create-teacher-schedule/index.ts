// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from 'https://deno.land/std@0.131.0/http/server.ts';
import {
	confirmedRequiredParams,
	errorResponseData,
} from '../_shared/confirmedRequiredParams.ts';
import { ResponseModel } from '../_shared/ResponseModel.ts';
import { returnDifferenceBetweenTimes } from '../_shared/returnDifferenceBetweenTimes.ts';
import { returnTimesInBetween } from '../_shared/returnTimesInBetween.ts';
import { createSupabase } from '../_shared/supabaseClient.ts';
import { handler } from './handler.ts';

console.log('Hello from Lesson Schedule Functions!');

serve(handler);
