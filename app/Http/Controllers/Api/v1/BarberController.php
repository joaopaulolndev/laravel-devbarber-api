<?php

namespace App\Http\Controllers\Api\v1;

use App\Models\Barber;
use App\Models\BarberService;
use App\Models\UserFavorite;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class BarberController extends Controller
{
    public function index(Request $request)
    {
        $limit = $request->limit ?? static::LIMITDEFAULT;
        $barbers = Barber::geolocation($request->only(['latitude','longitude','city']))
            ->simplePaginate($limit);

        return response()->json([
            'error' => false,
            'data' => $barbers
        ]);
    }

    public function search(Request $request)
    {
        $limit = $request->limit ?? static::LIMITDEFAULT;
        $barbers = Barber::filter($request->only(['q']))->simplePaginate($limit);

        return response()->json([
            'error' => false,
            'data' => $barbers
        ]);
    }

    public function show($id)
    {
        $barber = Barber::with([
            'services',
            'photos',
            'comments',
            'availabilities',
            'appointments' => function($qa) {
                $qa->whereBetween('appointment_datetime', [
                    date('Y-m-d') . ' 00:00:00',
                    date('Y-m-d', strtotime('+20 days')) . ' 23:59:59',
                ]);
            }
        ])->find($id);

        if (!$barber) {
            return response()->json([
                'error' => true,
                'message' => 'Este barbeiro não existe'
            ]);
        }

        $availabilities = $barber->availabilities;
        $appointments = $barber->appointments;

        $barber->available = $barber->getHours($availabilities, $appointments);
        $barber->favorited = (new UserFavorite())->barberFavorited($barber->id);

        return response()->json([
            'error' => false,
            'data' => $barber
        ]);
    }

    public function addAppoitment(Request $request, $id)
    {
        $this->validate($request, [
            'barber_service_id' => 'required|exists:barber_services,id',
            'year' => 'required|min:4',
            'month' => 'required|min:2',
            'day' => 'required|min:2',
            'hour' => 'required|min:2',
        ]);

        $barber_service_id = $request->barber_service_id;
        $year = $request->year;
        $month = $request->month;
        $day = $request->day;
        $hour = $request->hour;

        $barber = Barber::find($id);
        if (!$barber) {
            return response()->json([
                'error' => true,
                'message' => 'Este barbeiro não existe'
            ]);
        }

        // verificar se o serviço existe
        $barberService = $barber->services()->where('id', $barber_service_id)->first();
        if (!$barberService) {
            return response()->json([
                'error' => true,
                'message' => 'Este serviço não existe'
            ]);
        }

        // verificar se eh uma data
        $dateFormat = $year . '-' . $month . '-' . $day . ' ' . $hour . ':00:00';
        if (!strtotime($dateFormat) > 0) {
            return response()->json([
                'error' => true,
                'message' => 'Data inválida ' . $dateFormat
            ]);
        }

        // verificar se o barbeiro já possui agendamento neste dia/hora
        if ($barber->appointments()->where('appointment_datetime', $dateFormat)->count()) {
            return response()->json([
                'error' => true,
                'message' => 'Este barbeiro não está disponível nesta data e hora ' . $dateFormat . ' - ' .$hour . ':00'
            ]);
        }

        // verificar se o barbeiro atende nesta data
        $weekday = date('w', strtotime($dateFormat));
        $availability = $barber->availabilities()->where('weekday', $weekday)->first();
        if (!$availability) {
            return response()->json([
                'error' => true,
                'message' => 'Este barbeiro não atende neste dia ' . $dateFormat . ' - ' .$hour . ':00'
            ]);
        }

        // verificar se o barbeiro atende nesta hora
        if (!in_array($hour . ':00', $availability->hours_array)) {
            return response()->json([
                'error' => true,
                'message' => 'Este barbeiro não atende nesta hora ' . $dateFormat . ' - ' .$hour . ':00'
            ]);
        }

        // fazer o agendamento
        $barber->appointments()->create([
            'user_id' => auth()->user()->id,
            'barber_service_id' => $barber_service_id,
            'appointment_datetime' => $dateFormat
        ]);

        return response()->json([
            'error' => false,
            'message' => 'Agendamento criado com sucesso'
        ]);
    }
}
