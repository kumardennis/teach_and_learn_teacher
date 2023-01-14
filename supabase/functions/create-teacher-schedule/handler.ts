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
import dayjs from 'https://cdn.skypack.dev/dayjs@1.11.6';
import lodash from 'https://cdn.skypack.dev/lodash';

console.log('Hello from get schedule Functions!');

const _ = lodash;

interface LessonScheduleCreateModel {
	teacherId: string;
	scheduleTimeStart: string;
	scheduleTimeEnd: string;
	scheduleDate: string;
	maxOccupancy: string;
	subcategoryId: string;
	canBeSeenBy: string;
	durationInMins: number | null;
	feeForTheLesson: number | null;
	feePerOccupant: number | null;
	lateCancellationPenalty: number;
	levelFrom: number;
	levelUpto: number;
	isRegularGroup: boolean;
	groupId: string | null;
	autoAddWaitingStudents: boolean;
}

export const handler = async (req: Request) => {
	const supabase = createSupabase(req);
	const responseData: ResponseModel = {} as ResponseModel;

	try {
		const {
			teacherId,
			scheduleTimeStart,
			scheduleTimeEnd,
			scheduleDate,
			maxOccupancy,
			subcategoryId,
			canBeSeenBy,
			feeForTheLesson,
			lateCancellationPenalty,
			levelFrom,
			levelUpto,
		} = await req.json();

		if (
			!confirmedRequiredParams([
				teacherId,
				scheduleTimeStart,
				scheduleTimeEnd,
				scheduleDate,
				maxOccupancy,
				subcategoryId,
				canBeSeenBy,
				feeForTheLesson,
				lateCancellationPenalty,
				levelFrom,
				levelUpto,
			])
		) {
			return new Response(JSON.stringify(errorResponseData), {
				headers: { 'Content-Type': 'application/json' },
			});
		}

		const teacherSubcategoryResponse = await supabase
			.from('Teachers_Subcategories')
			.select('feePerHour')
			.eq('teacherId', teacherId);

		if (teacherSubcategoryResponse.error !== null) {
			responseData.isRequestSuccessful = false;
			responseData.data = teacherSubcategoryResponse.data;
			responseData.error = teacherSubcategoryResponse.error;

			return new Response(JSON.stringify(responseData), {
				headers: { 'Content-Type': 'application/json' },
			});
		}

		const teacherPerHourRate =
			teacherSubcategoryResponse.data[0].feePerHour;

		const schedule: LessonScheduleCreateModel = {
			teacherId,
			scheduleTimeStart,
			scheduleTimeEnd,
			scheduleDate,
			maxOccupancy,
			subcategoryId,
			canBeSeenBy,
			durationInMins: maxOccupancy === 1
				? null
				: returnDifferenceBetweenTimes(
					scheduleTimeEnd,
					scheduleTimeStart,
				),
			feeForTheLesson: maxOccupancy === 1
				? teacherPerHourRate
				: feeForTheLesson,
			feePerOccupant: null,
			lateCancellationPenalty,
			levelFrom,
			levelUpto,
			isRegularGroup: false,
			groupId: null,
			autoAddWaitingStudents: false,
		};

		const createTeacherScheduleResponse = await supabase
			.from('LessonSchedules')
			.insert(schedule)
			.select();

		if (createTeacherScheduleResponse.error !== null) {
			responseData.isRequestSuccessful = false;
			responseData.data = createTeacherScheduleResponse.data;
			responseData.error = createTeacherScheduleResponse.error;

			return new Response(JSON.stringify(responseData), {
				headers: { 'Content-Type': 'application/json' },
			});
		}

		/* Create times from the schedule as well */
		if (maxOccupancy === 1) {
			const listOfTimes = returnTimesInBetween(
				scheduleTimeStart,
				scheduleTimeEnd,
			);

			const insertableTimes = listOfTimes.map((time) => {
				return {
					scheduleId: createTeacherScheduleResponse.data[0].id,
					time,
					isBooked: false,
				};
			});

			const { error } = await supabase
				.from('LessonScheduleTimes')
				.insert(insertableTimes);

			if (error !== null) {
				responseData.isRequestSuccessful = false;
				responseData.data = null;
				responseData.error = error;

				return new Response(JSON.stringify(responseData), {
					headers: { 'Content-Type': 'application/json' },
				});
			}
		} else {
			const insertableTimes = {
				scheduleId: createTeacherScheduleResponse.data[0].id,
				time: scheduleTimeStart,
				isBooked: false,
			};

			const { error } = await supabase
				.from('LessonScheduleTimes')
				.insert(insertableTimes);

			if (error !== null) {
				responseData.isRequestSuccessful = false;
				responseData.data = null;
				responseData.error = error;

				return new Response(JSON.stringify(responseData), {
					headers: { 'Content-Type': 'application/json' },
				});
			}
		}

		responseData.isRequestSuccessful = true;
		responseData.data = createTeacherScheduleResponse.data;
		responseData.error = createTeacherScheduleResponse.error;

		return new Response(JSON.stringify(responseData), {
			headers: { 'Content-Type': 'application/json' },
		});
	} catch (err) {
		responseData.isRequestSuccessful = false;
		responseData.data = null;
		responseData.error = err;

		return new Response(JSON.stringify(responseData), {
			headers: { 'Content-Type': 'application/json' },
		});
	}
};
