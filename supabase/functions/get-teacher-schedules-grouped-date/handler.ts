// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from 'https://deno.land/std@0.131.0/http/server.ts';
import {
	confirmedRequiredParams,
	errorResponseData,
} from '../_shared/confirmedRequiredParams.ts';
import { ResponseModel } from '../_shared/ResponseModel.ts';
import { createSupabase } from '../_shared/supabaseClient.ts';
import dayjs from 'https://cdn.skypack.dev/dayjs@1.11.6';
import lodash from 'https://cdn.skypack.dev/lodash';
import { corsHeaders } from '../_shared/cors.ts';

console.log('Hello from get schedule Functions!');

const _ = lodash;

export const handler = async (req: Request) => {
	const supabase = createSupabase(req);
	const responseData: ResponseModel = {} as ResponseModel;

	console.log('Hello from get schedule Functions!');

	try {
		const { handlerName, teacherId, isInPast } = await req.json();

		if (!confirmedRequiredParams([teacherId, isInPast])) {
			return new Response(JSON.stringify(errorResponseData), {
				headers: { ...corsHeaders, 'Content-Type': 'application/json' },
			});
		}

		const lessonScheduleTimeQueryString =
			'LessonScheduleTimes(scheduleId, time, isBooked, id)';

		const query = supabase
			.from('LessonSchedules')
			.select(
				`*`,
			)
			.eq('teacherId', teacherId)
			// .eq('LessonScheduleTimes.isBooked', true)
			.order('scheduleDate', { ascending: true });

		const todaysDate = dayjs().format('YYYY-MM-DD');

		const { data, error } = isInPast
			? await query.lt('scheduleDate', todaysDate)
			: await query.gte('scheduleDate', todaysDate);

		/* Group schedules by date */

		if (data !== null) {
			const groupedDate = _.groupBy(
				data,
				(schedule: { scheduleDate: any }) => schedule.scheduleDate,
			);

			const groupedDateFormattedForModel: {
				date: string;
				scheduleData: any;
			}[] = [];

			Object.keys(groupedDate).forEach((key) => {
				groupedDateFormattedForModel.push({
					date: key,
					scheduleData: groupedDate[key],
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
