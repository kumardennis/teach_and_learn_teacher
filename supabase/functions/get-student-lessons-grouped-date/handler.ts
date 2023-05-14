// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import dayjs from 'https://cdn.skypack.dev/-/dayjs@v1.11.6-77Jm7cE3hNuQn3XDVXyF/dist=es2019,mode=imports/optimized/dayjs.js';
import { serve } from 'https://deno.land/std@0.131.0/http/server.ts';
import {
	confirmedRequiredParams,
	errorResponseData,
} from '../_shared/confirmedRequiredParams.ts';
import { corsHeaders } from '../_shared/cors.ts';
import { ResponseModel } from '../_shared/ResponseModel.ts';
import { createSupabase } from '../_shared/supabaseClient.ts';
import lodash from 'https://cdn.skypack.dev/lodash';

const _ = lodash;

console.log('Hello from get schedule Functions!');

export const handler = async (req: Request) => {
	const supabase = createSupabase(req);
	const responseData: ResponseModel = {} as ResponseModel;

	try {
		const {
			studentId,
			isInPast,
		} = await req.json();

		if (
			!confirmedRequiredParams([
				studentId,
				isInPast,
			])
		) {
			return new Response(JSON.stringify(errorResponseData), {
				headers: { ...corsHeaders, 'Content-Type': 'application/json' },
			});
		}

		const todaysDate = dayjs().format('YYYY-MM-DD');

		const query = supabase.from('Lessons').select(
			'id, LessonSchedules(id, scheduleDate)',
		).match({ studentId });

		const { data, error } = isInPast
			? await query.lt('LessonSchedules.scheduleDate', todaysDate)
			: await query.gte('LessonSchedules.scheduleDate', todaysDate);

		if (data !== null) {
			const groupedDate = _.groupBy(
				data,
				(lesson: {
					LessonSchedules: any;
				}) => lesson.LessonSchedules.scheduleDate,
			);

			const groupedDateFormattedForModel: {
				date: string;
				lessonData: any;
			}[] = [];

			Object.keys(groupedDate).forEach((key) => {
				groupedDateFormattedForModel.push({
					date: key,
					lessonData: groupedDate[key],
				});
			});

			responseData.isRequestSuccessful = error === null;
			responseData.data = groupedDateFormattedForModel;
			responseData.error = error;
		} else {
			responseData.isRequestSuccessful = error === null;
			responseData.data = data;
			responseData.error = error;
		}

		return new Response(JSON.stringify(responseData), {
			headers: { ...corsHeaders, 'Content-Type': 'application/json' },
		});
	} catch (err) {
		responseData.isRequestSuccessful = false;
		responseData.data = null;
		responseData.error = err;

		return new Response(JSON.stringify(responseData), {
			headers: { ...corsHeaders, 'Content-Type': 'application/json' },
		});
	}
};
