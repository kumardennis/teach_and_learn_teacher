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

console.log('Hello from Lesson Schedule Functions!');

interface LessonScheduleUpdateModel {
	teacherId: string;
	scheduleTimeStart: string;
	scheduleTimeEnd: string;
	scheduleDate: string;
	maxOccupancy: string;
	canBeSeenBy: string;
	durationInMins: number | null;
	feeForTheLesson: number | null;
	levelFrom: number;
	levelUpto: number;
	autoAddWaitingStudents: boolean;
}

serve(async (req) => {
	const supabase = createSupabase(req);
	const responseData: ResponseModel = {} as ResponseModel;

	try {
		const {
			teacherId,
			scheduleId,
			scheduleTimeStart,
			scheduleTimeEnd,
			scheduleDate,
			maxOccupancy,
			canBeSeenBy,
			feeForTheLesson,
			levelFrom,
			levelUpto,
			autoAddWaitingStudents,
		} = await req.json();

		if (
			!confirmedRequiredParams([
				teacherId,
				scheduleId,
				scheduleTimeStart,
				scheduleTimeEnd,
				scheduleDate,
				maxOccupancy,
				canBeSeenBy,
				feeForTheLesson,
				levelFrom,
				levelUpto,
				autoAddWaitingStudents,
			])
		) {
			return new Response(JSON.stringify(errorResponseData), {
				headers: { 'Content-Type': 'application/json' },
			});
		}

		const teacherSubcategoryResponse = await supabase.from(
			'Teachers_Subcategories',
		).select('feePerHour').eq('teacherId', teacherId);

		if (teacherSubcategoryResponse.error !== null) {
			responseData.isRequestSuccessful = false;
			responseData.data = teacherSubcategoryResponse.data;
			responseData.error = teacherSubcategoryResponse.error;

			return new Response(JSON.stringify(responseData), {
				headers: { 'Content-Type': 'application/json' },
			});
		}

		const savedScheduleResponse = await supabase.from('LessonSchedules')
			.select().eq('id', scheduleId);

		if (savedScheduleResponse.error !== null) {
			responseData.isRequestSuccessful = false;
			responseData.data = savedScheduleResponse.data;
			responseData.error = savedScheduleResponse.error;

			return new Response(JSON.stringify(responseData), {
				headers: { 'Content-Type': 'application/json' },
			});
		}

		const savedScheduleResponseData = savedScheduleResponse?.data[0];

		const teacherPerHourRate =
			teacherSubcategoryResponse.data[0].feePerHour;

		const schedule: LessonScheduleUpdateModel = {
			teacherId,
			scheduleTimeStart,
			scheduleTimeEnd,
			scheduleDate,
			maxOccupancy,
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
			levelFrom,
			levelUpto,
			autoAddWaitingStudents,
		};

		/* If maxOccupancy===1 ? can only update start time and end time if time slot is not booked, canBeSeenBy, feeForTheLesson, level */

		/* If maxOccupancy>1 ? can update start/end time, maxOccupancy, canBeSeenBy, feeForTheLesson, level */

		const updateTeacherScheduleResponse = await supabase
			.from('LessonSchedules')
			.update(schedule)
			.eq('id', scheduleId)
			.select();

		if (updateTeacherScheduleResponse.error !== null) {
			responseData.isRequestSuccessful = false;
			responseData.data = updateTeacherScheduleResponse.data;
			responseData.error = updateTeacherScheduleResponse.error;

			return new Response(JSON.stringify(responseData), {
				headers: { 'Content-Type': 'application/json' },
			});
		}

		/* If change in start/end times */
		if (
			savedScheduleResponseData.scheduleTimeStart !==
				`${scheduleTimeStart}:00` ||
			savedScheduleResponseData.scheduleTimeEnd !==
				`${scheduleTimeEnd}:00`
		) {
			/* Update times from the schedule as well */
			if (maxOccupancy === 1) {
				/* Delete stale times */
				await supabase.from('LessonScheduleTimes').delete().match({
					scheduleId,
					isBooked: false,
				});

				const bookedSlotsResponse = await supabase.from(
					'LessonScheduleTimes',
				).select('time').match({ scheduleId, isBooked: true });

				const bookedSlotsResponseData = bookedSlotsResponse.data;

				let filteredTimes = [];

				const listOfTimes = returnTimesInBetween(
					scheduleTimeStart,
					scheduleTimeEnd,
				);

				if (
					bookedSlotsResponseData?.length !== undefined &&
					bookedSlotsResponseData?.length > 0
				) {
					filteredTimes = listOfTimes.filter((time) =>
						bookedSlotsResponseData.findIndex((booked) =>
							`${time}:00` === booked.time
						) === -1
					);
				} else filteredTimes = listOfTimes;

				const updatableTimes = filteredTimes.map((time) => {
					return {
						scheduleId,
						time,
						isBooked: false,
					};
				});

				const { error } = await supabase.from('LessonScheduleTimes')
					.insert(updatableTimes);

				if (error !== null) {
					responseData.isRequestSuccessful = false;
					responseData.data = null;
					responseData.error = error;

					return new Response(JSON.stringify(responseData), {
						headers: { 'Content-Type': 'application/json' },
					});
				}
			} else {
				const updatableTimes = {
					scheduleId: scheduleId,
					time: scheduleTimeStart,
					isBooked: false,
				};

				const { error } = await supabase.from('LessonScheduleTimes')
					.update(updatableTimes).eq('scheduleId', scheduleId);

				if (error !== null) {
					responseData.isRequestSuccessful = false;
					responseData.data = 'fuck';
					responseData.error = error;

					return new Response(JSON.stringify(responseData), {
						headers: { 'Content-Type': 'application/json' },
					});
				}
			}
		}

		responseData.isRequestSuccessful = true;
		responseData.data = updateTeacherScheduleResponse.data;
		responseData.error = updateTeacherScheduleResponse.error;

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
});
