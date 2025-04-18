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
import { corsHeaders } from '../_shared/cors.ts';

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
			scheduleDates,
			maxOccupancy,
			subcategoryId,
			canBeSeenBy,
			feeForTheLesson,
			lateCancellationPenalty,
			levelFrom,
			levelUpto,
			addressIds,
		} = await req.json();

		if (
			!confirmedRequiredParams([
				teacherId,
				scheduleTimeStart,
				scheduleTimeEnd,
				scheduleDates,
				maxOccupancy,
				subcategoryId,
				canBeSeenBy,
				feeForTheLesson,
				lateCancellationPenalty,
				levelFrom,
				levelUpto,
				addressIds,
			])
		) {
			return new Response(JSON.stringify(errorResponseData), {
				headers: { ...corsHeaders, 'Content-Type': 'application/json' },
			});
		}

		const lessonSchedules: LessonScheduleCreateModel[] = [];

		scheduleDates.forEach((scheduleDate: string) => {
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
				feeForTheLesson: feeForTheLesson,
				feePerOccupant: null,
				lateCancellationPenalty,
				levelFrom,
				levelUpto,
				isRegularGroup: false,
				groupId: null,
				autoAddWaitingStudents: false,
			};

			lessonSchedules.push(schedule);
		});

		const createTeacherScheduleResponse = await supabase
			.from('LessonSchedules')
			.insert(lessonSchedules)
			.select();

		if (createTeacherScheduleResponse.error !== null) {
			responseData.isRequestSuccessful = false;
			responseData.data = createTeacherScheduleResponse.data;
			responseData.error = createTeacherScheduleResponse.error;

			return new Response(JSON.stringify(responseData), {
				headers: { ...corsHeaders, 'Content-Type': 'application/json' },
			});
		}

		/* Create entry with addresses as well in Addresses_LessonSchedules */

		try {
			const addressId_scheduleId_data: {
				addressId: string;
				scheduleId: string;
			}[] = [];

			addressIds.forEach((addressId: string) =>
				createTeacherScheduleResponse.data.forEach((response) => {
					addressId_scheduleId_data.push({
						addressId: addressId,
						scheduleId: response.id,
					});
				})
			);

			const createAddressScheduleResponse = await supabase.from(
				'Addresses_LessonSchedules',
			).insert(addressId_scheduleId_data).select();

			console.log(
				createAddressScheduleResponse.data,
				createAddressScheduleResponse.error,
			);
		} catch (err) {
			responseData.isRequestSuccessful = false;
			responseData.data = null;
			responseData.error = err;

			console.log(err);

			return new Response(JSON.stringify(responseData), {
				headers: { ...corsHeaders, 'Content-Type': 'application/json' },
			});
		}

		/* Create times from the schedule as well */
		try {
			if (maxOccupancy === 1) {
				const listOfTimes = returnTimesInBetween(
					scheduleTimeStart,
					scheduleTimeEnd,
				);

				const insertableTimes: {
					scheduleId: any;
					time: string;
					isBooked: boolean;
				}[] = [];

				listOfTimes.forEach((time) => {
					createTeacherScheduleResponse.data.forEach(
						(response) => {
							insertableTimes.push({
								scheduleId: response.id,
								time,
								isBooked: false,
							});
						},
					);
				});

				console.log(insertableTimes);

				const { error } = await supabase
					.from('LessonScheduleTimes')
					.insert(insertableTimes);

				if (error !== null) {
					responseData.isRequestSuccessful = false;
					responseData.data = null;
					responseData.error = error;

					return new Response(JSON.stringify(responseData), {
						headers: {
							...corsHeaders,
							'Content-Type': 'application/json',
						},
					});
				}
			} else {
				const insertableTimes = createTeacherScheduleResponse.data.map(
					(response) => {
						return {
							scheduleId: response.id,
							time: scheduleTimeStart,
							isBooked: false,
						};
					},
				);

				const { error } = await supabase
					.from('LessonScheduleTimes')
					.insert(insertableTimes);

				if (error !== null) {
					responseData.isRequestSuccessful = false;
					responseData.data = null;
					responseData.error = error;

					return new Response(JSON.stringify(responseData), {
						headers: {
							...corsHeaders,
							'Content-Type': 'application/json',
						},
					});
				}
			}
		} catch (err) {
			console.log(err);

			responseData.isRequestSuccessful = false;
			responseData.data = null;
			responseData.error = err;

			console.log(err);

			return new Response(JSON.stringify(responseData), {
				headers: { ...corsHeaders, 'Content-Type': 'application/json' },
			});
		}

		responseData.isRequestSuccessful = true;
		responseData.data = createTeacherScheduleResponse.data;
		responseData.error = createTeacherScheduleResponse.error;

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
