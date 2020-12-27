<?php

namespace App\Http\Controllers\Api\v1;

use App\Models\Barber;
use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class UserController extends Controller
{
    public function getFavorites()
    {
        $user = User::with(['favorites'])->find(auth()->user()->id);
        if (!$user) {
            return response()->json([
                'error' => true,
                'message' => 'Você não está logado, faça o login novamente'
            ]);
        }

        return response()->json([
            'error' => false,
            'data' => $user->favorites()->with(['barber'])->get()
        ]);
    }

    public function addFavorites(Request $request)
    {
        $this->validate($request, [
            'barber_id' => 'required|exists:barbers,id',
        ]);

        $barber = Barber::with(['favoriteds'])->find($request->barber_id);
        if (!$barber) {
            return response()->json([
                'error' => true,
                'message' => 'Este barbeiro não existe'
            ]);
        }

        $message = $barber->toggleFavorite(auth()->user()->id);

        return response()->json([
            'error' => false,
            'message' => $message
        ]);
    }

    public function getAppointment()
    {
        $user = User::with(['appointments'])->find(auth()->user()->id);
        if (!$user) {
            return response()->json([
                'error' => true,
                'message' => 'Você não está logado, faça o login novamente'
            ]);
        }
        return response()->json([
            'error' => false,
            'data' => $user->appointments()
                ->with(['barber','service'])->orderBy('appointment_datetime','DESC')->get()
        ]);
    }
}
